import 'package:flutter/material.dart';
import 'package:info706/Model/Cache/CacheManager.dart';
import 'package:info706/View/home_route.dart';
import 'package:info706/View/Common/common_drawer.dart';
import 'package:info706/View/Student/Pages/skills_route.dart';

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
