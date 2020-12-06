abstract class Config{
  static final String host = "http://192.168.0.16:8080/";
  static final int timeoutDelay = 5;

  static String get authenticateURL{
    return host+"authenticate";
  }

  static String get studentsURL{
    return host+"students";
  }

  static String get addStudentURL{
    return host+"add_student";
  }

  static String deleteStudentURL(int id){
    return host+"delete_user/$id";
  }

  static String get updateStudentURL{
    return host+"update_student";
  }

  static String get teachersURL{
    return host+"teachers";
  }

  static String get addTeacherURL{
    return host+"add_teacher";
  }

  static String deleteTeacherURL(int id){
    return host+"delete_user/$id";
  }

  static String get updateTeacherURL{
    return host+"update_teacher";
  }

  static String get globalSkillsURL{
    return host+"global_skills";
  }

  static String get addGlobalSkillURL{
    return host+"add_global_skill";
  }

  static String deleteGlobalSkillURL(int id){
    return host+"delete_skill/$id";
  }

  static String get updateGlobalSkillURL{
    return host+"update_global_skill";
  }

  static String get skillsBlocksURL{
    return host+"skill_blocks";
  }

  static String get addSkillBlockURL{
    return host+"add_skill_block";
  }

  static String deleteSkillBlockURL(int id){
    return host+"delete_skill_block/$id";
  }

  static String get updateSkillBlockURL{
    return host+"update_skill_block";
  }

  static String personalSkillsURL(int id){
    return host+"skills_of/$id";
  }

  static String get addPersonalSkillURL{
    return host+"add_personal_skill";
  }

  static String deletePersonalSkillURL(int id){
    return host+"delete_skill/$id";
  }

  static String get updatePersonalSkillURL{
    return host+"update_personal_skill";
  }

  static String selfAssessmentsURL(int id) {
    return host+"self_assessments_of/$id";
  }

  static String get addSelfAssessmentURL{
    return host+"add_self_assessment";
  }

  static String deleteSelfAssessmentURL(int id){
    return host+"delete_assessment/$id";
  }

  static String teacherAssessmentsURL(int id) {
    return host+"teacher_assessments_of/$id";
  }

  static String get addTeacherAssessmentURL{
    return host+"add_teacher_assessment";
  }

  static String deleteTeacherAssessmentURL(int id){
    return host+"delete_assessment/$id";
  }
}