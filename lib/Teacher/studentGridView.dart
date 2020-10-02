
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class _StudentGridState extends State<StudentGridView>{

  List<String> names = ["Alain","Bastien","Ceopzj","jsdpfksdf","kljfdssdfkj"];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: names.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3),
      itemBuilder: (BuildContext context, int index){
        return getStudentWidget(names[index]);
      },
    );
  }

  Widget getStudentWidget(String name){//TODO student class
    return Align(
        alignment: Alignment.center,
        child:FlatButton(
          child:Text(name),
          onPressed: (){},//TODO
        )
    );
  }
}

class StudentGridView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _StudentGridState();
}