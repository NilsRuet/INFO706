import 'package:flutter/material.dart';
import 'package:info706/Model/Data/Info.dart';
import 'package:info706/Model/Data/User.dart';
import 'package:info706/View/Common/SkillsViews/app_widgets.dart';
import 'package:info706/View/Common/SkillsViews/skill_widget.dart';
import 'package:info706/View/Common/SkillsViews/skills_view.dart';

/// Competence que peut acquerir un etudiant, selon le point de vue enseignant

// ignore: must_be_immutable
class TeacherSkillWidget extends SkillWidget{
  Teacher assessor;

  TeacherSkillWidget(SkillInfo skill, bool levelIsMainInfo, this.assessor) : super(skill, levelIsMainInfo);

  @override
  SkillWidgetState createState() => _TeacherSkillWidgetState(assessor);
}

class _TeacherSkillWidgetState extends SkillWidgetState{
  Teacher assessor;

  _TeacherSkillWidgetState(this.assessor);

  @override
  initState(){
    super.initState();
    header = _TeacherSkillHeaderWidget(widget.skill, widget.isLevelMainInfo?block:level, isAutoChecked, isCheckedByTeacher, assessor);
  }
}

/// En-tête d'une compétence, selon le point de vue enseignant

// ignore: must_be_immutable
class _TeacherSkillHeaderWidget extends SkillHeaderWidget{
  Teacher assessor;

  _TeacherSkillHeaderWidget(SkillInfo skill, Text secondaryInformation, bool isAutoChecked, bool isCheckedByTeacher, this.assessor) : super(skill, secondaryInformation, isAutoChecked, isCheckedByTeacher);

  @override
  _TeacherSkillHeaderWidgetState createState() => _TeacherSkillHeaderWidgetState(assessor);
}

class _TeacherSkillHeaderWidgetState extends SkillHeaderWidgetState{
  Teacher assessor;

  _TeacherSkillHeaderWidgetState(this.assessor);

  @override
  List<Widget> headerChildren(){
    return [
      Expanded(child:widget.secondaryInformation),
      Icon(widget.isAutoChecked ? Icons.check_box : Icons.check_box_outline_blank),
      Checkbox(
          value: widget.isCheckedByTeacher,
          onChanged: (bool newVal) async {
            bool res = await widget.skill.trySetIsCheckedByTeacher(newVal, assessor);
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