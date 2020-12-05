import 'User.dart';

// Différents niveaux d'une compétence
enum CompetencyLevel {A1, A2, B1, B2, C1, C2}

// Une compétence qui peut-être acquise
abstract class Skill
{
  int _id;
  String name;
  CompetencyLevel level;

  int get id {
    return _id;
  }
}

// Compétence commune à tous les étudiants
class GlobalSkill extends Skill
{

}

// Compétence personnelle à un étudiant
class PersonalSkill extends Skill
{
  Student owner;
}