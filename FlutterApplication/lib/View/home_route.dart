import 'package:flutter/material.dart';
import 'package:info706/View/Student/Pages/skills_route.dart';
import 'package:info706/View/Teacher/StudentsSelection/student_selection_route.dart';
import 'package:info706/View/Common/navigation_drawer_route.dart';
import 'package:info706/View/Common/common_drawer.dart';
import 'package:info706/Model/Cache/CacheManager.dart';
import 'package:info706/Model/Data/User.dart';

class HomeView extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}
class HomeState extends State<HomeView>{
  NavigationDrawerRoute currentPage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //appBar: _pageAppBar(),
        //floatingActionButton: _addButton(),
        drawer: NavigationDrawer(
          homeState: this,
          views: [MySkillsDrawerRoute(), MyStudentsDrawerView()],
          name: "Common drawer",
        ),
        body : currentPage==null?MySkillsDrawerRoute().build():currentPage.build()//TODO default page
    );
  }

  void somePrint(String s){
    print(s);
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

  FloatingActionButton _addButton(){
    return FloatingActionButton(
      //onPressed : ,
      child: Icon(Icons.add),
    );
  }
}