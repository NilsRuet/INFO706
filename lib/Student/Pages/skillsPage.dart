import 'package:flutter/material.dart';
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
        body: block.generateSkillsList(),
        isExpanded: block.isExpanded,
        canTapOnHeader: true));

    return panels;
  }

  void _addingSkillForm() {}



}


class SkillBlock{
  ListTile header;
  List<String> skills;
  bool isExpanded;

  SkillBlock(String blockName){
    header = ListTile(title: Text(
        blockName,
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)));
    skills = AppStrings.SKILLS_BY_BLOC[blockName];
    isExpanded = true;
  }

  Widget generateSkillsList() {
    /*final List<Widget> skillsList = new List.empty(growable:true);
    //print(skills);
   /*for (String skill in skills){
      skillsList.add(new ListTile(title: Text(skill)));
    }*/
    return ListView(children: skillsList);*/
    return SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Container(
        child:ListView(
      shrinkWrap:true,
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        Container(
          height: 50,
          color: Colors.amber[600],
          child: const Center(child: Text('Entry A')),
        ),
        Container(
          height: 50,
          color: Colors.amber[500],
          child: const Center(child: Text('Entry B')),
        ),
        Container(
          height: 50,
          color: Colors.amber[100],
          child: const Center(child: Text('Entry C')),
        ),
      ],
    )));
  }
}


List<SkillBlock> generateSkillsBlocks() {
  final blocks = AppStrings.SKILLS_BLOCKS;
  return List.generate(blocks.length, (int index) {
    return SkillBlock(blocks[index]);
  });
}

