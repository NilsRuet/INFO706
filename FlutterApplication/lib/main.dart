import 'package:flutter/material.dart';
import 'package:info706/View/home_route.dart';

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
