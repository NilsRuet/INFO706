import 'User.dart';

// Différents niveaux d'une compétence
enum CompetencyLevel {A1, A2, B1, B2, C1, C2}

CompetencyLevel levelFromInt(int i){
  switch(i){
    case 1:
      return CompetencyLevel.A1;
    case 2:
      return CompetencyLevel.A2;
    case 3:
      return CompetencyLevel.B1;
    case 4:
      return CompetencyLevel.B2;
    case 5:
      return CompetencyLevel.C1;
    case 6:
      return CompetencyLevel.C2;
    default:
      return CompetencyLevel.A1;
  }
}

class SkillBlock{
  int _id;
  String title;

  int get id {
    return _id;
  }

  SkillBlock(Map<String, dynamic> json){
    this._id = json['block_id'];
    this.title = json['title'];
  }
}

// Une compétence qui peut-être acquise
abstract class Skill
{
  int id;
  int block_id;
  String name;
  CompetencyLevel level;

  //Constructeur par défaut à partir d'un json
  Skill(Map<String, dynamic> json){
    this.id = json['skill_id'];
    this.name = json['name'];
    this.level = levelFromInt(json['level']);
    this.block_id = json['id_block'];
  }
}

// Compétence commune à tous les étudiants
class GlobalSkill extends Skill
{
  GlobalSkill(Map<String, dynamic> json) : super(json);
}

// Compétence personnelle à un étudiant
class PersonalSkill extends Skill
{
  int ownerId;
  PersonalSkill(Map<String, dynamic> json) : super(json){
    ownerId = json['student_id'];
  }
}