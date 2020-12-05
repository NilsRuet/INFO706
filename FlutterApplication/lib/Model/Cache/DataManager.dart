import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:info706/Info706Config.dart';
import 'package:info706/Model/Data/Assessment.dart';
import 'package:info706/Model/Data/Skill.dart';
import 'package:info706/Model/Data/User.dart';

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

  static Future<bool> deleteStudent(Student s) async{
    final response = await http.delete(Config.deleteStudentURL(s.id));
    return response.statusCode == 202;
  }

  static Future<Student> updateStudent(Student s) async{
    Map data = {'id' : s.id.toString(),
                'name': s.name };
    final response = await http.put(
      Config.updateStudentURL,
      body: data,
    );
    if (response.statusCode == 200) {
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

  static Future<bool> deleteTeacher(Teacher t) async{
    final response = await http.delete(Config.deleteTeacherURL(t.id));
    return response.statusCode == 202;
  }

  static Future<Teacher> updateTeacher(Teacher t) async{
    Map data = {'id' : t.id.toString(),
                'name': t.name };
    final response = await http.put(
      Config.updateTeacherURL,
      body: data,
    );
    if (response.statusCode == 200) {
      var res = Teacher(jsonDecode(response.body));
      return res;
    } else {
      return null;
    }
  }

  //Crée un bloc de compétences
  static Future<SkillBlock> createSkillBlock(String title) async{
    Map data = {'title': title };
    final response = await http.post(
      Config.addSkillBlockURL,
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

  static Future<bool> deleteSkillBlock(SkillBlock sb) async{
    final response = await http.delete(Config.deleteSkillBlockURL(sb.id));
    return response.statusCode == 202;
  }

  static Future<SkillBlock> updateSkillBlock(SkillBlock sb) async{
    Map data = {'id' : sb.id.toString(),
                'title': sb.title };
    final response = await http.put(
      Config.updateSkillBlockURL,
      body: data,
    );
    if (response.statusCode == 200) {
      var res = SkillBlock(jsonDecode(response.body));
      return res;
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
      Config.addGlobalSkillURL,
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

  static Future<bool> deleteGlobalSkill(GlobalSkill s) async{
    return deleteGlobalSkillById(s.id);
  }

  static Future<bool> deleteGlobalSkillById(int id) async{
    final response = await http.delete(Config.deleteGlobalSkillURL(id));
    return response.statusCode == 202;
  }

  static Future<GlobalSkill> updateGlobalSkill(GlobalSkill s) async{
    Map data = {'id' : s.id.toString(),
                'name': s.name,
                'level': levelToInt(s.level).toString(),
                'block_id': s.blockId.toString()};
    final response = await http.put(
      Config.updateGlobalSkillURL,
      body: data,
    );
    if (response.statusCode == 200) {
      var res = GlobalSkill(jsonDecode(response.body));
      return res;
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
      Config.addPersonalSkillURL,
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

  static Future<bool> deletePersonalSkill(PersonalSkill s) async{
    return deletePersonalSkillById(s.id);
  }

  static Future<bool> deletePersonalSkillById(int id) async{
    final response = await http.delete(Config.deletePersonalSkillURL(id));
    return response.statusCode == 202;
  }

  static Future<PersonalSkill> updatePersonalSkill(PersonalSkill s) async{
    Map data = {'id' : s.id.toString(),
                'name': s.name,
                'level': levelToInt(s.level).toString(),
                'block_id': s.blockId.toString()};
    final response = await http.put(
      Config.updatePersonalSkillURL,
      body: data,
    );
    if (response.statusCode == 200) {
      var res = PersonalSkill(jsonDecode(response.body));
      return res;
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
      Config.addSelfAssessmentURL,
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

  static Future<bool> deleteSelfAssessment(SelfAssessment a) async{
    final response = await http.delete(Config.deleteSelfAssessmentURL(a.id));
    return response.statusCode == 202;
  }

  //Crée une auto évaluation
  static Future<TeacherAssessment> createTeacherAssessment(int studentId, int skillId, int assessorId) async{
    Map data = {'student_id': studentId.toString(),
                'skill_id': skillId.toString(),
                'assessor_id': assessorId.toString(),
                'validation_date':_datetimeToString(DateTime.now())};
    final response = await http.post(
      Config.addTeacherAssessmentURL,
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

  static Future<bool> deleteTeacherAssessment(TeacherAssessment a) async{
    final response = await http.delete(Config.deleteSelfAssessmentURL(a.id));
    return response.statusCode == 202;
  }
}