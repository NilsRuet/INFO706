import 'Skill.dart';

// Représente la validation d'une compétence par un élève
abstract class Assessment
{
  int _id;
  int _studentId;
  int _skillId;
  DateTime validationDate;

  int get id{
    return _id;
  }

  int get studentId {
    return _studentId;
  }

  int get skillId {
    return _skillId;
  }

  //Constructeur par défaut à partir d'un json
  Assessment(Map<String, dynamic> json){
    this._id = json['assessment_id'];
    this._studentId = json['student_id'];
    this._skillId = json['skill_id'];
    this.validationDate = DateTime.parse(json['validationDate']);
  }
}

// Auto validation d'une compétence
class SelfAssessment extends Assessment
{
  SelfAssessment(Map<String, dynamic> json) : super(json);

}

// Validation par un tiers d'une compétence
class TeacherAssessment extends Assessment
{
  int assessorId;

  TeacherAssessment(Map<String, dynamic> json) : super(json){
    assessorId = json['teacher_id'];
  }
}

// Classe pour regrouper toutes les informations d'une compétence pour un étudiant
class AssessedSkill{
  Skill skill;
  Assessment selfAssessment;
  Assessment teacherAssessment;
}