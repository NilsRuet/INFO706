
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:info706/Common/navigation_drawer_route.dart';
import 'package:info706/Model/Cache/CacheManager.dart';
import 'package:info706/Model/Data/User.dart';

class _StudentGridState extends State<StudentGrid>{

  List<Student> _students = List<Student>();
  List<Student> _filteredStudents = List<Student>();
  String _filter = "";

  @override
  void initState(){
    super.initState();
    _loadStudents();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: _filteredStudents.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 2
        ),
      itemBuilder: (BuildContext context, int index){
        return _getStudentWidget(_filteredStudents[index]);
      },
    );
  }

  Widget _getStudentWidget(Student student){
    return FlatButton(
      child:Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.grey[400],//TODO theme colors
              borderRadius: BorderRadius.circular(5)
          ),
          child: Container(
            margin: EdgeInsets.all(2),
            decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(5)
            ),
            child: Align(
                alignment: Alignment.center,
                child:Text(student.name)
            ),
          )
      ),
      onPressed: (){},//TODO
    );
  }

  bool matches(Student student, String filter){
    if(filter.length == 0) return true;
    return student.name.toLowerCase().startsWith(filter.toLowerCase());
  }

  void filter(String filter){
    setState(() {
      this._filter = filter;
      _filteredStudents = _students.where((student) => matches(student, _filter)).toList();
    });
  }

  void _loadStudents() async{
    final students = await CacheManager.getStudents();
    _updateStudents(students);
  }

  void _updateStudents(List<Student> students){
    setState(() {
      this._students = students;
      _filteredStudents = _students.where((student) => matches(student, _filter)).toList();
    });
  }
}

class StudentGrid extends StatefulWidget{

  _StudentGridState _currentState;

  @override
  State<StatefulWidget> createState(){
    _currentState = _StudentGridState();
    return _currentState;
  }

  void filter(String filter){
    _currentState.filter(filter);
  }
}