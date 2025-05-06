import 'package:flutter/material.dart';
// TODO: Update this import once the authentication module is migrated
// import 'package:shared/main.dart';

// TODO: Replace with actual AuthenticationBloc and AuthenticationState imports
// from features/authentication/ once migrated.
// For now, using dynamic or placeholder types.

class LoginForm extends StatefulWidget {
  // final AuthenticationBloc authenticationBloc;
  // final AuthenticationState state;
  final dynamic authenticationBloc; // Placeholder type
  final dynamic state; // Placeholder type

  LoginForm({this.authenticationBloc, this.state});
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Email address',
              filled: true,
              isDense: true,
            ),
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email is required.';
              }
              return null;
            },
          ),
          SizedBox(
            height: 12,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Password',
              filled: true,
              isDense: true,
            ),
            obscureText: true,
            controller: _passwordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password is required.';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
              child: false // TODO: Replace with 'widget.state is AuthenticationLoading' check
                  ? CircularProgressIndicator(
                      // backgroundColor: Theme.of(context).textTheme.bodyText1?.color,
                    )
                  : Text('Login', style: Theme.of(context).textTheme.bodyText1),
              onPressed: () {
                if (_key.currentState?.validate() ?? false) {
                  // TODO: Replace UserLogin with actual event from BLoC once migrated
                  // widget.authenticationBloc.add(UserLogin(
                  //     email: _emailController.text,
                  //     password: _passwordController.text));
                } else {}
              })
        ],
      ),
    );
  }
} 