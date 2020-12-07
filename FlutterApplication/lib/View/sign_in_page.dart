import 'package:flutter/material.dart';
import 'package:info706/Model/Authentication/sign_in.dart';
import 'package:info706/Model/Cache/CacheManager.dart';
import 'package:info706/Model/Cache/DataManager.dart';
import 'package:info706/Model/Data/User.dart';
import 'package:info706/Resources/app_strings.dart';
import 'package:info706/View/home_route.dart';
import 'package:info706/main.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  AuthenticationWrapperState _parent;
  LoginPage(this._parent);

  @override
  _LoginPageState createState() => _LoginPageState(_parent);
}

class _LoginPageState extends State<LoginPage> {
  bool _isTeacherCheckbox = false;
  AuthenticationWrapperState _parent;

  _LoginPageState(this._parent);

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
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.ASK_ROLE,
                    style: TextStyle(fontSize: 25),
                  ),
                  Transform.scale(
                      scale: 1.5,
                      child:Checkbox(
                          value: _isTeacherCheckbox,
                          onChanged: (bool newVal) {
                            setState(() {
                              _isTeacherCheckbox = newVal;
                            });
                          })
                  ),
                ],
              ),
              SizedBox(height: 10),
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
    var isStudent = !_isTeacherCheckbox;
    SignIn.signInWithGoogle().then((result) async {
      if (result != null) {
        var user = await DataManager.authenticate(result, isStudent);
        if(user != null){
          _parent.setUser(user);
          CacheManager.rememberUser(user, user is Student);
        }
      }
    });
  }
}
