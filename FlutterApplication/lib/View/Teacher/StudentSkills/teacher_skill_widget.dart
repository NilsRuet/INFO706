import 'package:flutter/material.dart';
import 'package:info706/Model/Data/Info.dart';
import 'package:info706/View/Common/SkillsViews/app_widgets.dart';
import 'package:info706/View/Common/SkillsViews/skill_widget.dart';
import 'package:info706/View/Common/SkillsViews/skills_view.dart';

/// Competence que peut acquerir un etudiant, selon le point de vue enseignant

// ignore: must_be_immutable
class TeacherSkillWidget extends SkillWidget{
  TeacherSkillWidget(SkillInfo skill, bool levelIsMainInfo) : super(skill, levelIsMainInfo);

  @override
  SkillWidgetState createState() => _TeacherSkillWidgetState();
}

class _TeacherSkillWidgetState extends SkillWidgetState{
  @override
  initState(){
    super.initState();
    header = _TeacherSkillHeaderWidget(widget.skill, widget.isLevelMainInfo?block:level, isAutoChecked, isCheckedByTeacher);
  }
}

/// En-tête d'une compétence, selon le point de vue enseignant

// ignore: must_be_immutable
class _TeacherSkillHeaderWidget extends SkillHeaderWidget{

  _TeacherSkillHeaderWidget(SkillInfo skill, Text secondaryInformation, bool isAutoChecked, bool isCheckedByTeacher) : super(skill, secondaryInformation, isAutoChecked, isCheckedByTeacher);

  @override
  _TeacherSkillHeaderWidgetState createState() => _TeacherSkillHeaderWidgetState();
}

class _TeacherSkillHeaderWidgetState extends SkillHeaderWidgetState{

  @override
  List<Widget> headerChildren(){
    return [
      Expanded(child:widget.secondaryInformation),
      Icon(widget.isAutoChecked ? Icons.check_box : Icons.check_box_outline_blank),
      Checkbox(
          value: widget.isCheckedByTeacher,
          onChanged: (bool newVal) async {
            bool res = await widget.skill.trySetIsCheckedByTeacher(newVal);
            setState(() {
              if (!res)
                Scaffold.of(context).showSnackBar(AppWidgets.connectionSnackBar);
              else
                SkillsViewState.currentSkillViewState.loadDataForDisplay();
            });
          })
    ];
  }
}