import 'package:info706/Model/Data/Info.dart';
import 'package:info706/View/Common/SkillsViews/skill_block_widget.dart';
import 'package:info706/View/Common/SkillsViews/skill_widget.dart';

import 'global_skill_widget.dart';

/// Bloc regroupant differentes competences, selon leur niveau ou leur categorie, concernant les competences globales

// ignore: must_be_immutable
class GlobalSkillBlockWidget extends SkillBlockWidget{

  GlobalSkillBlockWidget(BlockInfo block, bool isExpanded, bool isLevelMainInfo) : super(block, isExpanded, isLevelMainInfo);

  @override
  List<SkillWidget> generateSkills(List<SkillInfo> globalSkills, List<SkillInfo> personalSkills, bool isLevelMainInfo) {
    return List.generate(globalSkills.length, (int index) => GlobalSkillWidget(globalSkills[index], isLevelMainInfo))
        + List.generate(personalSkills.length, (int index) => GlobalSkillWidget(personalSkills[index], isLevelMainInfo));
  }
}