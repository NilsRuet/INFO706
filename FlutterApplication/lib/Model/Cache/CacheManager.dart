import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:info706/Config.dart';
import 'package:info706/Model/Data/User.dart';
import 'package:path_provider/path_provider.dart';

abstract class CacheManager{
  //Constantes pour les noms de champs dans les données sauvegardées
  static String _date = "saveDate";
  static String _content = "content";
  static String _jsonRootKeyword = "response";

  //Constantes pour les noms de fichier qui contiennent des données
  static String _userListReponseName = "USERS";

  // Mets dans le cache la réponse à une requête
  static void _cacheResponse(String fileName, String content) async{
    var data = Map<String, dynamic>();
    data[_date] = DateTime.now().toString();
    data[_content] = content;
    final rawData = jsonEncode(data);

    String wd = (await getApplicationDocumentsDirectory()).path;
    String path = '$wd/$fileName';

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
    final stringContent = await _getContent(Config.studentsURL, _userListReponseName);
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
}