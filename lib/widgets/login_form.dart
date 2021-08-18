import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_authentication/blocs/login_bloc.dart';
import 'package:mobile_authentication/widgets/seperator.dart';

/// Actual login form, with validation, asking for email and password
class LoginForm extends StatefulWidget {
  const LoginForm();

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void loginButtonPressed(BuildContext context) {
    context.read<CredentialsBloc>().add(LoginButtonPressed(
          userName: emailController.text,
          password: passwordController.text,
        ));
  }

  void registerButtonPressed(BuildContext context) {
    context.read<CredentialsBloc>().add(RegisterButtonPressed(
          userName: emailController.text,
          password: passwordController.text,
        ));
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, data) {
        var baseWidth = 250.0;

        // For wider screen, such as tablets
        if (data.maxWidth <= baseWidth) {
          baseWidth = data.maxWidth / 1.4;
        }

        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlutterLogo(size: 70),

              const Separator(50),

              Form(
                key: formKey,
                child: Wrap(
                  direction: Axis.vertical,
                  spacing: 20,
                  children: <Widget>[
                    SizedBox(
                      width: baseWidth - 30,
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email),
                          hintText: "username",
                        ),
                        validator: (value) =>
                            value!.length > 10 && value.contains("@")
                                ? null
                                : "invalid_field",
                        controller: emailController,
                      ),
                    ),
                    SizedBox(
                      width: baseWidth - 30,
                      child: TextFormField(
                        obscureText: true,
                        validator: (value) =>
                            value!.length > 5 ? null : 'invalid_field',
                        controller: passwordController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.vpn_key),
                          hintText: "password",
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Separator(25),

              // Login
              BlocConsumer<CredentialsBloc, CredentialsState>(
                listener: (context, state) {
                  if (state is CredentialLoginFailure) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      duration: const Duration(seconds: 2),
                      content: Text("error_login"),
                    ));
                  }
                },
                builder: (context, state) {
                  if (state is CredentialLoginLoading) {
                    return const CircularProgressIndicator();
                  }

                  return RaisedButton(
                    key: Key("loginButton"),
                    child: Text("login"),
                    color: Colors.lightGreen,
                    textColor: Colors.white,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        loginButtonPressed(context);
                      }
                    },
                  );
                },
              ),

              const Separator(5),

              // Register
              BlocConsumer<CredentialsBloc, CredentialsState>(
                listener: (context, state) {
                  if (state is CredentialRegisterFailure) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      duration: const Duration(seconds: 2),
                      content: Text("register_login"),
                    ));
                  }
                },
                builder: (context, state) {
                  if (state is CredentialRegisterLoading) {
                    return const CircularProgressIndicator();
                  }

                  return RaisedButton(
                    key: Key("registerButton"),
                    child: Text("register"),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        registerButtonPressed(context);
                      }
                    },
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }
}
