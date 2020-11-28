import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:info706/Info706Config.dart';
import 'package:info706/Model/Data/Assessment.dart';
import 'package:info706/Model/Data/Skill.dart';
import 'package:info706/Model/Data/User.dart';
import 'package:path_provider/path_provider.dart';

abstract class DataManager{

  //Récupère la liste de tous les étudiants
  static Future<Student> createStudent(String name) async{
    Map data = {'name': name};
    final response = await http.post(
      Config.addStudentURL,
      body: data,
    );
    print(jsonEncode(data));
    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print("Succes ajout");
      return Student(jsonDecode(response.body));
    } else {
      print("Erreur");
    }
  }
}