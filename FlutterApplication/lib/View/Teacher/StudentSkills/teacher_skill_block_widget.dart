import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:info706/Model/Data/Info.dart';
import 'package:info706/Model/Data/User.dart';
import 'package:info706/View/Common/SkillsViews/skill_block_widget.dart';
import 'package:info706/View/Common/SkillsViews/skill_widget.dart';
import 'package:info706/View/Teacher/StudentSkills/teacher_skill_widget.dart';

/// Bloc regroupant differentes competences, selon leur niveau ou leur categorie, du point de vue enseignant

// ignore: must_be_immutable
class TeacherSkillBlockWidget extends SkillBlockWidget{
  Teacher assessor;

  TeacherSkillBlockWidget(BlockInfo block, bool isExpanded, bool isLevelMainInfo, this.assessor) : super(block, isExpanded, isLevelMainInfo);

  @override
  List<SkillWidget> generateSkills(List<SkillInfo> globalSkills, List<SkillInfo> personalSkills, bool isLevelMainInfo) {
    return List.generate(globalSkills.length, (int index) => TeacherSkillWidget(globalSkills[index], isLevelMainInfo, assessor))
    + List.generate(personalSkills.length, (int index) => TeacherSkillWidget(personalSkills[index], isLevelMainInfo, assessor));
  }

  @override
  List<Widget> generateBlockProgression() {
    return [
      Container(
          padding: EdgeInsets.fromLTRB(10.0, .0, 10.0, 10.0),
          child:LinearProgressIndicator(value: block.selfAssessmentProportion(), minHeight: 10, valueColor: AlwaysStoppedAnimation<Color>(Colors.white),)),
      Container(
          padding: EdgeInsets.fromLTRB(10.0, .0, 10.0, 10.0),
          child:LinearProgressIndicator(value: block.teacherAssessmentProportion(), minHeight: 10,))
    ];
  }
}