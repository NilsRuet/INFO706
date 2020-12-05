import 'package:flutter/material.dart';
import 'package:info706/Model/Data/User.dart';
import 'package:info706/View/Student/PersonalSkills/personal_skills_route.dart';
import 'package:info706/View/Teacher/GlobalSkills/global_skills_route.dart';
import 'package:info706/View/Teacher/StudentsSelection/student_selection_route.dart';
import 'package:info706/View/Common/navigation_drawer_route.dart';
import 'package:info706/View/Common/common_drawer.dart';

import 'Common/debug_view.dart';

class HomeView extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}
class HomeState extends State<HomeView>{
  NavigationDrawerRoute currentPage;

  @override
  Widget build(BuildContext context) {
    Student s = Student.placeholder("Utilisateur courant");//TODO remove
    return Scaffold(
        //appBar: _pageAppBar(),
        //floatingActionButton: _addButton(),
        drawer: NavigationDrawer(
          homeState: this,
          views: [PersonalSkillsDrawerRoute(), MyStudentsDrawerView(), DebugView(), GlobalSkillsDrawerRoute()],
          currentUser: s,
        ),
        body : currentPage==null?PersonalSkillsDrawerRoute().build():currentPage.build()//TODO default page
    );
  }

  void setView(NavigationDrawerRoute page){
   setState(() {
     currentPage = page;
     Navigator.pop(context);
   });
  }

  /*AppBar _pageAppBar() {
    return AppBar(
      title: Text('Salut'),
      centerTitle: true,
    );
  }*/

 /* FloatingActionButton _addButton(){
    return FloatingActionButton(
      //onPressed : ,
      child: Icon(Icons.add),
    );
  }*/
}
