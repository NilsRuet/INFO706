
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:info706/Common/navigation_drawer_route.dart';

class _StudentGridState extends State<StudentGrid>{

  List<String> _students = ["Alain","Bastien","Ccc","Xavier","Alex","Jean","Jeanne","qdqsdf","sdlflkjl","soepo","dsmfksqdfkm"];//TODO student class
  List<String> _filteredStudents;
  String _filter = "";

  @override
  Widget build(BuildContext context) {
    _filteredStudents = _students.where((student) => matches(student, _filter)).toList();
    return GridView.builder(
      itemCount: _filteredStudents.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3),
      itemBuilder: (BuildContext context, int index){
        return _getStudentWidget(_filteredStudents[index]);
      },
    );
  }

  Widget _getStudentWidget(String name){//TODO student class
    return Align(
        alignment: Alignment.center,
        child:FlatButton(
          child:Text(name),
          onPressed: (){},//TODO
        )
    );
  }

  bool matches(String name, String filter){
    if(filter.length == 0) return true;
    return name.toLowerCase().startsWith(filter.toLowerCase());
  }

  void filter(String filter){
    setState(() {
      this._filter = filter;
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