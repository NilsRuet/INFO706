import 'package:flutter/material.dart';
import 'package:info706/Student/Pages/skills_route.dart';
import 'package:info706/Teacher/StudentsSelection/student_selection_route.dart';
import 'Common/navigation_drawer_route.dart';
import 'Common/common_drawer.dart';
import 'Model/Cache/CacheManager.dart';
import 'Model/Data/User.dart';

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
