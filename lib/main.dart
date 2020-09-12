import 'package:flutter/material.dart';
import 'package:info706/Resources/appColors.dart';
import 'Student/Pages/skillsPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: AppColors.PRIMARY_COLOR,
        scaffoldBackgroundColor: AppColors.SECONDARY_COLOR,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MySkillsPage(),
    );
  }
}