import 'package:flutter/material.dart';
import 'package:info706/Model/Authentication/sign_in.dart';
import 'package:info706/Model/Cache/DataManager.dart';
import 'package:info706/View/home_route.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlutterLogo(size: 150),
              SizedBox(height: 50),
              _signInButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInButton() {
    return OutlineButton(
      onPressed: authenticateCallback,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  authenticateCallback() {
    SignIn.signInWithGoogle().then((result) {
      if (result != null) {
        /*var user = DataManager.GetUser(result);
        if(user != null){

        } else {
          // choix de rôle et inscription
        }*/
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return HomeView();
            },
          ),
        );
      }
    });
  }
}
