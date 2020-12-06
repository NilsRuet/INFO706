import 'package:flutter/material.dart';
import 'package:info706/Model/Data/User.dart';
import 'package:info706/View/Student/PersonalSkills/personal_skills_route.dart';
import 'package:info706/View/Teacher/GlobalSkills/global_skills_route.dart';
import 'package:info706/View/Teacher/StudentsSelection/student_selection_route.dart';
import 'package:info706/View/Common/navigation_drawer_route.dart';
import 'package:info706/View/Common/common_drawer.dart';
import 'package:info706/Model/Cache/CacheManager.dart';
import 'package:info706/Model/Data/User.dart';
import 'package:info706/main.dart';

import 'Common/debug_view.dart';

class HomeView extends StatefulWidget {
  final User _currentUser;
  final AuthenticationWrapperState _parent;

  HomeView(this._currentUser, this._parent);

  @override
  HomeState createState() => HomeState(_currentUser);
}

class HomeState extends State<HomeView>{
  NavigationDrawerRoute currentPage;
  User _currentUser;

  HomeState(this._currentUser);

  @override
  void initState() {
    super.initState();
    currentPage = (_currentUser is Student)
    ? PersonalSkillsDrawerRoute(_currentUser)
    : GlobalSkillsDrawerRoute();
  }

  @override
  Widget build(BuildContext context) {
    User s = _currentUser;//TODO remove
    return Scaffold(
        //appBar: _pageAppBar(),
        //floatingActionButton: _addButton(),
        drawer: NavigationDrawer(
          homeState: this,
          authentication: widget._parent,
          views: _currentUser is Student
              ? [PersonalSkillsDrawerRoute(_currentUser)]
              : [MyStudentsDrawerView(), GlobalSkillsDrawerRoute()],
          currentUser: s,
        ),
        body : currentPage.build()//TODO default page
    );
  }

  void setView(NavigationDrawerRoute page){
   setState(() {
     currentPage = page;
     Navigator.pop(context);
   });
  }
}
