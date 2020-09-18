import 'package:flutter/material.dart';
import 'package:info706/Student/Pages/skillsPage.dart';
import 'package:info706/Teacher/StudentListRoute.dart';

import 'Resources/appStrings.dart';
import 'Student/Common/studentDrawer.dart';

class HomeRoute extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

enum ViewState {Skills, Students}

class HomeState extends State<HomeRoute>{
  ViewState currentPage = ViewState.Students;
  Widget _skills = MySkillsPage();
  Widget _students = StudentListRoute();

  @override
  Widget build(BuildContext context) {
    var page = currentPage==ViewState.Students?_students:_skills;
    return Scaffold(
        appBar: _pageAppBar(),
        floatingActionButton: _addButton(),
        drawer: StudentDrawer.getDrawer(context,'Name would be here',this),
        body : page
    );
  }

  void setView(ViewState page){
   setState(() {
     currentPage = page;
     Navigator.pop(context);
   });
  }

  AppBar _pageAppBar() {
    return AppBar(
      title: Text('Salut'),
      centerTitle: true,
    );
  }

  FloatingActionButton _addButton(){
    return FloatingActionButton(
      //onPressed : ,
      child: Icon(Icons.add),
    );
  }
}
