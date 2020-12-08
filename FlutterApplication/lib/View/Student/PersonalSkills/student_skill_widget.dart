import 'package:flutter/material.dart';
import 'package:info706/Model/Data/Info.dart';
import 'package:info706/View/Common/SkillsViews/app_widgets.dart';
import 'package:info706/View/Common/SkillsViews/skill_widget.dart';
import 'package:info706/View/Common/SkillsViews/skills_view.dart';

/// Competence que peut acquerir un etudiant, selon le point de vue étudiant

// ignore: must_be_immutable
class StudentSkillWidget extends SkillWidget {
  StudentSkillWidget(SkillInfo skill, bool levelIsMainInfo)
      : super(skill, levelIsMainInfo);

  @override
  SkillWidgetState createState() => _StudentSkillWidgetState();
}

class _StudentSkillWidgetState extends SkillWidgetState {
  @override
  initState() {
    super.initState();
    header = _StudentSkillHeaderWidget(
        widget.skill,
        widget.isLevelMainInfo ? block : level,
        isAutoChecked,
        isCheckedByTeacher);
  }
}

/// En-tête d'une compétence, selon le point de vue étudiant
// ignore: must_be_immutable
class _StudentSkillHeaderWidget extends SkillHeaderWidget {
  _StudentSkillHeaderWidget(SkillInfo skill, Text secondaryInformation,
      bool isAutoChecked, bool isCheckedByTeacher)
      : super(skill, secondaryInformation, isAutoChecked, isCheckedByTeacher);

  @override
  _StudentSkillHeaderWidgetState createState() =>
      _StudentSkillHeaderWidgetState();
}

class _StudentSkillHeaderWidgetState extends SkillHeaderWidgetState {
  bool _loading = false;

  @override
  List<Widget> headerChildren() {
    return [
      Expanded(child: widget.secondaryInformation),
      _loading
          ? Container(
              margin: EdgeInsets.all(6),
              child: Transform.scale(
                  scale: 0.5, child: CircularProgressIndicator()),
            )
          : _getCheckbox(),
      Icon(widget.isCheckedByTeacher ? Icons.check : Icons.crop_free)
    ];
  }

  Widget _getCheckbox() {
    return Checkbox(
        value: widget.isAutoChecked,
        onChanged: (bool newVal) async {
          setState(() {
            _loading = true;
          });
          bool res = await widget.skill.trySetIsAutoChecked(newVal);
          setState(() {
            _loading = false;
            if (!res)
              Scaffold.of(context).showSnackBar(AppWidgets.connectionSnackBar);
            else{
              widget.isAutoChecked = newVal;
              widget.skill.isAutoChecked = newVal;
              //TODO
            }
            SkillsViewState.currentSkillViewState.refreshDataForDisplay();
          });
        });
  }
}
