import 'package:flutter/material.dart';
import 'package:info706/Common/navigation_drawer_route.dart';
import 'package:info706/Resources/app_strings.dart';
import 'package:info706/Teacher/StudentsSelection/student_grid.dart';


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
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,

        children: [
          IntrinsicHeight(
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10,0,10,0),
                      child: TextField(
                        decoration: new InputDecoration(
                            filled: true,
                            fillColor: Colors.blueGrey
                        ),
                      ),
                    )
                ),
                AspectRatio(
                  aspectRatio:1.0,
                  child:Container(
                    color: Colors.blueGrey,
                    child: IconButton(
                      icon: Icon(Icons.search),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child:StudentGrid()
          )
        ],
      );
    }
  }