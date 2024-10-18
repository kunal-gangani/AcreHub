import 'package:acrehub/auth/login.dart';
import 'package:acrehub/auth/signup.dart';
import 'package:acrehub/auth/verification.dart';
import 'package:acrehub/screens/Homesrn.dart';
import 'package:acrehub/screens/bottombar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Error"),
            );
          } else {
            if (snapshot.data == null) {
              return const Loginsrn();
            } else {
              if (snapshot.data?.emailVerified == true) {
                return const Mainpage();
              }
              return const emailverify();
            }
          }
        },
      ),
    );
  }
}
