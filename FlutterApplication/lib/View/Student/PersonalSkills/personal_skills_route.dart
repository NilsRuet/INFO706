import 'package:flutter/material.dart';
import 'package:info706/Model/Data/Info.dart';
import 'package:info706/Model/Data/Skill.dart';
import 'package:info706/Model/Data/User.dart';
import 'package:info706/Resources/app_strings.dart';
import 'package:info706/View/Common/SkillsViews/skills_view.dart';
import 'package:info706/View/Common/navigation_drawer_route.dart';
import 'package:info706/View/Student/PersonalSkills/student_sorted_view_widget.dart';

/// Vue des compétences personnelles, du point de vue étudiant

class PersonalSkillsDrawerRoute implements NavigationDrawerRoute{
  @override
  Widget build() => _PersonalSkillsView();

  @override
  String getViewName() => AppStrings.MY_SKILLS_ROUTE_TITLE;
}

// ignore: must_be_immutable
class _PersonalSkillsView extends SkillsView {
  //TODO: l'étudiant doit être pris là où les infos perso sont stockées
  _PersonalSkillsView() : super(Student({'user_id': 1, 'name': 'Paul'}), AppStrings.MY_SKILLS_ROUTE_TITLE);


  @override
  SkillsViewState createState() => _PersonalSkillsViewState();
}

class _PersonalSkillsViewState extends SkillsViewState {
  _PersonalSkillsViewState():super.fromOverridingClass(StudentSortedBySkillBlockWidget(), StudentSortedByLevelWidget());

  @override
  Skill createEmptySkill() => PersonalSkill.fromData(0, 0, "", CompetencyLevel.A1, widget.currentStudent.id);

  @override
  Future<bool> createSkill(Skill skill) async => await SkillInfo.tryCreatePersonalSkill(skill);
}
