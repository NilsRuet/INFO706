import 'package:flutter/material.dart';
import 'package:info706/Model/Data/Info.dart';
import 'package:info706/Resources/app_strings.dart';
import 'package:info706/View/Common/SkillsViews/skills_view.dart';
import 'package:info706/View/Common/navigation_drawer_route.dart';

import 'global_sorted_view_widget.dart';

/// Vue des compétences globales

class GlobalSkillsDrawerRoute implements NavigationDrawerRoute{
  @override
  Widget build() => _GlobalSkillsView();

  @override
  String getViewName() => AppStrings.GLOBAL_SKILLS_ROUTE_TITLE;
}

// ignore: must_be_immutable
class _GlobalSkillsView extends SkillsView {
  _GlobalSkillsView() : super.globalView(AppStrings.GLOBAL_SKILLS_ROUTE_TITLE);

  @override
  SkillsViewState createState() => _GlobalSkillsViewState();
}

class _GlobalSkillsViewState extends SkillsViewState {
  _GlobalSkillsViewState():super.fromOverridingClass(GlobalSortedBySkillBlockWidget(), GlobalSortedByLevelWidget());

  @override
  void loadDataForDisplay() async {
    await InfoManager.loadGlobalSkillsRouteInformation();
    updateDataForDisplay();
  }
}
