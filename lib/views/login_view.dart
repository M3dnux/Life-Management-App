import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:life_management_app/services/auth/auth_service.dart';
import 'package:life_management_app/services/auth/auth_exceptions.dart';
import 'package:life_management_app/utilities/form_widgets.dart';
import 'package:life_management_app/utilities/show_error_dialog.dart';
import 'package:life_management_app/constants/routes.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffbfaf2),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: 200.0,
            child: Stack(
              children: [
                Positioned(
                  left: -62.0,
                  top: -8.0,
                  child: Opacity(
                    opacity: 0.44,
                    child: Container(
                      width: 140.0,
                      height: 140.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff6cae75),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0.0,
                  top: -60.0,
                  child: Opacity(
                    opacity: 0.44,
                    child: Container(
                      width: 150.0,
                      height: 150.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff6cae75),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 98.0,
                  top: 0.0,
                  child: Opacity(
                    opacity: 0.44,
                    child: Container(
                      width: 38.0,
                      height: 160.0,
                      decoration: const BoxDecoration(
                        color: Color(0xff987284), // Rectangle color
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 98.0,
                  top: 80.0,
                  child: Container(
                    width: 38.0,
                    height: 160.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xfffbfaf2),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Opacity(
            opacity: 0.64,
            child: Text("Welcome :)",
                style: TextStyle(
                    color: Color(0xff6cae75),
                    fontWeight: FontWeight.bold,
                    fontSize: 32.0)),
          ),
          const SizedBox(height: 50.0),
          Container(
            margin: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
            child: Opacity(
              opacity: 0.66,
              child: getTextFieldDesign(
                  hintText: 'Email or Username',
                  field: _email,
                  isObscure: false),
            ),
          ),
          const SizedBox(height: 20.0),
          Container(
            margin: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
            child: Opacity(
              opacity: 0.66,
              child: getTextFieldDesign(
                hintText: 'Password',
                field: _password,
                isObscure: false,
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Container(
            margin: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
            child: Opacity(
              opacity: 0.66,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 55.0, // Set the height to match the TextField
                      child: getTextButtonDesign(
                          function: () async {
                            final email = _email.text;
                            final password = _password.text;
                            try {
                              await AuthService.firebase().logIn(
                                email: email,
                                password: password,
                              );
                              devtools
                                  .log('Email : $email / Password : $password');
                              final user = AuthService.firebase().currentUser;
                              if (user?.isEmailVerified ?? false) {
                                // user's email is verified
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  homeRoute,
                                  (route) => false,
                                );
                              } else {
                                // user's email is not verified
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  verifyEmailRoute,
                                  (route) => false,
                                );
                              }
                            } on UserNotFoundAuthException {
                              await showErrorDialog(
                                context,
                                'User not found',
                              );
                            } on WrongPasswordAuthException {
                              await showErrorDialog(
                                context,
                                'Wrong credentials',
                              );
                            } on GenericAuthException {
                              await showErrorDialog(
                                context,
                                'Authentication error',
                              );
                            }
                          },
                          text: 'LOGIN'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          const Text('Or login with',
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 20.0),
          Container(
            margin: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 10.0, 0),
                    child: TextButton.icon(
                      onPressed: () async {},
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(10.0),
                        backgroundColor: const Color(0xffdce8ff),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: const BorderSide(
                            color: Color(0xffdce8ff),
                          ),
                        ),
                      ),
                      icon: const FaIcon(
                        FontAwesomeIcons
                            .facebook, // Use FontAwesomeIcons for Google icon
                        // Color of the icon
                      ),
                      label: const Text(
                        'Facebook',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                    child: TextButton.icon(
                      onPressed: () async {},
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(10.0),
                        backgroundColor: const Color(0xffdce8ff),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: const BorderSide(
                            color: Color(0xffdce8ff),
                          ),
                        ),
                      ),
                      icon: const FaIcon(
                        FontAwesomeIcons
                            .google, // Use FontAwesomeIcons for Google icon
                        // Color of the icon
                      ),
                      label: const Text(
                        'Google',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                (route) => false,
              );
            },
            child: RichText(
              text: const TextSpan(
                text: 'Not a member? ',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight
                        .bold // Change the text color before "Signup now"
                    ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Signup now',
                    style: TextStyle(
                      color: Color(0xff6cae75),
                      decoration: TextDecoration
                          .underline, // Change the text color for "Signup now"
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
