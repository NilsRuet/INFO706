import 'package:flutter/material.dart';
import 'package:info706/Resources/app_colors.dart';
import 'package:info706/Resources/app_strings.dart';

// Competence que peut acquerir un etudiant
// ignore: must_be_immutable
class SkillWidget extends StatefulWidget{
  String _name;
  bool _isLevelMainInfo;

  SkillWidget(String skillName, bool levelIsMainInfo){
    _name = skillName;
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
    String skill = widget._name;
    final levelName = AppStrings.LEVELS_BY_SKILL[skill];
    final blockName = AppStrings.BLOCKS_BY_SKILL[skill];
    _level = Text(levelName,
        style: TextStyle(color: AppColors.LEVELS_COLORS[levelName]));
    _block = Text(blockName,
        style: TextStyle(color: AppColors.BLOCKS_COLORS[blockName]));
    _isAutoChecked = AppStrings.AUTO_CHECKS_BY_SKILL[skill];
    _isCheckedByTeacher = AppStrings.TEACHERS_CHECKS_BY_SKILL[skill];
    _entitle = Text(skill);
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
