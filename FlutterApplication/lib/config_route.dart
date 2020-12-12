import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'Info706Config.dart';

class ConfigRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var edit = TextEditingController(text:Config.host);
    return Scaffold(
      appBar: AppBar(
        title: Text("Configuration"),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Adresse du serveur (exemple : 192.168.0.1:8080)"),
            TextField(
              controller: edit,
            ),
            Spacer(),
            RaisedButton(
              child: Text("Valider"),
              onPressed: (){
                _writeConfig(edit.text);
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }

  void _writeConfig(String hostAddr) async{
    String wd = (await getApplicationDocumentsDirectory()).path;
    String filename = Config.configFile;
    String path = '$wd/$filename';
    final file = File(path);
    file.writeAsString('$hostAddr');
    Config.host = hostAddr;
  }
}