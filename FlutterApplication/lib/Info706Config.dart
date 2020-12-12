import 'dart:io';

import 'package:path_provider/path_provider.dart';

abstract class Config{

  static final String configFile = "appserver.config";

  static String host = "127.0.0.1:8080";
  static String get hostRoot => "http://"+host+"/";

  static void readHost() async{
    String wd = (await getApplicationDocumentsDirectory()).path;
    String path = '$wd/$configFile';
    final file = File(path);
    if(file.existsSync()){
      String hostAddr = file.readAsStringSync();
      host = hostAddr;
    } else {
      host = "127.0.0.1:8080";
    }
  }

  static final int timeoutDelay = 10;

  static String get authenticateURL{
    return hostRoot+"authenticate";
  }

  static String get studentsURL{
    return hostRoot+"students";
  }

  static String get addStudentURL{
    return hostRoot+"add_student";
  }

  static String deleteStudentURL(int id){
    return hostRoot+"delete_user/$id";
  }

  static String get updateStudentURL{
    return hostRoot+"update_student";
  }

  static String get teachersURL{
    return hostRoot+"teachers";
  }

  static String get addTeacherURL{
    return hostRoot+"add_teacher";
  }

  static String deleteTeacherURL(int id){
    return hostRoot+"delete_user/$id";
  }

  static String get updateTeacherURL{
    return hostRoot+"update_teacher";
  }

  static String get globalSkillsURL{
    return hostRoot+"global_skills";
  }

  static String get addGlobalSkillURL{
    return hostRoot+"add_global_skill";
  }

  static String deleteGlobalSkillURL(int id){
    return hostRoot+"delete_skill/$id";
  }

  static String get updateGlobalSkillURL{
    return hostRoot+"update_global_skill";
  }

  static String get skillsBlocksURL{
    return hostRoot+"skill_blocks";
  }

  static String get addSkillBlockURL{
    return hostRoot+"add_skill_block";
  }

  static String deleteSkillBlockURL(int id){
    return hostRoot+"delete_skill_block/$id";
  }

  static String get updateSkillBlockURL{
    return hostRoot+"update_skill_block";
  }

  static String personalSkillsURL(int id){
    return hostRoot+"skills_of/$id";
  }

  static String get addPersonalSkillURL{
    return hostRoot+"add_personal_skill";
  }

  static String deletePersonalSkillURL(int id){
    return hostRoot+"delete_skill/$id";
  }

  static String get updatePersonalSkillURL{
    return hostRoot+"update_personal_skill";
  }

  static String selfAssessmentsURL(int id) {
    return hostRoot+"self_assessments_of/$id";
  }

  static String get addSelfAssessmentURL{
    return hostRoot+"add_self_assessment";
  }

  static String deleteSelfAssessmentURL(int id){
    return hostRoot+"delete_assessment/$id";
  }

  static String teacherAssessmentsURL(int id) {
    return hostRoot+"teacher_assessments_of/$id";
  }

  static String get addTeacherAssessmentURL{
    return hostRoot+"add_teacher_assessment";
  }

  static String deleteTeacherAssessmentURL(int id){
    return hostRoot+"delete_assessment/$id";
  }
}