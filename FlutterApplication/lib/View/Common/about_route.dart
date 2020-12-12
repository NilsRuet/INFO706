import 'package:flutter/material.dart';
import 'package:info706/Model/Data/Info.dart';
import 'package:info706/Model/Data/Skill.dart';
import 'package:info706/Model/Data/User.dart';
import 'package:info706/Resources/app_strings.dart';
import 'package:info706/View/Common/SkillsViews/skills_view.dart';
import 'package:info706/View/Common/navigation_drawer_route.dart';
import 'package:info706/View/Student/PersonalSkills/student_sorted_view_widget.dart';

/// Vue des compétences personnelles, du point de vue étudiant

class AboutDrawerRoute implements NavigationDrawerRoute{

  @override
  Widget build() => _AboutView();

  @override
  String getViewName() => "A propos...";
}

class _AboutView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("A propos..."),
        centerTitle: true,
      ),
      body: Container(child: Center(child: Image(image: AssetImage('assets/About.png'),)),margin: EdgeInsets.all(8.0)));
  }
}