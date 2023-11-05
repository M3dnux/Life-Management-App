import 'package:flutter/material.dart';
import 'package:life_management_app/constants/routes.dart';
import 'package:life_management_app/services/auth/auth_service.dart';
import 'package:life_management_app/utilities/form_widgets.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Opacity(
              opacity: 0.64,
              child: Text(
                "We've sent you an email verification.",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
            ),
            const Opacity(
              opacity: 0.64,
              child: Text(
                "Please open it to verify your account.",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0),
              ),
            ),
            const SizedBox(height: 40.0),
            const Opacity(
              opacity: 0.64,
              child: Text(
                "If you haven't recived a verification email yet, press the link below",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0),
              ),
            ),
            TextButton(
              onPressed: () async {
                await AuthService.firebase().sendEmailVerification();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  loginRoute,
                  (route) => false,
                );
              },
              child: const Text('Re-send email verification'),
            ),
            getTextButtonDesign(
              function: () async {
                await AuthService.firebase().logOut();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  registerRoute,
                  (route) => false,
                );
              },
              text: 'CLOSE',
            ),
          ],
        ),
      ),
    );
  }
}
