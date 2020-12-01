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

  static String _datetimeToString(DateTime time){
    return time.year.toString()+"-"+time.month.toString()+"-"+time.day.toString();
  }

  //Crée un étudiant avec le nom spécifié, renvoie l'objet étudiant correspondant
  static Future<Student> createStudent(String name) async{
    Map data = {'name': name };
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

  //Crée un enseignant avec le nom spécifié, renvoie l'objet enseignant correspondant
  static Future<Teacher> createTeacher(String name) async{
    Map data = {'name': name };
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

  //Crée un bloc de compétences
  static Future<SkillBlock> createSkillBlock(String title) async{
    Map data = {'title': title };
    final response = await http.post(
      Config.addSkillBlockUrl,
      body: data,
    );
    if (response.statusCode == 201) {
      // 201 CREATED response,
      var block = SkillBlock(jsonDecode(response.body));
      return block;
    } else {
      return null;
    }
  }

  //Crée une compétence commune
  static Future<GlobalSkill> createGlobalSkill(String name, CompetencyLevel level, int blockId) async{
    Map data = {'name': name,
                'level': levelToInt(level).toString(),
                'block_id':blockId.toString()};
    final response = await http.post(
      Config.addGlobalSkillUrl,
      body: data,
    );
    if (response.statusCode == 201) {
      // 201 CREATED response,
      var skill = GlobalSkill(jsonDecode(response.body));
      return skill;
    } else {
      return null;
    }
  }

  //Crée une compétence personnelle
  static Future<PersonalSkill> createPersonalSkill(String name, CompetencyLevel level, int blockId, int studentId) async{
    Map data = {'name': name,
                'level': levelToInt(level).toString(),
                'block_id':blockId.toString(),
                'student_id':studentId.toString()};
    final response = await http.post(
      Config.addPersonalSkillUrl,
      body: data,
    );
    if (response.statusCode == 201) {
      // 201 CREATED response,
      var skill = PersonalSkill(jsonDecode(response.body));
      return skill;
    } else {
      return null;
    }
  }

  //Crée une auto évaluation
  static Future<SelfAssessment> createSelfAssessment(int studentId, int skillId) async{
    Map data = {'student_id': studentId.toString(),
                'skill_id': skillId.toString(),
                'validation_date':_datetimeToString(DateTime.now())};
    final response = await http.post(
      Config.addSelfAssessmentUrl,
      body: data,
    );
    if (response.statusCode == 201) {
      // 201 CREATED response,
      var assessment = SelfAssessment(jsonDecode(response.body));
      return assessment;
    } else {
      return null;
    }
  }

  //Crée une auto évaluation
  static Future<TeacherAssessment> createTeacherAssessment(int studentId, int skillId, int assessorId) async{
    Map data = {'student_id': studentId.toString(),
                'skill_id': skillId.toString(),
                'assessor_id': assessorId.toString(),
                'validation_date':_datetimeToString(DateTime.now())};
    final response = await http.post(
      Config.addTeacherAssessmentUrl,
      body: data,
    );
    if (response.statusCode == 201) {
      // 201 CREATED response,
      var assessment = TeacherAssessment(jsonDecode(response.body));
      return assessment;
    } else {
      return null;
    }
  }
}