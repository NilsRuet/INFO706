import 'package:flutter/material.dart';
import 'package:info706/Model/Data/User.dart';
import 'package:info706/Resources/app_strings.dart';
import 'package:info706/View/Common/SkillsViews/skills_view.dart';
import 'package:info706/View/Common/navigation_drawer_route.dart';
import 'package:info706/View/Student/PersonalSkills/student_sorted_view_widget.dart';

/// Vue des compétences personnelles, du point de vue étudiant

class PersonalSkillsDrawerRoute implements NavigationDrawerRoute{

  Student _student;

  PersonalSkillsDrawerRoute(this._student);

  @override
  Widget build() => _PersonalSkillsView(_student);

  @override
  String getViewName() => AppStrings.MY_SKILLS_ROUTE_TITLE;
}

// ignore: must_be_immutable
class _PersonalSkillsView extends SkillsView {
  _PersonalSkillsView(Student s) : super(s, AppStrings.MY_SKILLS_ROUTE_TITLE);

  @override
  SkillsViewState createState() => _PersonalSkillsViewState();
}

class _PersonalSkillsViewState extends SkillsViewState {
  _PersonalSkillsViewState():super.fromOverridingClass(StudentSortedBySkillBlockWidget(), StudentSortedByLevelWidget());
}
