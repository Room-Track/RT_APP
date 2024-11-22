import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:room_track_flutterapp/views/auth/signin_page.dart';
import 'package:room_track_flutterapp/views/home/home_layout.dart';

class Authlayout extends StatelessWidget {
  const Authlayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeLayout();
          } else {
            return const SignInPage();
          }
        },
      ),
    );
  }
}
