// Toutes les informations concernant une compétence pour une personne
import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:info706/Model/Cache/CacheManager.dart';
import 'package:info706/Model/Cache/DataManager.dart';
import 'Assessment.dart';
import 'Skill.dart';
import 'User.dart';

class SkillInfo {
  Skill modelSkill;
  String get name => modelSkill.name;
  CompetencyLevel get level => modelSkill.level;

  CategoryInfo category;
  bool isAutoChecked = false;
  bool isCheckedByTeacher = false;
  int _teacherAssessmentId;
  bool isPersonal;
  int _selfAssessmentId;

  SkillInfo(this.modelSkill, this.category, this._selfAssessmentId,
      this._teacherAssessmentId, this.isPersonal) {
    isCheckedByTeacher = _teacherAssessmentId != null;
    isAutoChecked = _selfAssessmentId != null;
    BlocksListInfo.getLevelBlock(level).add(this);
    BlocksListInfo.getCategoryBlock(category).add(this);
  }

  SkillInfo.withoutAssessment(this.modelSkill, this.category, this.isPersonal) {
    BlocksListInfo.getLevelBlock(level).add(this);
    BlocksListInfo.getCategoryBlock(category).add(this);
  }

  Future<bool> delete() async {
    bool res = isPersonal
        ? await DataManager.deletePersonalSkill(modelSkill)
        : await DataManager.deleteGlobalSkill(modelSkill);
    if (!res) return false;

    return true;
  }

  Future<bool> trySetIsCheckedByTeacher(bool checked, Teacher assessor) async {
    if (isCheckedByTeacher == checked) return true;

    if (checked) {
      var assessment = await DataManager.createTeacherAssessment(
          InfoManager.currentStudentId, modelSkill.id, assessor.id);
      if (assessment == null) return false;
    } else {
      if (!await DataManager.deleteTeacherAssessmentById(_teacherAssessmentId))
        return false;
    }
    return true;
  }

  Future<bool> trySetIsAutoChecked(bool checked) async {
    if (isAutoChecked == checked) return true;

    if (checked) {
      var assessment = await DataManager.createSelfAssessment(
          InfoManager.currentStudentId, modelSkill.id);
      if (assessment == null) return false;
    } else {
      if (!await DataManager.deleteSelfAssessmentById(_selfAssessmentId))
        return false;
    }
    return true;
  }

  Future<bool> tryEdit(Skill skill) async {
    if (isPersonal)
      return (await DataManager.updatePersonalSkill(skill) != null);
    return (await DataManager.updateGlobalSkill(skill) != null);
  }

  static tryCreatePersonalSkill(Skill skill) async {
    return (await DataManager.createPersonalSkill(skill.name, skill.level,
            skill.blockId, InfoManager.currentStudentId) !=
        null);
  }

  static tryCreateGlobalSkill(Skill skill) async {
    return (await DataManager.createGlobalSkill(
            skill.name, skill.level, skill.blockId) !=
        null);
  }
}

class CategoryInfo {
  String name;
  int index;

  CategoryInfo(this.name, this.index);
}

class BlockInfo {
  String name;
  List<SkillInfo> globalSkills;
  List<SkillInfo> personalSkills;
  int get _nbAssessedByTeacherSkills =>
      personalSkills
          .where((element) => element.isCheckedByTeacher)
          .toList()
          .length +
      globalSkills
          .where((element) => element.isCheckedByTeacher)
          .toList()
          .length;

  int get _nbSelfAssessedSkills =>
      personalSkills.where((element) => element.isAutoChecked).toList().length +
      globalSkills.where((element) => element.isAutoChecked).toList().length;

  BlockInfo(this.name) {
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

  double selfAssessmentProportion() =>
      _nbSelfAssessedSkills / (globalSkills.length + personalSkills.length);

  double teacherAssessmentProportion() =>
      _nbAssessedByTeacherSkills /
      (globalSkills.length + personalSkills.length);
}

class BlocksListInfo {
  static SplayTreeMap<String, BlockInfo> _sortedByLevel = SplayTreeMap();

  static List<SkillBlock> modelCategoryBlocksList;
  static List<BlockInfo> get sortedByLevel => _sortedByLevel.values.toList();

  static SplayTreeMap<String, BlockInfo> _sortedByCategory = SplayTreeMap();
  static List<BlockInfo> get sortedByCategory =>
      _sortedByCategory.values.toList();

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

class InfoManager {
  static int currentStudentId;
  static loadSelectedStudentSkillsRouteInformation(int studentId) async {
    BlocksListInfo.clear();
    currentStudentId = studentId;
    // On récupère les catégories
    BlocksListInfo.modelCategoryBlocksList =
        await CacheManager.getSkillBlocks();
    Map<int, CategoryInfo> idCategories = Map();
    BlocksListInfo.modelCategoryBlocksList.forEach((element) {
      idCategories.putIfAbsent(
          element.id, () => CategoryInfo(element.title, element.id % 4));
    });

    // On récupère les auto validations
    List<SelfAssessment> selfAssessments =
        await CacheManager.getSelfAssessedSkills(studentId);
    Map<int, int> selfAssessedSkillsIds = Map();
    selfAssessments.forEach((element) =>
        selfAssessedSkillsIds.putIfAbsent(element.skillId, () => element.id));

    // On récupère les validations par un enseignant
    List<TeacherAssessment> teacherAssessments =
        await CacheManager.getTeacherAssessedSkills(studentId);
    Map<int, int> teacherAssessedSkillsIds = Map();
    teacherAssessments.forEach((element) => teacherAssessedSkillsIds
        .putIfAbsent(element.skillId, () => element.id));

    // On récupère les compétences
    (await CacheManager.getPersonalSkills(studentId)).forEach((element) =>
        SkillInfo(
            element,
            idCategories[element.blockId],
            selfAssessedSkillsIds[element.id],
            teacherAssessedSkillsIds[element.id],
            true));
    (await CacheManager.getGlobalSkills()).forEach((element) => SkillInfo(
        element,
        idCategories[element.blockId],
        selfAssessedSkillsIds[element.id],
        teacherAssessedSkillsIds[element.id],
        false));
  }

  static loadGlobalSkillsRouteInformation() async {
    BlocksListInfo.clear();
    currentStudentId = null;
    // On récupère les catégories
    List<SkillBlock> categories = await CacheManager.getSkillBlocks();
    Map<int, CategoryInfo> idCategories = Map();
    categories.forEach((element) {
      idCategories.putIfAbsent(
          element.id, () => CategoryInfo(element.title, element.id % 4));
    });

    // On récupère les compétences
    (await CacheManager.getGlobalSkills()).forEach((element) =>
        SkillInfo.withoutAssessment(
            element, idCategories[element.blockId], false));
  }
}
