import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:info706/Model/Cache/CacheManager.dart';
import 'package:info706/Model/Cache/DataManager.dart';
import 'package:info706/Model/Data/Skill.dart';
import 'package:info706/Resources/app_strings.dart';
import 'package:info706/View/Common/add_skill_route.dart';
import 'package:info706/View/Common/navigation_drawer_route.dart';

class DebugView extends NavigationDrawerRoute {
  @override
  Widget build() {
    return DebugWidget();
  }

  @override
  String getViewName() {
    return "Debug";
  }
}

class DebugWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new DebugState();
  }
}

class DebugState extends State<DebugWidget>{

  Widget _view;

  @override
  void initState() {
    super.initState();
    loadSkillBlocks();
    _view = Container();
  }

  @override
  Widget build(BuildContext context) {
    return _view;
  }

  void loadSkillBlocks() async{
    Skill s = GlobalSkill.fromData(0, 0, "Intitulé de la compétence TODO", CompetencyLevel.A1);
    List<SkillBlock> lsb = await CacheManager.getSkillBlocks();
    setState(() {
      _view =  AddSkillRoute(AppStrings.ADD_SKILL_TITLE,s, lsb,  (skill) => print(skill.name+" "+skill.level.toString()+" "+skill.blockId.toString()));
    });
  }

}