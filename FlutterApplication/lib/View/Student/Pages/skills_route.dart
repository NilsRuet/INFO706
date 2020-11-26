import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:info706/View/Common/navigation_drawer_route.dart';
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
  @override
  _MySkillsViewState createState() => _MySkillsViewState();
}

class _MySkillsViewState extends State<_MySkillsView> {
  SortedViewWidget _currentSortedView;
  SortedBySkillBlockWidget sortedBySkillBlockView = SortedBySkillBlockWidget();
  SortedByLevelWidget sortedByLevelView = SortedByLevelWidget();

  _MySkillsViewState(){
    _currentSortedView = sortedBySkillBlockView;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _skillsPageAppBar(),
        floatingActionButton: _addingSkillButton(),
        body: Column(
            children: [_sortingButton(), Expanded(child: _currentSortedView)]));
  }

  AppBar _skillsPageAppBar() {
    return AppBar(
      title: Text(AppStrings.MY_SKILLS_ROUTE_TITLE),
      centerTitle: true,
    );
  }

  Widget _sortingButton() {
    return Container(
        child: DropdownButton<SortedViewWidget>(
          value: _currentSortedView,
          underline: Container(height: 2, color: Theme.of(context).accentColor,),
          onChanged: (SortedViewWidget newValue) {
            setState(() {_currentSortedView = newValue;});
            },
          items: <SortedViewWidget>[sortedBySkillBlockView, sortedByLevelView].
          map<DropdownMenuItem<SortedViewWidget>>((SortedViewWidget value) {
                return DropdownMenuItem<SortedViewWidget>(
                  value: value,
                  child: Text(value.getName()),
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

  // TODO: link this to the addingForm
  void _addingSkillForm() {}
}

abstract class SortedViewWidget extends StatefulWidget {
  String getName();
}

abstract class SortedViewState extends State<SortedViewWidget> {
  //TODO private members?
  List<String> blocksNames = AppStrings.SKILLS_BLOCKS;
  Map<String, List<String>> blocks = AppStrings.SKILLS_BY_BLOCK;
  List<SkillBlock> blocksList;
  List<ExpansionPanel> _childrenPanels;

  @override
  void initState() {
    super.initState();
    blocksList = generateBlocks();
  }

  //TODO encapsulation? return value?
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
                  blocksList[index].isExpanded = !isExpanded;
                });
              },
              children: _blocksPanel(blocksList))));}

  List<SkillBlock> generateBlocks() {
    return List.generate(blocksNames.length, (int index) {
      return SkillBlock(blocksNames[index], blocks[blocksNames[index]], true);
    });
  }

  List<ExpansionPanel> _blocksPanel(List<SkillBlock> blocksList) {
    List<ExpansionPanel> panels = new List.empty(growable: true);
    for (SkillBlock block in blocksList)
      panels.add(ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return block.header;
          },
          isExpanded: block.isExpanded,
          body: block,
          canTapOnHeader: true));
    return panels;
  }
}

class SortedByLevelWidget extends SortedViewWidget{
  @override
  State<StatefulWidget> createState() {
    return SortedByLevelState();
  }

  @override
  String getName() {
    return "Trier par niveau";//TODO hardcoded
  }
}

class SortedByLevelState extends SortedViewState{
  @override
  List<String> blocksNames = AppStrings.LEVEL_BLOCKS;
  @override
  Map<String, List<String>> blocks = AppStrings.SKILLS_BY_LEVEL;
}

class SortedBySkillBlockWidget extends SortedViewWidget{
  @override
  State<StatefulWidget> createState() {
    return SortedBySkillBlockState();
  }

  @override
  String getName() {
    return "Trier par bloc";//TODO hardcoded
  }
}

class SortedBySkillBlockState extends SortedViewState{
  @override
  List<String> blocksNames = AppStrings.SKILLS_BLOCKS;
  @override
  Map<String, List<String>> blocks = AppStrings.SKILLS_BY_BLOCK;
}

class SkillBlock extends StatefulWidget{
  SkillBlockState _selfState;
  ListTile header;
  List<Skill> skills;
  bool isExpanded;

  SkillBlock(String blockName, List<String> skillsNames, bool isExpanded) {
    this.isExpanded = isExpanded;
    header = ListTile(
        title: Text(blockName,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)));
    skills = generateSkills(skillsNames, true);//TODO booleen constant à retirer
  }

  @override
  State<StatefulWidget> createState() {
    _selfState = SkillBlockState();
    return _selfState;
  }
}

class SkillBlockState extends State<SkillBlock>{

  SkillBlockState();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10.0, .0, 10.0, 10.0),
      child: Column(
        children: widget.skills,
        mainAxisSize: MainAxisSize.min,
      ),
    );
  }
}

class Skill extends StatefulWidget{
  String name;
  bool isLevelMainInfo;

  Skill(String skillName, bool levelIsMainInfo){
    name = skillName;
    isLevelMainInfo = levelIsMainInfo;
  }

  @override
  State<StatefulWidget> createState() {
    return SkillState(name);
  }
}

class SkillState extends State<Skill>{
  Text level;
  Text block;
  bool isAutoChecked;
  bool isCheckedByTeacher;
  Text entitle;

  SkillState(String skill) {
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

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Row(
          children: [
            Expanded(child: level),//TODO
            Checkbox(
                value: isAutoChecked,
                onChanged: (bool newVal) {
                  setState(() {
                    isAutoChecked = newVal;
                  });
                }),
            Icon(isCheckedByTeacher
                ? Icons.check_box
                : Icons.check_box_outline_blank)
          ],
        ),
        subtitle: entitle,
        contentPadding: EdgeInsets.fromLTRB(16.0, .0, 16.0, 16.0),
      ),
      elevation: 20.0,
      semanticContainer: false,
    );
  }
}

List<Skill> generateSkills(List<String> skillsNames, bool levelIsMainInfo) {
  return List.generate(skillsNames.length, (int index) {
    return Skill(skillsNames[index], levelIsMainInfo);
  });
}