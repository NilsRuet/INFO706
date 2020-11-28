import 'package:flutter/material.dart';
import 'package:info706/Model/Cache/CacheManager.dart';
import 'package:info706/View/home_route.dart';
import 'package:info706/View/Common/common_drawer.dart';
import 'package:info706/View/Student/Pages/skills_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:info706/authentication_service.dart';
import 'package:provider/provider.dart';
import 'package:info706/sign_in_page.dart';

Future<void> main() async{
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
            create: (context) => context.read<AuthenticationService>().authStateChanges,
        )
      ],
      child: MaterialApp(
        theme: ThemeData.dark(),
        home: AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return HomeView();
    }
    return SignInPage();
  }
}