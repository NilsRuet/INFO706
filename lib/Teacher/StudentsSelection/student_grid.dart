
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:info706/Common/navigation_drawer_route.dart';

class _StudentGridState extends State<StudentGrid>{

  List<String> names = ["Alain","Bastien","Ceopzj","jsdpfksdf","kljfdssdfkj"];//TODO

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: names.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3),
      itemBuilder: (BuildContext context, int index){
        return _getStudentWidget(names[index]);
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
}

class StudentGrid extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _StudentGridState();
}