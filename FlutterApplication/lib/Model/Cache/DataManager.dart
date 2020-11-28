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
    if (response.statusCode == 201) {
      // 201 CREATED response,
      var student = Student(jsonDecode(response.body));
      return student;
    } else {
      return null;
    }
  }

  //Récupère la liste de tous les étudiants
  static Future<Teacher> createTeacher(String name) async{
    Map data = {'name': name};
    final response = await http.post(
      Config.addTeacherURL,
      body: data,
    );
    if (response.statusCode == 201) {
      // 201 CREATED response,
      var teacher = Teacher(jsonDecode(response.body));
      return teacher;
    } else {
      return null;
    }
  }
}