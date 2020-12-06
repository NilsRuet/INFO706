import 'package:flutter/material.dart';
import 'package:info706/Model/Data/User.dart';
import 'package:info706/View/home_route.dart';
import 'package:info706/Resources/app_strings.dart';
import 'package:info706/View/Common/navigation_drawer_route.dart';

class _DrawerState extends State<NavigationDrawer>{
  @override
  Widget build(BuildContext context){
    return Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.currentUser.picURL),
                    radius: 40.0,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(widget.currentUser.name,
                          style: TextStyle(
                            fontSize: 20
                          ),
                        ),
                        Text(widget.currentUser is Student ? AppStrings.STUDENT: AppStrings.TEACHER)
                      ],
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListView.builder(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: widget.views.length,
              itemBuilder: (context, index) => _getDrawerViewListTile(widget.views[index])
            ),
          ],
        )
    );
  }

  ListTile _getDrawerViewListTile(NavigationDrawerRoute view) {
      return ListTile(
        title: Text(
            view.getViewName(),
            textAlign: TextAlign.center
        ),
        onTap: () {
          widget.homeState.setView(view);
        },
      );
  }
}

class NavigationDrawer extends StatefulWidget{
  final HomeState homeState;
  final List<NavigationDrawerRoute> views;
  final User currentUser;

  const NavigationDrawer ({ Key key, this.homeState, this.currentUser, this.views }): super(key: key);

  @override
  State<StatefulWidget> createState() => _DrawerState();
}


