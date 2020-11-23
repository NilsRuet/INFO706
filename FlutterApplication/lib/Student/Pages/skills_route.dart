import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:info706/Common/navigation_drawer_route.dart';
import 'package:info706/Resources/app_colors.dart';
import 'package:info706/Resources/app_strings.dart';

// The Student skills page

class MySkillsDrawerRoute implements NavigationDrawerRoute{
  @override
  Widget build() {
    return _MySkillsView();
  }

  @override
  String getViewName() {
    return AppStrings.MY_SKILLS_ROUTE_TITLE;
  }
}

class _MySkillsView extends StatefulWidget {
  /*final SortedBySkillBlockView sortedBySkillBlockView = SortedBySkillBlockView();
  final SortedByLevelView sortedByLevelView = SortedByLevelView();*/
  @override
  _MySkillsViewState createState() => _MySkillsViewState();
}

class _MySkillsViewState extends State<_MySkillsView> {
  SortedView _currentSortedView;
  SortedBySkillBlockView sortedBySkillBlockView = SortedBySkillBlockView();
  SortedByLevelView sortedByLevelView = SortedByLevelView();

  _MySkillsViewState(){
    sortedBySkillBlockView.skillViewState = this;
    sortedByLevelView.skillViewState = this;

    _currentSortedView = sortedBySkillBlockView;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _skillsPageAppBar(),
        floatingActionButton: _addingSkillButton(),
        body: Column(
            children: [_sortingButton(), Expanded(child: _currentSortedView.skillsList())]));
  }

  AppBar _skillsPageAppBar() {
    return AppBar(
      title: Text(AppStrings.MY_SKILLS_ROUTE_TITLE),
      centerTitle: true,
    );
  }

  Widget _sortingButton() {
    return Container(
        child: DropdownButton<SortedView>(
          value: _currentSortedView,
          underline: Container(height: 2, color: Theme.of(context).accentColor,),
          onChanged: (SortedView newValue) {
            setState(() {_currentSortedView = newValue;});
            },
          items: <SortedView>[sortedBySkillBlockView, sortedByLevelView].
          map<DropdownMenuItem<SortedView>>((SortedView value) {
                return DropdownMenuItem<SortedView>(
                  value: value,
                  child: Text(value.name),
                );
              }).toList(),
        ),
      alignment: Alignment(1.0, -1.0),
    );
  }

  FloatingActionButton _addingSkillButton() {
    return FloatingActionButton(
      onPressed: _addingSkillForm,
      child: Icon(Icons.add),
    );
  }

  /*Widget _skillsListBySkillsBlock() {
    List<SkillBlock> blocksList = generateSkillsBlocks();
    return SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Container(
            child: ExpansionPanelList(
                expandedHeaderPadding: EdgeInsets.all(10.0),
                animationDuration: Duration(milliseconds: 800),
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    blocksList[index].isExpanded = !isExpanded;
                  });
                },
                children: _blocksPanelBySkillsBlock(blocksList))));
  }

  _skillsListByLevelBlock() {
    List<LevelBlock> blocksList = generateLevelBlocks();
    return SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Container(
            child: ExpansionPanelList(
                expandedHeaderPadding: EdgeInsets.all(10.0),
                animationDuration: Duration(milliseconds: 800),
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    blocksList[index].isExpanded = !isExpanded;
                  });
                },
                children: _blocksPanelByLevelBlock(blocksList))));
  }
*/
  /*
  List<ExpansionPanel> _blocksPanelBySkillsBlock(List<SkillBlock> blocksList) {
    List<ExpansionPanel> panels = new List.empty(growable: true);

    for (SkillBlock block in blocksList)
      panels.add(ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return block.header;
          },
          body: _generateSkillsList(block.skills),
          isExpanded: block.isExpanded,
          canTapOnHeader: true));

    return panels;
  }

  _blocksPanelByLevelBlock(List<LevelBlock> blocksList) {
    List<ExpansionPanel> panels = new List.empty(growable: true);

    for (LevelBlock block in blocksList)
      panels.add(ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return block.header;
          },
          body: _generateSkillsList(block.skills),
          isExpanded: block.isExpanded,
          canTapOnHeader: true));

    return panels;
  }
*/
  /*
  Widget _generateSkillsList(List<Skill> skills) {
    final List<Widget> skillsList = new List.empty(growable: true);
    for (Skill skill in skills) {
      skillsList.add(_generateSkillItem(skill));
    }
    return Container(
      padding: EdgeInsets.fromLTRB(10.0, .0, 10.0, 10.0),
      child: Column(
        children: skillsList,
        mainAxisSize: MainAxisSize.min,
      ),
    );
  }

  Widget _generateSkillItem(Skill skill) {
    return Card(
      child: ListTile(
        title: Row(
          children: [
            Expanded(child: isSortedByBlock?skill.level:skill.block),
            Checkbox(
                value: skill.isAutoChecked,
                onChanged: (bool newVal) {
                  setState(() {
                    skill.isAutoChecked = newVal;
                  });
                }),
            Icon(skill.isCheckedByTeacher
                ? Icons.check_box
                : Icons.check_box_outline_blank)
          ],
        ),
        subtitle: skill.entitle,
        contentPadding: EdgeInsets.fromLTRB(16.0, .0, 16.0, 16.0),
      ),
      elevation: 20.0,
      semanticContainer: false,
    );
  }*/

  // TODO: link this to the addingForm
  void _addingSkillForm() {}
}

abstract class SortedView {
  //TODO private members?
  _MySkillsViewState skillViewState;
  String name;
  List<String> blocksNames;
  Map<String, List<String>> blocks;

  //TODO encapsulation? return value?
  Widget skillsList() {
    List<SkillBlock> blocksList = generateBlocks();
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.0),
      child: Container(
          child: ExpansionPanelList(
              expandedHeaderPadding: EdgeInsets.all(10.0),
              animationDuration: Duration(milliseconds: 800),
              expansionCallback: (int index, bool isExpanded) {
                skillViewState.setState(() {
                  blocksList[index].isExpanded = !isExpanded;
                });
              },
              children: _blocksPanel(blocksList))));}

  List<SkillBlock> generateBlocks() {
    return List.generate(blocksNames.length, (int index) {
      return SkillBlock(blocksNames[index], blocks[blocksNames[index]]);
    });
  }

  List<ExpansionPanel> _blocksPanel(List<SkillBlock> blocksList) {
    List<ExpansionPanel> panels = new List.empty(growable: true);

    for (SkillBlock block in blocksList)
      panels.add(ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return block.header;
          },
          body: _generateSkillsList(block.skills),
          isExpanded: block.isExpanded,
          canTapOnHeader: true));

    return panels;
  }

  Widget _generateSkillsList(List<Skill> skills) {
    final List<Widget> skillsList = new List.empty(growable: true);
    for (Skill skill in skills) {
      skillsList.add(_generateSkillItem(skill));
    }
    return Container(
      padding: EdgeInsets.fromLTRB(10.0, .0, 10.0, 10.0),
      child: Column(
        children: skillsList,
        mainAxisSize: MainAxisSize.min,
      ),
    );
  }

  Widget _generateSkillItem(Skill skill) {
    return Card(
      child: ListTile(
        title: Row(
          children: [
            Expanded(child: _skillSecondaryInformation(skill)),
            Checkbox(
                value: skill.isAutoChecked,
                onChanged: (bool newVal) {
                  skillViewState.setState(() {
                    skill.isAutoChecked = newVal;
                  });
                }),
            Icon(skill.isCheckedByTeacher
                ? Icons.check_box
                : Icons.check_box_outline_blank)
          ],
        ),
        subtitle: skill.entitle,
        contentPadding: EdgeInsets.fromLTRB(16.0, .0, 16.0, 16.0),
      ),
      elevation: 20.0,
      semanticContainer: false,
    );
  }

  Text _skillSecondaryInformation(Skill skill);
}

class SortedByLevelView extends SortedView{
  @override
  String name = "Trier par niveau";
  @override
  List<String> blocksNames = AppStrings.LEVEL_BLOCKS;
  @override
  Map<String, List<String>> blocks = AppStrings.SKILLS_BY_LEVEL;

  @override
  Text _skillSecondaryInformation(Skill skill) {
    return skill.block;
  }
}

class SortedBySkillBlockView extends SortedView{
  @override
  String name = "Trier par bloc";
  @override
  List<String> blocksNames = AppStrings.SKILLS_BLOCKS;
  @override
  Map<String, List<String>> blocks = AppStrings.SKILLS_BY_BLOCK;

  @override
  Text _skillSecondaryInformation(Skill skill) {
    return skill.level;
  }
}

class Skill {
  Text level;
  Text block;
  bool isAutoChecked;
  bool isCheckedByTeacher;
  Text entitle;

  Skill(String skill) {
    final levelName = AppStrings.LEVELS_BY_SKILL[skill];
    final blockName = AppStrings.BLOCKS_BY_SKILL[skill];
    level = Text(levelName,
        style: TextStyle(color: AppColors.LEVELS_COLORS[levelName]));
    block = Text(blockName,
        style: TextStyle(color: AppColors.BLOCKS_COLORS[blockName]));
    isAutoChecked = AppStrings.AUTO_CHECKS_BY_SKILL[skill];
    isCheckedByTeacher = AppStrings.TEACHERS_CHECKS_BY_SKILL[skill];
    entitle = Text(skill);
  }
}

class SkillBlock {
  ListTile header;
  List<Skill> skills;
  bool isExpanded;

  SkillBlock(String blockName, List<String> skillsNames) {
    header = ListTile(
        title: Text(blockName,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)));
    skills = generateSkills(skillsNames);
    isExpanded = true;
  }
}

/*class LevelBlock {
  ListTile header;
  List<Skill> skills;
  bool isExpanded;

  LevelBlock(String blockName) {
    header = ListTile(
        title: Text(blockName,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)));
    skills = generateSkills(AppStrings.SKILLS_BY_LEVEL[blockName]);
    isExpanded = true;
  }
}*/

List<Skill> generateSkills(List<String> skillsBlock) {
  return List.generate(skillsBlock.length, (int index) {
    return Skill(skillsBlock[index]);
  });
}

/*List<SkillBlock> generateSkillsBlocks() {
  final blocks = AppStrings.SKILLS_BLOCKS;
  return List.generate(blocks.length, (int index) {
    return SkillBlock(blocks[index]);
  });
}*/

/*List<LevelBlock> generateLevelBlocks() {
  final blocks = AppStrings.LEVEL_BLOCKS;
  return List.generate(blocks.length, (int index) {
    return LevelBlock(blocks[index]);
  });
}*/