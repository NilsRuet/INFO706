import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:info706/Model/Data/Skill.dart';
import 'package:info706/Resources/app_colors.dart';
import 'package:info706/Resources/app_strings.dart';

class AddSkillRoute extends StatefulWidget{
  String _title;
  Skill _skill;
  List<SkillBlock> _blocks;
  void Function(Skill) _onComplete;

  AddSkillRoute(this._title,this._skill, this._blocks, this._onComplete);

  @override
  State<StatefulWidget> createState() {
    return AddSkillState(_title, _skill, _blocks, _onComplete);
  }
}

class AddSkillState extends State<AddSkillRoute>{
  String _title;
  Skill _skill;
  SkillBlock _chosenSkillBlock;
  CompetencyLevel _chosenLevel;
  List<SkillBlock> _blocks;
  void Function(Skill) _onComplete;
  TextField _nameField;
  final _nameController = TextEditingController();

  AddSkillState(this._title, this._skill, this._blocks, this._onComplete);

  @override
  void initState() {
    super.initState();
    _nameField = TextField(controller: _nameController, minLines: 1, maxLines: 500);
    _nameController.text = _skill.name;
    _chosenSkillBlock = _blocks.firstWhere((element) => (element.id == _skill.blockId), orElse:() => _blocks[0]);
    _chosenLevel = _skill.level;
  }

  Widget _getHeader(String title){
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
          margin: EdgeInsets.all(5),
          child: Text(title, style: TextStyle(fontSize: 20))
      ),
    );
  }

  Widget _getPanel(Widget title, Widget content){
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.fromLTRB(5,5,5,0),
                child: title)
            ,
            Divider(
              thickness: 2,
            ),
            Container(
                margin: EdgeInsets.fromLTRB(5,0,5,5),
                child: content)
          ],
        ),
      ),
    );
  }

  Widget _getLevelDropdown(){
    return DropdownButton<CompetencyLevel>(
      isExpanded: true,
      value:_chosenLevel,
      items: <CompetencyLevel>[CompetencyLevel.A1, CompetencyLevel.A2, CompetencyLevel.B1, CompetencyLevel.B2, CompetencyLevel.C1, CompetencyLevel.C2].
      map<DropdownMenuItem<CompetencyLevel>>((CompetencyLevel value) {
        return DropdownMenuItem<CompetencyLevel>(
            value: value,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(levelToString(value)),
            )
        );
      }).toList(),
      onChanged: (value){
        setState(() {
          _chosenLevel = value;
        });
      },
    );
  }

  Widget _getBlockDropdown(){
    return DropdownButton<SkillBlock>(
      isExpanded: true,
      value: _chosenSkillBlock,
      items: _blocks.map<DropdownMenuItem<SkillBlock>>((SkillBlock value) {
        return DropdownMenuItem<SkillBlock>(
          value: value,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(value.title),
          ),
        );
      }).toList(),
      onChanged: (value){
        setState(() {
          _chosenSkillBlock = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        centerTitle: true,
      ),
      body: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                    child:Column(
                      children: [
                        _getPanel(_getHeader(AppStrings.ADD_SKILL_NAME_FIELD),_nameField),
                        _getPanel(_getHeader(AppStrings.ADD_SKILL_LEVEL_FIELD),_getLevelDropdown()),
                        _getPanel(_getHeader(AppStrings.ADD_SKILL_BLOCK_FIELD),_getBlockDropdown()),
                      ],
                    )
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(5,0,5,0),
                child: RaisedButton(
                  color: AppColors.FOREGROUND_COLOR,
                  padding: EdgeInsets.all(10),
                  elevation: 10,
                  onPressed: (){
                    _skill.name=_nameController.text;
                    _skill.level=_chosenLevel;
                    _skill.blockId=_chosenSkillBlock.id;
                    _onComplete(_skill);
                  },
                  child: Text(AppStrings.CONFIRM_BUTTON,
                    style: TextStyle(fontSize: 20),),
                ),
              )
            ],
          ),
        ),
    );
  }

}