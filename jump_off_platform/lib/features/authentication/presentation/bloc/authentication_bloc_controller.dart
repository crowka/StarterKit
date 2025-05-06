// import 'package:shared/main.dart'; // FIXME: This import needs a proper solution.
// If it was for AuthenticationBloc, that's now local.

import 'authentication_bloc.dart'; // Or from './authentication_bloc_public.dart';

class AuthenticationBlocController {
  AuthenticationBlocController._();
  static final AuthenticationBlocController _instance = // Made final
      AuthenticationBlocController._();
  factory AuthenticationBlocController() => _instance;

  // ignore: close_sinks
  final AuthenticationBloc authenticationBloc = AuthenticationBloc(); // Made final
} 