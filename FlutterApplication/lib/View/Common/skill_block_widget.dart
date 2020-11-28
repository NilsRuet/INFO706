import 'package:flutter/material.dart';
import 'package:info706/Model/Data/Info.dart';
import 'package:info706/View/Common/skill_widget.dart';

// Bloc regroupant differentes competences, selon leur niveau ou leur categorie
// ignore: must_be_immutable
class SkillBlockWidget extends StatefulWidget{
  _SkillBlockWidgetState _selfState;
  ListTile header;
  List<SkillWidget> _skills;
  bool isExpanded;

  SkillBlockWidget(BlockInfo block, bool isExpanded, bool isLevelMainInfo) {
    this.isExpanded = isExpanded;
    header = ListTile(
        title: Text(block.name,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)));
    _skills = _generateSkills(block.skills, isLevelMainInfo);
  }

  @override
  State<StatefulWidget> createState() {
    _selfState = _SkillBlockWidgetState();
    return _selfState;
  }

  List<SkillWidget> _generateSkills(List<SkillInfo> skills, bool levelIsMainInfo) {
    return List.generate(skills.length, (int index) {
      return SkillWidget(skills[index], levelIsMainInfo);
    });
  }
}

class _SkillBlockWidgetState extends State<SkillBlockWidget>{

  _SkillBlockWidgetState();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10.0, .0, 10.0, 10.0),
      child: Column(
        children: widget._skills,
        mainAxisSize: MainAxisSize.min,
      ),
    );
  }
}