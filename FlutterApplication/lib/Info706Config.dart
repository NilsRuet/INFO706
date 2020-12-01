abstract class Config{
  static final String host = "http://192.168.0.16:8080/";
  static final int timeoutDelay = 5;

  static String get studentsURL{
    return host+"students";
  }

  static String get addStudentURL{
    return host+"add_student";
  }

  static String get teachersURL{
    return host+"teachers";
  }

  static String get addTeacherURL{
    return host+"add_teacher";
  }

  static String get globalSkillsURL{
    return host+"global_skills";
  }

  static String get addGlobalSkillUrl{
    return host+"add_global_skill";
  }

  static String get skillsBlocksURL{
    return host+"skill_blocks";
  }

  static String get addSkillBlockUrl{
    return host+"add_skill_block";
  }

  static String personalSkillsURL(int id){
    return host+"skills_of/$id";
  }

  static String get addPersonalSkillUrl{
    return host+"add_personal_skill";
  }

  static String selfAssessmentsURL(int id) {
    return host+"self_assessments_of/$id";
  }

  static String get addSelfAssessmentUrl{
    return host+"add_self_assessment";
  }

  static String teacherAssessmentsURL(int id) {
    return host+"teacher_assessments_of/$id";
  }

  static String get addTeacherAssessmentUrl{
    return host+"add_teacher_assessment";
  }


}