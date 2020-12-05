import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:info706/Model/Cache/CacheManager.dart';
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
  List<String> _blocksNames = AppStrings.SKILLS_BLOCKS;
  Map<String, List<String>> _blocks = AppStrings.SKILLS_BY_BLOCK;
  List<SkillBlock> _blocksList;

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

  List<SkillBlock> _generateBlocks() {
    return List.generate(_blocksNames.length, (int index) {
      return SkillBlock(_blocksNames[index], _blocks[_blocksNames[index]], true, isLevelMainInfo());
    });
  }

  List<ExpansionPanel> _generateBlocksPanel(List<SkillBlock> blocksList) {
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

  bool isLevelMainInfo();
}

class SortedByLevelWidget extends SortedViewWidget{
  @override
  State<StatefulWidget> createState() {
    return SortedByLevelState();
  }

  @override
  String getName() {
    return AppStrings.SORT_BY_LEVEL;
  }
}

class SortedByLevelState extends SortedViewState{
  @override
  List<String> _blocksNames = AppStrings.LEVEL_BLOCKS;
  @override
  Map<String, List<String>> _blocks = AppStrings.SKILLS_BY_LEVEL;

  @override
  bool isLevelMainInfo() {
    return true;
  }
}

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

class SortedBySkillBlockState extends SortedViewState{
  @override
  List<String> _blocksNames = AppStrings.SKILLS_BLOCKS;
  @override
  Map<String, List<String>> _blocks = AppStrings.SKILLS_BY_BLOCK;

  @override
  bool isLevelMainInfo() {
    return false;
  }
}

class SkillBlock extends StatefulWidget{
  SkillBlockState _selfState;
  ListTile header;
  List<Skill> skills;
  bool isExpanded;

  SkillBlock(String blockName, List<String> skillsNames, bool isExpanded, bool isLevelMainInfo) {
    this.isExpanded = isExpanded;
    header = ListTile(
        title: Text(blockName,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)));
    skills = _generateSkills(skillsNames, isLevelMainInfo);
  }

  @override
  State<StatefulWidget> createState() {
    _selfState = SkillBlockState();
    return _selfState;
  }

  List<Skill> _generateSkills(List<String> skillsNames, bool levelIsMainInfo) {
    return List.generate(skillsNames.length, (int index) {
      return Skill(skillsNames[index], levelIsMainInfo);
    });
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
    return SkillState();
  }
}

class SkillState extends State<Skill>{
  Text level;
  Text block;
  bool isAutoChecked;
  bool isCheckedByTeacher;
  Text entitle;

  SkillState();

  @override
  void initState() {
    super.initState();
    String skill = widget.name;
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
            Expanded(child: widget.isLevelMainInfo?block:level),
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
