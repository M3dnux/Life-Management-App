import 'package:firebase_auth/firebase_auth.dart' as FirebaseAuth show User;
import 'package:flutter/foundation.dart';

@immutable // everything inside this class can not be changed and classes that extends him must have const variables
class AuthUser {
  final bool isEmailVerified;
  const AuthUser({required this.isEmailVerified});

  factory AuthUser.fromFirebase(FirebaseAuth.User user) => AuthUser(
      isEmailVerified: user
          .emailVerified); // We made a copy of a firebase user ur own class "AuthUser"
}
