import 'package:jump_off_platform/features/onboarding/presentation/pages/login_screen.dart';
import 'package:jump_off_platform/features/onboarding/presentation/pages/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
// TODO: Update this import once the authentication module is migrated
// import 'package:shared/main.dart';
// TODO: Replace with actual AuthenticationBloc import from features/authentication/presentation/bloc/
// For now, using a placeholder if not available, or it might cause an error.
// Consider commenting out bloc-related code until migration is complete.

class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  bool showLoginForm = false;
  // ignore: close_sinks
  // TODO: Initialize AuthenticationBloc via DI (e.g., GetIt) once migrated
  // AuthenticationBloc authenticationBloc;
  dynamic authenticationBloc; // Placeholder type

  @override
  Widget build(BuildContext context) {
    void _showError(String error) async {
      await Fluttertoast.showToast(
          msg: error,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    return Scaffold(
        body: WillPopScope(
      onWillPop: () async => false,
      // TODO: Ensure AuthenticationBloc is provided in the widget tree
      child: BlocListener<dynamic, dynamic>( // Placeholder for AuthenticationBloc, AuthenticationState
        bloc: authenticationBloc,
        listener: (context, state) {
          // TODO: Update state checks once AuthenticationState is available
          // if (state is AuthenticationFailure) {
          //   _showError(state.message);
          // }
        },
        // TODO: Ensure AuthenticationBloc is provided for BlocBuilder
        child: BlocBuilder<dynamic, dynamic>( // Placeholder for AuthenticationBloc, AuthenticationState
            bloc: authenticationBloc,
            builder: (BuildContext context, dynamic state) { // Placeholder for AuthenticationState
              return SafeArea(
                child: Stack(
                  children: [
                    Center(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Center(
                              child: Text(
                            showLoginForm ? 'LOGIN' : 'SIGN UP',
                            style: Theme.of(context).textTheme.headline2,
                          )),
                          Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: showLoginForm
                                ? LoginForm(
                                    authenticationBloc: authenticationBloc,
                                    state: state,
                                  )
                                : SignUpForm(
                                    authenticationBloc: authenticationBloc,
                                    state: state,
                                  ),
                          ),
                          showLoginForm
                              ? SizedBox()
                              : Padding(
                                  padding: const EdgeInsets.all(32.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        height: 38,
                                      ),
                                      Text('Already have an account?'),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      ElevatedButton(
                                          child: Text(
                                            'Login',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              showLoginForm = true;
                                            });
                                          })
                                    ],
                                  ),
                                )
                        ],
                      ),
                    ),
                    !showLoginForm
                        ? SizedBox()
                        : Positioned(
                            left: 6,
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                size: 32,
                                color: Theme.of(context).primaryColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  showLoginForm = false;
                                });
                              },
                            ),
                          )
                  ],
                ),
              );
            }),
      ),
    ));
  }

  @override
  void initState() {
    // TODO: Initialize AuthenticationBloc via DI (e.g., GetIt) once migrated
    // This line will cause an error until AuthenticationBlocController is available and migrated.
    // authenticationBloc = AuthenticationBlocController().authenticationBloc;
    super.initState();
  }
} 