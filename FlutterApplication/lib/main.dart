import 'package:flutter/material.dart';
import 'package:info706/Model/Cache/CacheManager.dart';
import 'package:info706/Model/Data/User.dart' as model;
import 'package:info706/View/home_route.dart';
import 'package:info706/View/Common/common_drawer.dart';
import 'package:info706/View/Student/Pages/skills_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:info706/View/sign_in_page.dart';

import 'Model/Authentication/sign_in.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuth>(
          create: (_) => SignIn.getAuthInstance(),
        ),
        StreamProvider(
          create: (context) => context.read<FirebaseAuth>().authStateChanges(),
        )
      ],
      child: MaterialApp(
        title: 'INFO706',
        theme: ThemeData.dark(),
        home: AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AuthenticationWrapperState();
  }
}

class AuthenticationWrapperState extends State<AuthenticationWrapper> {
  Widget _currentView;
  bool _init;

  void setUser(model.User u) {
    setState(() {
      _currentView = HomeView(u);
    });
  }

  @override
  void initState() {
    super.initState();
    _init = false;
  }

  @override
  Widget build(BuildContext context) {
    if (!_init) {
      final firebaseUser = context.watch<User>();
      _currentView = firebaseUser != null
          ? HomeView(model.Student.placeholder("placeholder name"))
          : LoginPage(this);
      _init = true;
    }
    return _currentView;
  }
}
