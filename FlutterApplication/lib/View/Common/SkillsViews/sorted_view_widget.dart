import 'package:flutter/material.dart';
import 'package:info706/Model/Data/Info.dart';
import 'package:info706/View/Common/SkillsViews/skill_block_widget.dart';

/// Liste de blocs de competences, à surcharger en une classe abstraite fille selon s'il on veux le point de vue étudiant ou enseignant
/// puis surcharger la fille selon la façon dont on veut trier

abstract class SortedViewWidget extends StatefulWidget {
  SortedViewState state;

  String getName();

  void refreshForDisplay(){
    state.refresh();
  }
}

abstract class SortedViewState extends State<SortedViewWidget> {
  List<BlockInfo> blocks;
  List<SkillBlockWidget> blocksList;

  SortedViewState(this.blocks);

  @override
  void initState() {
    super.initState();
    blocksList = generateBlocks();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Container(
            child: ExpansionPanelList(
                expandedHeaderPadding: EdgeInsets.all(10.0),
                animationDuration: Duration(milliseconds: 800),
                expansionCallback: (int index, bool isExpanded) {
                  setState(() => blocksList[index].isExpanded = !isExpanded);
                },
                children: _generateBlocksPanel(blocksList))));
  }

  List<SkillBlockWidget> generateBlocks();

  List<ExpansionPanel> _generateBlocksPanel(List<SkillBlockWidget> blocksList) {
    List<ExpansionPanel> panels = new List.empty(growable: true);
    for (SkillBlockWidget block in blocksList)
      panels.add(ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) => block.header,
          isExpanded: block.isExpanded,
          body: block,
          canTapOnHeader: true));
    return panels;
  }

  bool isLevelMainInfo();

  void refresh(){
    for(var b in blocksList){
      b.refresh();
    }
  }
}