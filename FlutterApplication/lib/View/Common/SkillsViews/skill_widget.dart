import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:info706/Model/Data/Info.dart';
import 'package:info706/Resources/app_colors.dart';
import 'package:info706/Resources/app_strings.dart';
import 'package:info706/View/Common/SkillsViews/app_widgets.dart';
import 'package:info706/View/Common/SkillsViews/skills_view.dart';

import '../add_skill_route.dart';

/// Competence que peut acquerir un etudiant, à surcharger selon s'il on veux le point de vue étudiant ou enseignant

// ignore: must_be_immutable
abstract class SkillWidget extends StatefulWidget{
  SkillInfo skill;
  bool isLevelMainInfo;

  SkillWidget(this.skill, this.isLevelMainInfo);
}

abstract class SkillWidgetState extends State<SkillWidget>{
  Text level;
  Text block;
  bool isAutoChecked;
  bool isCheckedByTeacher;
  Text _entitle;
  SkillHeaderWidget header;
  Offset tapPosition;

  @override
  void initState() {
    super.initState();
    SkillInfo currentSkill = widget.skill;
    level = Text(describeEnum(currentSkill.level),
            style: TextStyle(color: AppColors.CATEGORY_COLORS[currentSkill.level.index]));
    block = Text(currentSkill.category.name,
        style: TextStyle(color: AppColors.CATEGORY_COLORS[currentSkill.category.index]));
    isAutoChecked = currentSkill.isAutoChecked;
    isCheckedByTeacher = currentSkill.isCheckedByTeacher;
    _entitle = Text(currentSkill.name);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GestureDetector(
        onTapDown: _storePosition,
        child:ListTile(
          title: header,
          subtitle: _entitle,
          contentPadding: EdgeInsets.fromLTRB(16.0, .0, 16.0, 16.0),
          onLongPress: longPressAction,
      )),
      elevation: 20.0,
      semanticContainer: false,
    );
  }

  void _storePosition(TapDownDetails details) {
    tapPosition = details.globalPosition;
  }

  void longPressAction() {
    if (widget.skill.isPersonal)
      openPopupMenu();
  }

  void openPopupMenu() {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    showMenu(
        context: context,
        items: <PopupMenuEntry<bool>>[EditDeleteEntry(widget.skill)],
        position: RelativeRect.fromRect(
            tapPosition & const Size(40, 40),
            Offset.zero & overlay.semanticBounds.size
        )
    ).then<void>((bool value) {
      if (value == null) return;
      setState(() {
        if (!value)
          Scaffold.of(context).showSnackBar(AppWidgets.connectionSnackBar);
        else
          SkillsViewState.currentSkillViewState.loadDataForDisplay();
      });
    });

  }
}

/// En-tête d'une compétence, à surcharger selon s'il on veux le point de vue étudiant ou enseignant
// ignore: must_be_immutable
abstract class SkillHeaderWidget extends StatefulWidget{
  SkillInfo skill;
  Text secondaryInformation;
  bool isAutoChecked;
  bool isCheckedByTeacher;

  SkillHeaderWidget(this.skill, this.secondaryInformation, this.isAutoChecked, this.isCheckedByTeacher);

  SkillHeaderWidget.withoutAssessment(this.secondaryInformation);
}

abstract class SkillHeaderWidgetState extends State<SkillHeaderWidget>{
  @override
  Widget build(BuildContext context) => Row(children: headerChildren());

  List<Widget> headerChildren();
}

// Entrées du menu popup
// ignore: must_be_immutable
class EditDeleteEntry extends PopupMenuEntry<bool> {

  SkillInfo _skill;
  @override
  double height = 100; // Aucune importance, puisqu'on donne pas de valeur initiale au showMenu()

  EditDeleteEntry(this._skill):super();

  @override
  bool represents(bool n) => n == true || n == false;

  @override
  EditDeleteEntryState createState() => EditDeleteEntryState();

}

class EditDeleteEntryState extends State<EditDeleteEntry> {

  void _edit() {
      Navigator.push(context,
        MaterialPageRoute(builder: (context) =>
            AddSkillRoute(AppStrings.EDIT_SKILL_TITLE, widget._skill.modelSkill, BlocksListInfo.modelCategoryBlocksList,
                    (skill) async => closePopupWithResult(await widget._skill.tryEdit(skill)))),
      );
  }

  Future<void> _delete() async => closePopupWithResult(await widget._skill.delete());

  void closePopupWithResult(bool res) => Navigator.pop<bool>(context, res);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(child: IconButton(onPressed: _edit, icon: Icon(Icons.edit), splashRadius: 0.1,)),
        Expanded(child: IconButton(onPressed: _delete, icon: Icon(Icons.delete), splashRadius: 0.1,)),
      ],
    );
  }

}