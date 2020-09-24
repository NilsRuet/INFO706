import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:info706/Resources/appColors.dart';
import 'package:info706/Resources/appStrings.dart';
import 'package:info706/Student/Common/studentDrawer.dart';

// The Student skills page

class MySkillsPage extends StatefulWidget {
  @override
  _MySkillsPageState createState() => _MySkillsPageState();
}

class _MySkillsPageState extends State<MySkillsPage> {
  final _skillsBlocksList = generateSkillsBlocks();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _skillsPageAppBar(),
      drawer: StudentDrawer(),
      floatingActionButton: _addingSkillButton(),
      body : _skillsList()
    );
  }

  AppBar _skillsPageAppBar() {
    return AppBar(
      title: Text(AppStrings.SKILLS_PAGE_TITLE),
      centerTitle: true,
    );
  }

  FloatingActionButton _addingSkillButton(){
    return FloatingActionButton(
      onPressed: _addingSkillForm,
      child: Icon(Icons.add),
    );
  }

  Widget _skillsList() {
    return SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Container(
            child:ExpansionPanelList(
                expandedHeaderPadding: EdgeInsets.all(10.0),
                animationDuration: Duration(milliseconds: 800),
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    _skillsBlocksList[index].isExpanded= !isExpanded;
                  });
                },
                children: _skillsBlocksPanel())));
  }

  List<ExpansionPanel> _skillsBlocksPanel() {
    List<ExpansionPanel> panels = new List.empty(growable: true);

    for (SkillBlock block in _skillsBlocksList)
      panels.add(ExpansionPanel(
        headerBuilder: (BuildContext context, bool isExpanded) { return block.header;},
        body: _generateSkillsList(block.skills),
        isExpanded: block.isExpanded,
        canTapOnHeader: true));

    return panels;
  }

  Widget _generateSkillsList(List<String> skills) {
    final List<Widget> skillsList = new List.empty(growable:true);
    for (String skill in skills){
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

  Widget _generateSkillItem(String skill) {
    final level = AppStrings.LEVELS_BY_SKILL[skill];
    return Card(child: ListTile(
      title: Row(children: [
        Expanded(child: Text(level, style: TextStyle(color: AppColors.LEVELS_COLORS[level]))),
        Checkbox(value: true, onChanged: (bool newVal) {}), Icon(Icons.check_box)],),
      subtitle: Text(skill),
      contentPadding: EdgeInsets.fromLTRB(16.0, .0, 16.0, 16.0),
      ),
    elevation: 20.0,
    semanticContainer: false,);

  }

  void _addingSkillForm() {}

}


class SkillBlock {
  ListTile header;
  List<String> skills;
  bool isExpanded;

  SkillBlock(String blockName) {
    header = ListTile(title: Text(
        blockName,
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)));
    skills = AppStrings.SKILLS_BY_BLOC[blockName];
    isExpanded = true;
  }
}


List<SkillBlock> generateSkillsBlocks() {
  final blocks = AppStrings.SKILLS_BLOCKS;
  return List.generate(blocks.length, (int index) {
    return SkillBlock(blocks[index]);
  });
}

