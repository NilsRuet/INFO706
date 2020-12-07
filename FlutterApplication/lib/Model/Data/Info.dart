// Toutes les informations concernant une compétence pour une personne
import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:info706/Model/Cache/CacheManager.dart';
import 'package:info706/Model/Cache/DataManager.dart';
import 'Assessment.dart';
import 'Skill.dart';

class SkillInfo
{
  Skill modelSkill;
  String get name => modelSkill.name;
  CompetencyLevel get level => modelSkill.level;

  CategoryInfo category;
  bool isAutoChecked;
  bool isCheckedByTeacher;
  int _teacherAssessmentId;
  bool isPersonal;
  int _selfAssessmentId;

  SkillInfo(this.modelSkill, this.category, this._selfAssessmentId, this._teacherAssessmentId, this.isPersonal){
    isCheckedByTeacher = _teacherAssessmentId != null;
    isAutoChecked = _selfAssessmentId != null;
    BlocksListInfo.getLevelBlock(level).add(this);
    BlocksListInfo.getCategoryBlock(category).add(this);
  }

  SkillInfo.withoutAssessment(this.modelSkill, this.category, this.isPersonal){
    BlocksListInfo.getLevelBlock(level).add(this);
    BlocksListInfo.getCategoryBlock(category).add(this);
  }

  Future<bool> delete() async {
    bool res = isPersonal? await DataManager.deletePersonalSkill(modelSkill): await DataManager.deleteGlobalSkill(modelSkill);
    if (!res)
      return false;

    // Utile si on reload pas la bdd
    /*BlocksListInfo.getLevelBlock(level).remove(this);
    BlocksListInfo.getCategoryBlock(category).remove(this);*/
    return true;
  }

  Future<bool> trySetIsCheckedByTeacher(bool checked) async {
    if (isCheckedByTeacher == checked)
      return true;

    if (checked) { //TODO l'assossor id doit être récupéré dans les données de l'user courant
      var assessment = await DataManager.createTeacherAssessment(InfoManager.currentStudentId, modelSkill.id, 1);
      if (assessment == null)
        return false;
      // Utile si on reload pas la bdd
      /*isCheckedByTeacher = true;
      _teacherAssessmentId = assessment.id;*/
    }else {
      if (!await DataManager.deleteTeacherAssessmentById(_teacherAssessmentId))
        return false;
      // Utile si on reload pas la bdd
      //isCheckedByTeacher = false;
    }
    return true;
  }

  Future<bool> trySetIsAutoChecked(bool checked) async{
    if (isAutoChecked == checked)
      return true;

    if (checked) {
      var assessment = await DataManager.createSelfAssessment(InfoManager.currentStudentId, modelSkill.id);
      if (assessment == null)
        return false;
      // Utile si on reload pas la bdd
      /*isAutoChecked = true;
      _selfAssessmentId = assessment.id;*/
    }else {
      if (!await DataManager.deleteSelfAssessmentById(_selfAssessmentId))
        return false;
      // Utile si on reload pas la bdd
      //isAutoChecked = false;
    }
    return true;
  }

  Future<bool> tryEdit(Skill skill) async {
    if (isPersonal)
      return (await DataManager.updatePersonalSkill(skill) != null);
    return (await DataManager.updateGlobalSkill(skill) != null);

  }

  static tryCreatePersonalSkill(Skill skill) async {
    return (await DataManager.createPersonalSkill(skill.name, skill.level, skill.blockId, InfoManager.currentStudentId) != null);
  }

  static tryCreateGlobalSkill(Skill skill) async {
    return (await DataManager.createGlobalSkill(skill.name, skill.level, skill.blockId) != null);
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
  List<SkillInfo> globalSkills;
  List<SkillInfo> personalSkills;

  BlockInfo(this.name){
    globalSkills = [];
    personalSkills = [];
  }

  void add(SkillInfo skill) {
    if (skill.isPersonal)
      personalSkills.add(skill);
    else
      globalSkills.add(skill);

  }

  void remove(SkillInfo skill) {
    if (skill.isPersonal)
      personalSkills.remove(skill);
    else
      globalSkills.remove(skill);
    if (personalSkills.isEmpty && globalSkills.isEmpty)
      BlocksListInfo.remove(this);
  }
}

class BlocksListInfo
{
  static SplayTreeMap<String, BlockInfo> _sortedByLevel = SplayTreeMap();

  static List<SkillBlock> modelCategoryBlocksList;
  static List<BlockInfo> get sortedByLevel => _sortedByLevel.values.toList();

  static SplayTreeMap<String, BlockInfo> _sortedByCategory = SplayTreeMap();
  static List<BlockInfo> get sortedByCategory => _sortedByCategory.values.toList();

  static BlockInfo getLevelBlock(CompetencyLevel level) {
    String levelName = describeEnum(level);
    if (!_sortedByLevel.containsKey(levelName))
      _sortedByLevel[describeEnum(level)] = BlockInfo(levelName);
    return _sortedByLevel[levelName];
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

  static void remove(BlockInfo block) {
    _sortedByCategory.remove(block.name);
    _sortedByLevel.remove(block.name);
  }

}

class InfoManager
{
  static int currentStudentId;
  static void _debugLoading() {

    /*CategoryInfo ce = CategoryInfo('Compréhension écrite', 1);
    CategoryInfo co = CategoryInfo('Compréhension orale', 2);
    CategoryInfo ee = CategoryInfo('Expression écrite', 3);
    CategoryInfo eo = CategoryInfo('Expression orale', 4);

    SkillInfo(1,'Je peux lire des textes courts très simples.',
        ce, CompetencyLevel.A2, 5, 1, false);
    SkillInfo(2,'Je peux comprendre la description d\'événements, l\'expression de sentiments et de souhaits dans des lettres personnelles.',
        ce, CompetencyLevel.B1, null, null, false);
    SkillInfo(3,'Je peux comprendre des mots familiers et des expressions très courantes au sujet de moi-même, de ma famille et de l\'environnement concret et immédiat, si les gens parlent lentement et distinctement.',
        co, CompetencyLevel.A1, 6, 2, false);
    SkillInfo(4,'Je peux comprendre les émissions de télévision et les films sans trop d\'effort.',
        co, CompetencyLevel.C1, null, null, false);
    SkillInfo(5,'Je peux écrire des textes clairs et détaillés sur une grande gamme desujets relatifs à mes intérêts.',
        ee, CompetencyLevel.B2, null, null, false);
    SkillInfo(6,'Je peux comprendre les livres sans trop d\'effort.',
        ce, CompetencyLevel.C2, null, null, false);
    SkillInfo(7,'Je peux utiliser une série de phrases ou d\'expressions pour décrire en termes simples ma famille et d\'autres gens, mes conditions de vie, ma formation et mon activité professionnelle actuelle ou récente.',
        eo, CompetencyLevel.A2, 7, 3, false);
    SkillInfo(8,'Je peux raconter une histoire ou l\'intrigue d\'un livre ou d\'un film et exprimer mes réactions.',
        eo, CompetencyLevel.B1, 8, 4, false);*/
  }

  static loadSelectedStudentSkillsRouteInformation(int studentId) async {
    BlocksListInfo.clear();
    currentStudentId = studentId;
    //_debugLoading();
    // On récupère les catégories
    BlocksListInfo.modelCategoryBlocksList = await CacheManager.getSkillBlocks();
    Map<int, CategoryInfo> idCategories = Map();
    BlocksListInfo.modelCategoryBlocksList.forEach((element) {idCategories.putIfAbsent(element.id, () => CategoryInfo(element.title, element.id%4));});

    // On récupère les auto validations
    List<SelfAssessment> selfAssessments = await CacheManager.getSelfAssessedSkills(studentId);
    Map<int, int> selfAssessedSkillsIds = Map();
    selfAssessments.forEach((element) => selfAssessedSkillsIds.putIfAbsent(element.skillId, () => element.id));

    // On récupère les validations par un enseignant
    List<TeacherAssessment> teacherAssessments = await CacheManager.getTeacherAssessedSkills(studentId);
    Map<int, int> teacherAssessedSkillsIds = Map();
    teacherAssessments.forEach((element) => teacherAssessedSkillsIds.putIfAbsent(element.skillId, () => element.id));

    // On récupère les compétences
    (await CacheManager.getPersonalSkills(studentId)).forEach((element) =>
        SkillInfo(element, idCategories[element.blockId], selfAssessedSkillsIds[element.id], teacherAssessedSkillsIds[element.id], true));
    (await CacheManager.getGlobalSkills()).forEach((element) =>
        SkillInfo(element, idCategories[element.blockId], selfAssessedSkillsIds[element.id], teacherAssessedSkillsIds[element.id], false));
  }

  static loadGlobalSkillsRouteInformation() async {
    BlocksListInfo.clear();
    currentStudentId = null;
    _debugLoading();
    // On récupère les catégories
    List<SkillBlock> categories = await CacheManager.getSkillBlocks();
    Map<int, CategoryInfo> idCategories = Map();
    categories.forEach((element) {idCategories.putIfAbsent(element.id, () => CategoryInfo(element.title, element.id%4));});

    // On récupère les compétences
    (await CacheManager.getGlobalSkills()).forEach((element) => SkillInfo.withoutAssessment(element, idCategories[element.blockId], false));
  }
}
