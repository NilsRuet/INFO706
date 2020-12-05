import 'Skill.dart';

// Représente la validation d'une compétence par un élève
abstract class Assessment
{
  int _studentId;
  int _skillId;
  DateTime validationDate;

  int get studentId {
    return _studentId;
  }

  int get sillId {
    return _skillId;
  }
}

// Auto validation d'une compétence
class SelfAssessment extends Assessment
{

}

// Validation par un tiers d'une compétence
class TeacherAssessment extends Assessment
{
  int _assessorId;
}

// Classe pour regrouper toutes les informations d'une compétence pour un étudiant
class AssessedSkill{
  Skill skill;
  Assessment selfAssessment;
  Assessment teacherAssessment;
}