import 'package:flutter/material.dart';
import 'HomeRoute.dart';
import 'Student/Common/studentDrawer.dart';
import 'Student/Pages/skillsPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark(),
        home: HomeRoute()
    );
  }
}
