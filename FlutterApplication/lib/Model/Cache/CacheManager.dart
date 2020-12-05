import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:info706/Info706Config.dart';
import 'package:info706/Model/Data/Assessment.dart';
import 'package:info706/Model/Data/Skill.dart';
import 'package:info706/Model/Data/User.dart';
import 'package:path_provider/path_provider.dart';

abstract class CacheManager{
  //Constantes pour les noms de champs dans les données sauvegardées
  static String _date = "saveDate";
  static String _content = "content";
  static String _jsonRootKeyword = "response";

  //Constantes pour les noms de fichier qui contiennent des données
  static String _userListResponseName = "USERS";
  static String _teacherListResponseName = "TEACHERS";
  static String _globalSkillsResponseName = "GLOBALSKILLS";
  static String _skillBlocksResponseName = "SKILLBLOCKS";
  static String _personalSkillsResponseName(int id){ return "PERSONNALSKILLS$id";}
  static String _selfAssessmentsResponseName(int id){ return "SELFASSESSMENTS$id";}
  static String _teacherAssessmentsResponseName(int id){ return "TEACHERASSESSMENTS$id";}

  // Mets dans le cache la réponse à une requête
  static void _cacheResponse(String fileName, String content) async{
    var data = Map<String, dynamic>();
    data[_date] = DateTime.now().toString();
    data[_content] = content;
    final rawData = jsonEncode(data);

    String wd = (await getApplicationDocumentsDirectory()).path;
    String path = '$wd/$fileName';
<<<<<<< HEAD

=======
>>>>>>> develop
    final file = File(path);
    file.writeAsString('$rawData');
  }

  // Lit dans le cache la réponse à une requête faite précédemment
  static Future<String> _getCachedResponse(String filename) async{
    String wd = (await getApplicationDocumentsDirectory()).path;
    String path = '$wd/$filename';
    final file = File(path);
    if(await file.exists()){
      //TODO ajouter les actions d'écritures en cache
      final rawData =  jsonDecode(await file.readAsString());
      return rawData[_content];
    } else {
      return null;
    }
  }

  //Récupère des données, soit à l'aide d'une requête, soit à l'aide du cache
  static Future<String> _getContent(String url, String cacheName) async{
    try{
      final response = await http.get(url).timeout(new Duration(seconds: Config.timeoutDelay));
      if(response.statusCode == 200){
        _cacheResponse(cacheName, response.body);
        return response.body;
      } else {
        //TODO
      }
    } on TimeoutException catch (e){
      //TODO
    } on SocketException catch (e){
      //TODO
    }
    return _getCachedResponse(cacheName);
  }

  //Récupère la liste de tous les étudiants
  static Future<List<Student>> getStudents() async{
    List<Student> res = List();
    final stringContent = await _getContent(Config.studentsURL, _userListResponseName);
    if(stringContent != null){
      final data = (jsonDecode(stringContent));
      final studentsRaw = data[_jsonRootKeyword];
      if(studentsRaw is List){
        List list = studentsRaw;
        list.forEach((element) => res.add(Student(element)));
      }
    }
    return res;//TODO valeur spéciale pour quand les données n'ont pas pu être récupérées
  }

  //Récupère la liste de tous les enseignants
  static Future<List<Teacher>> getTeachers() async{
    List<Teacher> res = List();
    final stringContent = await _getContent(Config.teachersURL, _teacherListResponseName);
    if(stringContent != null){
      final data = (jsonDecode(stringContent));
      final teachersRaw = data[_jsonRootKeyword];
      if(teachersRaw is List){
        List list = teachersRaw;
        list.forEach((element) => res.add(Teacher(element)));
      }
    }
    return res;//TODO valeur spéciale pour quand les données n'ont pas pu être récupérées
  }

  //Récupère la liste de toutes les compétences communes
  static Future<List<GlobalSkill>> getGlobalSkills() async{
    List<GlobalSkill> res = List();
    final stringContent = await _getContent(Config.globalSkillsURL, _globalSkillsResponseName);
    if(stringContent != null){
      final data = (jsonDecode(stringContent));
      final skillsRaw = data[_jsonRootKeyword];
      if(skillsRaw is List){
        List list = skillsRaw;
        list.forEach((element) => res.add(GlobalSkill(element)));
      }
    }
    return res;//TODO valeur spéciale pour quand les données n'ont pas pu être récupérées
  }

  //Récupère la liste des compétences propres à un étudiant
  static Future<List<PersonalSkill>> getPersonalSkills(int studentId) async{
    List<PersonalSkill> res = List();
    final stringContent = await _getContent(Config.personalSkillsURL(studentId), _personalSkillsResponseName(studentId));
    if(stringContent != null){
      final data = (jsonDecode(stringContent));
      final skillsRaw = data[_jsonRootKeyword];
      if(skillsRaw is List){
        List list = skillsRaw;
        list.forEach((element) => res.add(PersonalSkill(element)));
      }
    }
    return res;//TODO valeur spéciale pour quand les données n'ont pas pu être récupérées
  }

  //Récupère la liste des compétences autovalidées d'un étudiant
  static Future<List<SelfAssessment>> getSelfAssessedSkills(int studentId) async{
    List<SelfAssessment> res = List();
    final stringContent = await _getContent(Config.selfAssessmentsURL(studentId), _selfAssessmentsResponseName(studentId));
    if(stringContent != null){
      final data = (jsonDecode(stringContent));
      final assessmentsRaw = data[_jsonRootKeyword];
      if(assessmentsRaw is List){
        List list = assessmentsRaw;
        list.forEach((element) => res.add(SelfAssessment(element)));
      }
    }
    return res;//TODO valeur spéciale pour quand les données n'ont pas pu être récupérées
  }

  //Récupère la liste des compétences autovalidées d'un étudiant
  static Future<List<TeacherAssessment>> getTeacherAssessedSkills(int studentId) async{
    List<TeacherAssessment> res = List();
    final stringContent = await _getContent(Config.teacherAssessmentsURL(studentId), _teacherAssessmentsResponseName(studentId));
    if(stringContent != null){
      final data = (jsonDecode(stringContent));
      final assessmentsRaw = data[_jsonRootKeyword];
      if(assessmentsRaw is List){
        List list = assessmentsRaw;
        list.forEach((element) => res.add(TeacherAssessment(element)));
      }
    }
    return res;//TODO valeur spéciale pour quand les données n'ont pas pu être récupérées
  }

  //Récupère la liste des blocs de compétences
  static Future<List<SkillBlock>> getSkillBlocks() async{
    List<SkillBlock> res = List();
    final stringContent = await _getContent(Config.skillsBlocksURL, _skillBlocksResponseName);
    if(stringContent != null){
      final data = (jsonDecode(stringContent));
      final blocksRaw = data[_jsonRootKeyword];
      if(blocksRaw is List){
        List list = blocksRaw;
        list.forEach((element) => res.add(SkillBlock(element)));
      }
    }
    return res;//TODO valeur spéciale pour quand les données n'ont pas pu être récupérées
  }
}