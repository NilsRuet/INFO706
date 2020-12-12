import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:info706/Model/Authentication/sign_in.dart';
import 'package:info706/Model/Cache/CacheManager.dart';
import 'package:info706/Model/Cache/DataManager.dart';
import 'package:info706/Model/Data/User.dart';
import 'package:info706/View/home_route.dart';
import 'package:info706/Resources/app_strings.dart';
import 'package:info706/View/Common/navigation_drawer_route.dart';
import 'package:info706/main.dart';

class _DrawerState extends State<NavigationDrawer>{
  @override
  Widget build(BuildContext context){
    return Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DrawerHeader(
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/'+widget.currentUser.picURL),
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
              ),
            ),
            FlatButton(
              color: ThemeData.dark().buttonColor,
              onPressed: (){
                CacheManager.forgetCurrentUser();
                widget.authentication.loadUser();
              },
              child: Text(AppStrings.LOG_OUT),
            )
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
  final AuthenticationWrapperState authentication;

  const NavigationDrawer ({ Key key, this.homeState, this.authentication, this.currentUser, this.views }): super(key: key);

  @override
  State<StatefulWidget> createState() => _DrawerState();
}


