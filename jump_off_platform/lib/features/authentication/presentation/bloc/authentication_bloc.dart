import 'package:bloc/bloc.dart';
// import 'package:shared/main.dart'; // FIXME: This import and 'prefs' need a proper solution
import 'package:shared_preferences/shared_preferences.dart'; // Assuming direct import for now

// Updated BLoC event/state imports
import 'authentication_event.dart';
import 'authentication_state.dart';

// Updated model imports
import '../../../data/models/current_user_data_model.dart';
import '../../../domain/entities/token.dart'; // Assuming Token is directly usable
import '../../../data/models/user_data_model.dart';

// Updated repository import
import '../../../data/repositories/authentication_repository_impl.dart';
import '../../../domain/repositories/authentication_repository.dart';


class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  // TODO: Inject repository
  final AuthenticationRepository authenticationService =
      AuthenticationRepositoryImpl();
  
  // TODO: Inject SharedPreferences or a wrapper for 'prefs'
  // For now, direct usage for compilation, but this is not ideal.
  Future<SharedPreferences> get prefs async => await SharedPreferences.getInstance();


  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AppLoadedup>(_mapAppSignUpLoadedState);
    on<UserSignUp>(_mapUserSignupToState);
    on<UserLogin>(_mapUserLoginState);
    on<UserLogOut>((event, emit) async {
      final SharedPreferences sharedPreferences = await prefs;
      sharedPreferences.clear();
      emit(UserLogoutState());
    });
    on<GetUserData>((event, emit) async {
      final SharedPreferences sharedPreferences = await prefs;
      int currentUserId = sharedPreferences.getInt('userId');
      // TODO: Ensure getUserData returns a type that can be parsed by CurrentUserDataModel.fromJson
      final data = await authenticationService.getUserData(currentUserId ?? 4);
      final currentUserData = CurrentUserDataModel.fromJson(data);
      emit(SetUserData(currentUserData: currentUserData));
    });
  }

  void _mapAppSignUpLoadedState(
      AppLoadedup event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading()); // emit loading state
    try {
      await Future.delayed(Duration(milliseconds: 500)); // a simulated delay
      final SharedPreferences sharedPreferences = await prefs;
      if (sharedPreferences.getString('authtoken') != null) {
        emit(AppAutheticated());
      } else {
        emit(AuthenticationStart());
      }
    } catch (e) {
      emit(AuthenticationFailure(
          message: e.toString() ?? 'An unknown error occurred')); // Use e.toString()
    }
  }

  void _mapUserLoginState(
      UserLogin event, Emitter<AuthenticationState> emit) async {
    final SharedPreferences sharedPreferences = await prefs;
    emit(AuthenticationLoading());
    try {
      await Future.delayed(Duration(milliseconds: 500)); 
      // TODO: Ensure loginWithEmailAndPassword returns a type that can be parsed by Token.fromJson
      // and contains 'error' key on failure.
      final data = await authenticationService.loginWithEmailAndPassword(
          event.email, event.password);
      if (data["error"] == null) {
        final currentUser = Token.fromJson(data); // Token is simple, might be okay
        if (currentUser != null && currentUser.token != null) { // check token itself
          sharedPreferences.setString('authtoken', currentUser.token);
          emit(AppAutheticated());
        } else {
          emit(AuthenticationNotAuthenticated());
        }
      } else {
        emit(AuthenticationFailure(message: data["error"].toString())); // ensure message is string
      }
    } catch (e) {
      emit(AuthenticationFailure(
          message: e.toString() ?? 'An unknown error occurred'));
    }
  }

  void _mapUserSignupToState(
      UserSignUp event, Emitter<AuthenticationState> emit) async {
    final SharedPreferences sharedPreferences = await prefs;
    emit(AuthenticationLoading());
    try {
      await Future.delayed(Duration(milliseconds: 500));
      // TODO: Ensure signUpWithEmailAndPassword returns a type that can be parsed by UserDataModel.fromJson
      // and contains 'error' key on failure.
      final data = await authenticationService.signUpWithEmailAndPassword(
          event.email, event.password);

      if (data["error"] == null) {
        final currentUser = UserDataModel.fromJson(data);
        if (currentUser != null && currentUser.token != null && currentUser.id != null) { // check token and id
          sharedPreferences.setString('authtoken', currentUser.token);
          sharedPreferences.setInt('userId', currentUser.id);
          emit(AppAutheticated());
        } else {
          emit(AuthenticationNotAuthenticated());
        }
      } else {
        emit(AuthenticationFailure(message: data["error"].toString())); // ensure message is string
      }
    } catch (e) {
      emit(AuthenticationFailure(
          message: e.toString() ?? 'An unknown error occurred'));
    }
  }
} 