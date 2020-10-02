import 'package:flutter/material.dart';
import 'package:info706/Teacher/studentGridView.dart';

class StudentListRoute extends StatelessWidget {
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
            child:StudentGridView()
          )
        ],
      );
    }
  }