import 'package:flutter/material.dart';
import 'package:info706/Model/Data/Info.dart';
import 'package:info706/View/Common/SkillsViews/skill_widget.dart';

/// Bloc regroupant differentes competences, selon leur niveau ou leur categorie,
/// à surcharger selon s'il on veux le point de vue étudiant ou enseignant

// ignore: must_be_immutable
abstract class SkillBlockWidget extends StatefulWidget{
  ListTile header;
  List<Widget> _body;
  bool isExpanded;
  BlockInfo block;

  SkillBlockWidget(this.block, this.isExpanded, bool isLevelMainInfo) {
    header = ListTile(
        title: Text(block.name,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)));
    _body = generateBlockProgression() + generateSkills(block.globalSkills, block.personalSkills, isLevelMainInfo);
  }

  @override
  State<StatefulWidget> createState() => _SkillBlockWidgetState();

  List<SkillWidget> generateSkills(List<SkillInfo> globalSkills, List<SkillInfo> personalSkills, bool isLevelMainInfo);

  List<Widget> generateBlockProgression() => [];
}

class _SkillBlockWidgetState extends State<SkillBlockWidget>{

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10.0, .0, 10.0, 10.0),
      child: Column(
        children: widget._body,
        mainAxisSize: MainAxisSize.min,
      ),
    );
  }
}