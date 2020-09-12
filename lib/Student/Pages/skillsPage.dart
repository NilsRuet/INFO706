import 'package:flutter/material.dart';
import 'package:info706/Resources/appStrings.dart';
import 'package:info706/Student/Common/studentDrawer.dart';

// The Student skills page

class MySkillsPage extends StatefulWidget {
  @override
  _MySkillsPageState createState() => _MySkillsPageState();
}

class _MySkillsPageState extends State<MySkillsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.SKILLS_PAGE_TITLE),
        centerTitle: true,
      ),
      drawer: StudentDrawer(),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        onPressed: () {  },
        child: Icon(Icons.add),
      ),
    );
  }
}
