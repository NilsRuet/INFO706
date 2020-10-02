import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:info706/Resources/appColors.dart';
import 'package:info706/Resources/appStrings.dart';
import 'package:info706/Student/Common/studentDrawer.dart';
import 'package:info706/Common/navigation_drawer_route.dart';
import 'package:info706/Resources/app_strings.dart';

// The Student skills page

class MySkillsDrawerRoute implements NavigationDrawerRoute{
  @override
  Widget build() {
    return _MySkillsView();
  }

  @override
  String getViewName() {
    return AppStrings.NAVIGATION_DRAWER[0];
  }
}

class _MySkillsView extends StatefulWidget {
  @override
  _MySkillsViewState createState() => _MySkillsViewState();
}

class _MySkillsViewState extends State<_MySkillsView> {
  String sortBy = AppStrings.SORT_BY_BLOCK;
  bool isSortedByBlock = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _skillsPageAppBar(),
        floatingActionButton: _addingSkillButton(),
        body: Column(
            children: [_sortingButton(), Expanded(child: isSortedByBlock?_skillsListBySkillsBlock():_skillsListByLevelBlock())]));
  }

  AppBar _skillsPageAppBar() {
    return AppBar(
      title: Text(AppStrings.SKILLS_PAGE_TITLE),
      centerTitle: true,
    );
  }

  Widget _sortingButton() {
    return Container(
        child: DropdownButton<String>(
          value: sortBy,
        underline: Container(
           height: 2,
           color: Theme.of(context).accentColor,
         ),
          onChanged: (String newValue) {
            setState(() {
              sortBy = newValue;
              isSortedByBlock = (sortBy == AppStrings.SORT_BY_BLOCK);
            });
            },
          items: <String>[AppStrings.SORT_BY_BLOCK, AppStrings.SORT_BY_LEVEL]
              .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
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

  Widget _skillsListBySkillsBlock() {
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
  }

  void _addingSkillForm() {}

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

  SkillBlock(String blockName) {
    header = ListTile(
        title: Text(blockName,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)));
    skills = generateSkills(AppStrings.SKILLS_BY_BLOC[blockName]);
    isExpanded = true;
  }
}

class LevelBlock {
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
}

List<Skill> generateSkills(List<String> skillsBloc) {
  return List.generate(skillsBloc.length, (int index) {
    return Skill(skillsBloc[index]);
  });
}

List<SkillBlock> generateSkillsBlocks() {
  final blocks = AppStrings.SKILLS_BLOCKS;
  return List.generate(blocks.length, (int index) {
    return SkillBlock(blocks[index]);
  });
}

List<LevelBlock> generateLevelBlocks() {
  final blocks = AppStrings.LEVEL_BLOCKS;
  return List.generate(blocks.length, (int index) {
    return LevelBlock(blocks[index]);
  });
}