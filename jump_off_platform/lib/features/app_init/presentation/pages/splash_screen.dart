import '../../../core/constants/color_constants.dart';
import '../../../core/constants/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// TODO: Verify AuthenticationBloc and related states/events imports after auth feature is processed
// Assuming AuthenticationBloc, AuthenticationState etc. will be available from the auth feature
// For now, these might be unresolved:
import '../../authentication/presentation/bloc/authentication_bloc.dart'; // Placeholder path

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthenticationBloc authenticationBloc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.secondaryAppColor,
        body: BlocListener<AuthenticationBloc, AuthenticationState>(
          bloc: authenticationBloc,
          listener: (BuildContext context, AuthenticationState state) {
            // Assuming AppAuthenticated, AuthenticationStart, UserLogoutState are part of AuthenticationState
            // These might need to be imported from auth_state.dart for example
            if (state is AppAutheticated) { // Typo: AppAuthenticated?
              Navigator.pushNamed(context, '/home');
            }
            if (state is AuthenticationStart) {
              Navigator.pushNamed(context, '/auth');
            }
            if (state is UserLogoutState) {
              Navigator.pushNamed(context, '/auth');
            }
          },
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              bloc: authenticationBloc,
              builder: (BuildContext context, AuthenticationState state) {
                return Center(child: Image.asset(AllImages().logo));
              }),
        ));
  }

  @override
  void initState() {
    // TODO: Resolve AuthenticationBlocController() or replace with DI
    // authenticationBloc = AuthenticationBlocController().authenticationBloc;
    // For now, let's assume it will be injected or located via GetIt if we follow the guide
    // Example: authenticationBloc = serviceLocator<AuthenticationBloc>();
    // This line will cause an error until auth feature and DI are set up:
    // authenticationBloc.add(AppLoadedup()); // AppLoadedup event - ensure this is defined
    super.initState();
    // Temporary init for auth bloc, actual DI needed later
    // If AuthenticationBloc is available in context via GetIt or Provider
    // try {
    //   authenticationBloc = context.read<AuthenticationBloc>();
    //   authenticationBloc.add(AppLoadedup());
    // } catch (e) {
    //   print("Error getting AuthenticationBloc: $e. Ensure it is provided.");
    // }
  }
} 