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

  static String get globalSkillsURL{
    return host+"global_skills";
  }

  static String get skillsBlocksURL{
    return host+"skill_blocks";
  }

  static String personalSkillsURL(int id){
    return host+"skills_of/$id";
  }

  static String selfAssessmentsURL(int id) {
    return host+"self_assessments_of/$id";
  }

  static String teacherAssessmentsURL(int id) {
    return host+"teacher_assessments_of/$id";
  }


}