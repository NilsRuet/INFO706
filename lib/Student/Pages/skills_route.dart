import 'package:flutter/material.dart';
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
  final _skillsBlocksList = generateSkillsBlocks();

  @override
  Widget build(BuildContext context) {
    return _skillsList();
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

