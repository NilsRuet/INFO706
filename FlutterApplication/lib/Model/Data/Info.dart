// Toutes les informations concernant une compétence pour une personne
import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:info706/Model/Cache/CacheManager.dart';
import 'package:info706/Model/Data/Assessment.dart';
import 'Skill.dart';

class SkillInfo
{
  String name;
  CategoryInfo category;
  CompetencyLevel level;
  bool isAutoChecked;
  bool isCheckedByTeacher;

  SkillInfo(this.name, this.category, this.level, this.isAutoChecked, this.isCheckedByTeacher){
    BlocksListInfo.getLevelBlock(level).add(this);
    BlocksListInfo.getCategoryBlock(category).add(this);
  }
}

class CategoryInfo
{
  String name;
  int index;

  CategoryInfo(this.name, this.index);
}

class BlockInfo
{
  String name;
  List<SkillInfo> skills;

  BlockInfo(this.name){
    skills = [];
  }

  void add(SkillInfo skill) {
    skills.add(skill);
  }
}

class BlocksListInfo
{
  static SplayTreeMap<int, BlockInfo> _sortedByLevel = SplayTreeMap();
  static List<BlockInfo> get sortedByLevel => _sortedByLevel.values.toList();

  static SplayTreeMap<String, BlockInfo> _sortedByCategory = SplayTreeMap();
  static List<BlockInfo> get sortedByCategory => _sortedByCategory.values.toList();

  static BlockInfo getLevelBlock(CompetencyLevel level) {
    if (!_sortedByLevel.containsKey(level.index))
      _sortedByLevel[level.index] = BlockInfo(describeEnum(level));
    return _sortedByLevel[level.index];
  }

  static BlockInfo getCategoryBlock(CategoryInfo category) {
    String catName = category.name;
    if (!_sortedByCategory.containsKey(catName))
      _sortedByCategory[catName] = BlockInfo(catName);
    return _sortedByCategory[catName];
  }

  static void clear() {
    _sortedByCategory.clear();
    _sortedByLevel.clear();
  }

}

class InfoManager
{
  static const STUDENTID = 1; // TODO stocker ça au bon endroit
  static loadSkillRouteInformation() async{
    loadSelectedStudentSkillsRouteInformation(STUDENTID);
  }

  static void _debugLoading() {

    CategoryInfo ce = CategoryInfo('Compréhension écrite', 1);
    CategoryInfo co = CategoryInfo('Compréhension orale', 2);
    CategoryInfo ee = CategoryInfo('Expression écrite', 3);
    CategoryInfo eo = CategoryInfo('Expression orale', 4);

    SkillInfo('Je peux lire des textes courts très simples.',
        ce, CompetencyLevel.A2, true, true);
    SkillInfo('Je peux comprendre la description d\'événements, l\'expression de sentiments et de souhaits dans des lettres personnelles.',
        ce, CompetencyLevel.B1, false, false);
    SkillInfo('Je peux comprendre des mots familiers et des expressions très courantes au sujet de moi-même, de ma famille et de l\'environnement concret et immédiat, si les gens parlent lentement et distinctement.',
        co, CompetencyLevel.A1, true, true);
    SkillInfo('Je peux comprendre les émissions de télévision et les films sans trop d\'effort.',
        co, CompetencyLevel.C1, false, false);
    SkillInfo('Je peux écrire des textes clairs et détaillés sur une grande gamme desujets relatifs à mes intérêts.',
        ee, CompetencyLevel.B2, false, false);
    SkillInfo('Je peux comprendre les livres sans trop d\'effort.',
        ce, CompetencyLevel.C2, false, false);
    SkillInfo('Je peux utiliser une série de phrases ou d\'expressions pour décrire en termes simples ma famille et d\'autres gens, mes conditions de vie, ma formation et mon activité professionnelle actuelle ou récente.',
        eo, CompetencyLevel.A2, true, true);
    SkillInfo('Je peux raconter une histoire ou l\'intrigue d\'un livre ou d\'un film et exprimer mes réactions.',
        eo, CompetencyLevel.B1, true, true);
  }

  static loadSelectedStudentSkillsRouteInformation(int studentId) async {
    BlocksListInfo.clear();
    //_debugLoading();
    // On récupère les catégories
    List<SkillBlock> categories = await CacheManager.getSkillBlocks();
    Map<int, CategoryInfo> idCategories = Map();
    categories.forEach((element) {idCategories.putIfAbsent(element.id, () => CategoryInfo(element.title, element.id%4));});

    // On récupère les auto validations
    List<SelfAssessment> selfAssessments = await CacheManager.getSelfAssessedSkills(studentId);
    List<int> selfAssessedSkillsIds = List();
    selfAssessments.forEach((element) {selfAssessedSkillsIds.add(element.skillId);});

    // On récupère les validations par un enseignant
    List<TeacherAssessment> teacherAssessments = await CacheManager.getTeacherAssessedSkills(studentId);
    List<int> teacherAssessedSkillsIds = List();
    teacherAssessments.forEach((element) {teacherAssessedSkillsIds.add(element.skillId);});

    // On récupère enfin les compétences
    List<Skill> skills = List();
    skills.addAll((await CacheManager.getGlobalSkills()));
    skills.addAll(await CacheManager.getPersonalSkills(studentId));
    skills.forEach((element) {
    SkillInfo(element.name, idCategories[element.blockId],
    element.level,
    selfAssessedSkillsIds.contains(element.id),
    teacherAssessedSkillsIds.contains(element.id));
    });
  }
}
