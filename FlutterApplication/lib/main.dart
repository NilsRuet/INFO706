import 'package:flutter/material.dart';
import 'package:info706/Model/Cache/CacheManager.dart';
import 'package:info706/Model/Data/User.dart' as model;
import 'package:info706/View/home_route.dart';
import 'package:info706/View/Common/common_drawer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:info706/View/sign_in_page.dart';
import 'package:info706/View/home_route.dart';

import 'Model/Authentication/sign_in.dart';
import 'Resources/app_strings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'INFO706',
      theme: ThemeData.dark(),
      home: AuthenticationWrapper(),
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

  void setUser(model.User u) {
    setState(() {
      _currentView = HomeView(u);
    });
  }

  Widget _getLoadingScreen() {
    return Scaffold(
      body: Center(
        child: Text(AppStrings.LOADING,
        style: TextStyle(
        fontSize: 20))),
    );
  }

  @override
  void initState() {
    super.initState();
    _currentView = _getLoadingScreen();
    loadUser();
  }

  void loadUser() async {
    var currentUser = await CacheManager.getCurrentUser();
    setState(() {
      _currentView =
          currentUser != null ? HomeView(currentUser) : LoginPage(this);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _currentView;
  }
}
