import 'package:firebase/auth/auth_page.dart';
import 'package:firebase/auth/verify-email.dart';
import 'package:flutter/material.dart';
// import 'package:firebase/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return VerifyEmailPage();
            // return home();
          } else {
            return AuthPage();
          }
        },
      ),
    );
  }
}
