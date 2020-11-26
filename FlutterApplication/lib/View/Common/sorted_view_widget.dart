import 'package:flutter/material.dart';
import 'package:info706/Resources/app_strings.dart';
import 'package:info706/View/Common/skill_block_widget.dart';

//Liste de blocs de competences (classe abstraite): on surcharge la classe selon la façon dont on veut trier
abstract class SortedViewWidget extends StatefulWidget {
  String getName();
}

abstract class _SortedViewState extends State<SortedViewWidget> {
  List<String> _blocksNames = AppStrings.SKILLS_BLOCKS;
  Map<String, List<String>> _blocks = AppStrings.SKILLS_BY_BLOCK;
  List<SkillBlockWidget> _blocksList;

  @override
  void initState() {
    super.initState();
    _blocksList = _generateBlocks();
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
                  setState(() {
                    _blocksList[index].isExpanded = !isExpanded;
                  });
                },
                children: _generateBlocksPanel(_blocksList))));}

  List<SkillBlockWidget> _generateBlocks() {
    return List.generate(_blocksNames.length, (int index) {
      return SkillBlockWidget(_blocksNames[index], _blocks[_blocksNames[index]], true, _isLevelMainInfo());
    });
  }

  List<ExpansionPanel> _generateBlocksPanel(List<SkillBlockWidget> blocksList) {
    List<ExpansionPanel> panels = new List.empty(growable: true);
    for (SkillBlockWidget block in blocksList)
      panels.add(ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return block.header;
          },
          isExpanded: block.isExpanded,
          body: block,
          canTapOnHeader: true));
    return panels;
  }

  bool _isLevelMainInfo();
}

//Liste de blocs de competences, tries selon le niveau de chaque competence
class SortedByLevelWidget extends SortedViewWidget{
  @override
  State<StatefulWidget> createState() {
    return _SortedByLevelState();
  }

  @override
  String getName() {
    return AppStrings.SORT_BY_LEVEL;
  }
}

class _SortedByLevelState extends _SortedViewState{
  @override
  List<String> _blocksNames = AppStrings.LEVEL_BLOCKS;
  @override
  Map<String, List<String>> _blocks = AppStrings.SKILLS_BY_LEVEL;

  @override
  bool _isLevelMainInfo() {
    return true;
  }
}

//Liste de blocs de competences, tries selon la categorie de chaque competence
class SortedBySkillBlockWidget extends SortedViewWidget{
  @override
  State<StatefulWidget> createState() {
    return SortedBySkillBlockState();
  }

  @override
  String getName() {
    return AppStrings.SORT_BY_BLOCK;
  }
}

class SortedBySkillBlockState extends _SortedViewState{
  @override
  List<String> _blocksNames = AppStrings.SKILLS_BLOCKS;
  @override
  Map<String, List<String>> _blocks = AppStrings.SKILLS_BY_BLOCK;

  @override
  bool _isLevelMainInfo() {
    return false;
  }
}
