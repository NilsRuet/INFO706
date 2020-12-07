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

class HomeState extends State<HomeView> {
  NavigationDrawerRoute currentPage;
  User _currentUser;

  User get user{
    return _currentUser;
  }

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
    User s = _currentUser;
    return Scaffold(
        drawer: NavigationDrawer(
          homeState: this,
          authentication: widget._parent,
          views: _currentUser is Student
              ? [PersonalSkillsDrawerRoute(_currentUser)]
              : [MyStudentsDrawerView(_currentUser as Teacher), GlobalSkillsDrawerRoute()],
          currentUser: s,
        ),
        body: _getDrawerBody(() => print("open")));//TODO
  }

  Widget _getDrawerBody(void openDrawerCallback()) {
    return Stack(
      children: [
        currentPage.build(),
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Align(
            child: GestureDetector(
              onTap: openDrawerCallback,
              child: Transform.scale(
                scale: 0.8,
                origin: Offset(-20,0),
                child: Container(
                  height: MediaQuery.of(context).size.height / 5,
                  color: Color.fromRGBO(0, 0, 0, 0.3),
                  child: Icon(Icons.keyboard_arrow_right),
                ),
              ),
            ),
            alignment: Alignment.centerLeft,
          ),
        )
      ],
    );
  }

  void setView(NavigationDrawerRoute page) {
    setState(() {
      currentPage = page;
      Navigator.pop(context);
    });
  }
}
