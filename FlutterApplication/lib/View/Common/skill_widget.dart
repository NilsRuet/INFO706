import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:info706/Model/Data/Info.dart';
import 'package:info706/Resources/app_colors.dart';

// Competence que peut acquerir un etudiant
// ignore: must_be_immutable
class SkillWidget extends StatefulWidget{
  SkillInfo _skill;
  bool _isLevelMainInfo;

  SkillWidget(SkillInfo skill, bool levelIsMainInfo){
    _skill = skill;
    _isLevelMainInfo = levelIsMainInfo;
  }

  @override
  State<StatefulWidget> createState() {
    return _SkillWidgetState();
  }
}

class _SkillWidgetState extends State<SkillWidget>{
  Text _level;
  Text _block;
  bool _isAutoChecked;
  bool _isCheckedByTeacher;
  Text _entitle;

  _SkillWidgetState();

  @override
  void initState() {
    super.initState();
    SkillInfo skill = widget._skill;
    _level = Text(describeEnum(skill.level),
            style: TextStyle(color: AppColors.CATEGORY_COLORS[skill.level.index]));
    _block = Text(skill.category.name,
        style: TextStyle(color: AppColors.CATEGORY_COLORS[skill.category.index]));
    _isAutoChecked = skill.isAutoChecked;
    _isCheckedByTeacher = skill.isCheckedByTeacher;
    _entitle = Text(skill.name);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Row(
          children: [
            Expanded(child: widget._isLevelMainInfo?_block:_level),
            Checkbox(
                value: _isAutoChecked,
                onChanged: (bool newVal) {
                  setState(() {
                    _isAutoChecked = newVal;
                  });
                }),
            Icon(_isCheckedByTeacher
                ? Icons.check_box
                : Icons.check_box_outline_blank)
          ],
        ),
        subtitle: _entitle,
        contentPadding: EdgeInsets.fromLTRB(16.0, .0, 16.0, 16.0),
      ),
      elevation: 20.0,
      semanticContainer: false,
    );
  }
}
