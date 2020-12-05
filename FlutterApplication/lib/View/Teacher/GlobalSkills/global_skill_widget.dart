import 'package:flutter/material.dart';
import 'package:info706/Model/Data/Info.dart';
import 'package:info706/View/Common/SkillsViews/skill_widget.dart';

/// Competence que peut acquerir un etudiant, selon le point de vue étudiant

// ignore: must_be_immutable
class GlobalSkillWidget extends SkillWidget{
  GlobalSkillWidget(SkillInfo skill, bool levelIsMainInfo) : super(skill, levelIsMainInfo);

  @override
  SkillWidgetState createState() => _GlobalSkillWidgetState();
}

class _GlobalSkillWidgetState extends SkillWidgetState{
  @override
  initState(){
    super.initState();
    header = _GlobalSkillHeaderWidget(widget.isLevelMainInfo?block:level);
  }

  @override
  void longPressAction() {
    openPopupMenu();
  }
}

/// En-tête d'une compétence, selon le point de vue étudiant
// ignore: must_be_immutable
class _GlobalSkillHeaderWidget extends SkillHeaderWidget{

  _GlobalSkillHeaderWidget(Text secondaryInformation) : super.withoutAssessment(secondaryInformation);

  @override
  _GlobalSkillHeaderWidgetState createState() => _GlobalSkillHeaderWidgetState();
}

class _GlobalSkillHeaderWidgetState extends SkillHeaderWidgetState{

  @override
  List<Widget> headerChildren()=> [Expanded(child:widget.secondaryInformation),];
}