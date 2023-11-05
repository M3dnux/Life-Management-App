import 'package:flutter/material.dart';
import 'package:life_management_app/constants/routes.dart';
import 'package:life_management_app/services/auth/auth_exceptions.dart';
import 'package:life_management_app/utilities/form_widgets.dart';
import 'package:life_management_app/utilities/show_error_dialog.dart';
import 'package:life_management_app/services/auth/auth_service.dart';
import 'dart:developer' as devtools show log;

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _fullName;
  late final TextEditingController _userName;
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _rePassword;

  @override
  void initState() {
    _fullName = TextEditingController();
    _userName = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    _rePassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _fullName.dispose();
    _userName.dispose();
    _email.dispose();
    _password.dispose();
    _rePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffbfaf2),
      body: Center(
        child: Stack(
          children: [
            Positioned.fill(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Positioned(
                      right: 30,
                      top: -270,
                      child: Opacity(
                        opacity: 0.44,
                        child: Container(
                          width: 500,
                          height: 500,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff6cae75),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 30,
                      bottom: -270,
                      child: Opacity(
                        opacity: 0.44,
                        child: Container(
                          width: 500,
                          height: 500,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff6cae75),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Opacity(
                  opacity: 0.64,
                  child: Text("Welcome onboard!",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 32.0)),
                ),
                const Text("Let's help you better manage your time."),
                const SizedBox(height: 50.0),
                Container(
                  margin: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
                  child: Opacity(
                    opacity: 0.66,
                    child: getTextFieldDesign(
                      hintText: 'Enter your full name',
                      field: _fullName,
                      isObscure: false,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Container(
                  margin: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
                  child: Opacity(
                    opacity: 0.66,
                    child: getTextFieldDesign(
                        hintText: 'Choose a username',
                        field: _userName,
                        isObscure: false),
                  ),
                ),
                const SizedBox(height: 20.0),
                Container(
                  margin: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
                  child: Opacity(
                    opacity: 0.66,
                    child: getTextFieldDesign(
                      hintText: 'Enter your Email',
                      field: _email,
                      isObscure: false,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Container(
                  margin: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
                  child: Opacity(
                    opacity: 0.66,
                    child: getTextFieldDesign(
                        hintText: 'Enter password',
                        field: _password,
                        isObscure: false),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  margin: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
                  child: Opacity(
                    opacity: 0.66,
                    child: getTextFieldDesign(
                        hintText: 'Confirm password',
                        field: _rePassword,
                        isObscure: false),
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
                            height:
                                55.0, // Set the height to match the TextField
                            child: getTextButtonDesign(
                                function: () async {
                                  final email = _email.text;
                                  final password = _password.text;
                                  try {
                                    devtools.log("got here");
                                    await AuthService.firebase().createUser(
                                      email: email,
                                      password: password,
                                    );
                                    devtools.log("got here after creating");
                                    await AuthService.firebase()
                                        .sendEmailVerification();
                                    devtools.log(
                                        'Email : $email / Password : $password');
                                    Navigator.of(context)
                                        .pushNamed(verifyEmailRoute);
                                  } on WeakPasswordAuthException {
                                    await showErrorDialog(
                                        context, 'Wrong password');
                                  } on EmailAlreadyInUseAuthException {
                                    await showErrorDialog(
                                        context, 'Email is already in use');
                                  } on InvalidEmailAuthException {
                                    await showErrorDialog(context,
                                        'This is an invalid email address');
                                  } on GenericAuthException {
                                    await showErrorDialog(
                                      context,
                                      'Failed to register',
                                    );
                                  }
                                },
                                text: 'REGISTER'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                // TextButton(
                //   onPressed: () async {
                //     final email = _email.text;
                //     final password = _password.text;
                //     try {
                //       devtools.log("got here");
                //       await AuthService.firebase().createUser(
                //         email: email,
                //         password: password,
                //       );
                //       devtools.log("got here after creating");
                //       await AuthService.firebase().sendEmailVerification();
                //       devtools.log('Email : $email / Password : $password');
                //       Navigator.of(context).pushNamed(verifyEmailRoute);
                //     } on WeakPasswordAuthException {
                //       await showErrorDialog(context, 'Wrong password');
                //     } on EmailAlreadyInUseAuthException {
                //       await showErrorDialog(context, 'Email is already in use');
                //     } on InvalidEmailAuthException {
                //       await showErrorDialog(
                //           context, 'This is an invalid email address');
                //     } on GenericAuthException {
                //       await showErrorDialog(
                //         context,
                //         'Failed to register',
                //       );
                //     }
                //   },
                //   child: const Text('Register'),
                // ),

                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      loginRoute,
                      (route) => false,
                    );
                  },
                  child: RichText(
                    text: const TextSpan(
                      text: 'Already registered? ',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight
                              .bold // Change the text color before "Signup now"
                          ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Login here!',
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
