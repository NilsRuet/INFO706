import 'package:flutter/material.dart';
import 'home_route.dart';
import 'Common/common_drawer.dart';
import 'Student/Pages/skills_route.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark(),
        home: HomeView()
    );
  }
}
