import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:info706/Model/Cache/CacheManager.dart';
import 'package:info706/Model/Cache/DataManager.dart';
import 'package:info706/Model/Data/Assessment.dart';
import 'package:info706/Model/Data/Skill.dart';
import 'package:info706/Model/Data/User.dart';
import 'package:info706/View/Common/navigation_drawer_route.dart';
import 'package:info706/Resources/app_strings.dart';
import 'package:info706/View/Teacher/StudentsSelection/student_grid.dart';


class MyStudentsDrawerView implements NavigationDrawerRoute{

  @override
  Widget build() {
    return StudentSelectionRoute();
  }

  @override
  String getViewName() {
    return  AppStrings.NAVIGATION_DRAWER[1];
  }
}

class StudentSelectionRoute extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      var studentGrid = StudentGrid();
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          getSearchBar(studentGrid.filter),
          Expanded(
            child: studentGrid
          )
        ],
      );
    }
  
    Widget getSearchBar(Function(String) action){
      return (
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[700],//TODO
            borderRadius: BorderRadius.circular(5)
          ),
          margin: EdgeInsets.fromLTRB(20,10,20,10),
          padding: EdgeInsets.all(2),
          child: IntrinsicHeight(
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0,0,2,0),
                      padding: EdgeInsets.all(5),
                      decoration:  BoxDecoration(
                          color: Colors.grey[800],//TODO
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: TextField(
                          style: TextStyle(
                            color: Colors.white,//TODO
                          ),
                          onChanged: (text) => action(text),
                      ),
                    )
                ),
                AspectRatio(
                  aspectRatio:1.0,
                  child:Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[800],//TODO
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: IconButton(
                      icon: Icon(Icons.search),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      );
    }
}