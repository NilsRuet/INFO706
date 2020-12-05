import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:info706/Model/Data/Info.dart';
import 'package:info706/Resources/app_colors.dart';

/// Competence que peut acquerir un etudiant, à surcharger selon s'il on veux le point de vue étudiant ou enseignant

// ignore: must_be_immutable
abstract class SkillWidget extends StatefulWidget{
  SkillInfo _skill;
  bool isLevelMainInfo;

  SkillWidget(SkillInfo skill, bool levelIsMainInfo){
    _skill = skill;
    isLevelMainInfo = levelIsMainInfo;
  }
}

abstract class SkillWidgetState extends State<SkillWidget>{
  Text level;
  Text block;
  bool isAutoChecked;
  bool isCheckedByTeacher;
  Text _entitle;
  SkillHeaderWidget header;

  @override
  void initState() {
    super.initState();
    SkillInfo skill = widget._skill;
    level = Text(describeEnum(skill.level),
            style: TextStyle(color: AppColors.CATEGORY_COLORS[skill.level.index]));
    block = Text(skill.category.name,
        style: TextStyle(color: AppColors.CATEGORY_COLORS[skill.category.index]));
    isAutoChecked = skill.isAutoChecked;
    isCheckedByTeacher = skill.isCheckedByTeacher;
    _entitle = Text(skill.name);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: header,
        subtitle: _entitle,
        contentPadding: EdgeInsets.fromLTRB(16.0, .0, 16.0, 16.0),
      ),
      elevation: 20.0,
      semanticContainer: false,
    );
  }
}

/// En-tête d'une compétence, à surcharger selon s'il on veux le point de vue étudiant ou enseignant
// ignore: must_be_immutable
abstract class SkillHeaderWidget extends StatefulWidget{
  Text secondaryInformation;
  bool isAutoChecked;
  bool isCheckedByTeacher;

  SkillHeaderWidget(this.secondaryInformation, this.isAutoChecked, this.isCheckedByTeacher);
}

abstract class SkillHeaderWidgetState extends State<SkillHeaderWidget>{
  @override
  Widget build(BuildContext context) => Row(children: headerChildren());

  List<Widget> headerChildren();
}