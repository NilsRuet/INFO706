import 'package:flutter/material.dart';
import 'package:info706/Model/Data/Info.dart';
import 'package:info706/View/Common/SkillsViews/skill_widget.dart';

/// Bloc regroupant differentes competences, selon leur niveau ou leur categorie,
/// à surcharger selon s'il on veux le point de vue étudiant ou enseignant

// ignore: must_be_immutable
abstract class SkillBlockWidget extends StatefulWidget{
  //_SkillBlockWidgetState _selfState;
  ListTile header;
  List<SkillWidget> _skills;
  bool isExpanded;

  SkillBlockWidget(BlockInfo block, bool isExpanded, bool isLevelMainInfo) {
    this.isExpanded = isExpanded;
    header = ListTile(
        title: Text(block.name,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)));
    _skills = generateSkills(block.skills, isLevelMainInfo);
  }

  @override
  State<StatefulWidget> createState() => _SkillBlockWidgetState();

  List<SkillWidget> generateSkills(List<SkillInfo> skills, bool levelIsMainInfo);
}

class _SkillBlockWidgetState extends State<SkillBlockWidget>{

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