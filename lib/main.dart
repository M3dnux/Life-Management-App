import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:life_management_app/constants/routes.dart';
import 'package:life_management_app/services/auth/auth_service.dart';
import 'package:life_management_app/views/login_view.dart';
import 'package:life_management_app/views/register_view.dart';
import 'package:life_management_app/views/home_view.dart';
import 'package:life_management_app/views/verify_email_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    home: const RoutePage(),
    routes: {
      loginRoute: (context) => const LoginView(),
      registerRoute: (context) => const RegisterView(),
      homeRoute: (context) => const HomeView(),
      verifyEmailRoute: (context) => const VerifyEmailView(),
    },
  ));
}

class RoutePage extends StatelessWidget {
  const RoutePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AuthService.firebase().initialise(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = AuthService.firebase().currentUser;
              if (user != null) {
                if (user.isEmailVerified) {
                  return const HomeView();
                } else {
                  return const VerifyEmailView();
                }
              } else {
                return const LoginView();
              }

            // print(user);
            // final emailVerified = user?.emailVerified ?? false;
            // if (emailVerified) {
            //   print('you are verified');
            // } else {
            //   print('You are not verified');
            //   return const VerifyEmailView();
            // }
            default:
              return const SpinKitThreeInOut(
                color: Color(0xff6cae75),
                size: 50.0,
              );
          }
        });
  }
}
