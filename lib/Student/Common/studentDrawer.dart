import 'package:flutter/material.dart';
import 'package:info706/HomeRoute.dart';
import 'package:info706/Resources/appStrings.dart';
import 'package:info706/Student/Pages/skillsPage.dart';
import 'package:info706/Teacher/StudentListRoute.dart';

class StudentDrawer {

  static Drawer getDrawer(BuildContext context,String name,HomeState homeState){
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            child: Align(
                child:Text(
                    name,
                    textAlign: TextAlign.center
                )
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: <Widget>[
              ListTile(
                title: Text(
                    AppStrings.NAVIGATION_DRAWER[0],
                    textAlign: TextAlign.center
                ),
                onTap: () {
                  homeState.setView(ViewState.Skills);
                },
              ),
              ListTile(
                title: Text(
                    AppStrings.NAVIGATION_DRAWER[1],
                    textAlign: TextAlign.center
                ),
                onTap: () {
                  homeState.setView(ViewState.Students);
                },
              )
            ],
          ),
        ],
      )
    );
  }
}


