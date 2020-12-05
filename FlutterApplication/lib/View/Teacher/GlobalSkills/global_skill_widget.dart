import 'package:flutter/material.dart';
import 'package:info706/Model/Data/Info.dart';
import 'package:info706/View/Common/SkillsViews/skill_widget.dart';

/// Competence que peut acquerir un etudiant, selon le point de vue étudiant

// ignore: must_be_immutable
class GlobalSkillWidget extends SkillWidget{
  GlobalSkillWidget(SkillInfo skill, bool levelIsMainInfo) : super(skill, levelIsMainInfo);

  @override
  SkillWidgetState createState() => _GlobalSkillWidgetState();
}

class _GlobalSkillWidgetState extends SkillWidgetState{
  @override
  initState(){
    super.initState();
    header = _GlobalSkillHeaderWidget(widget.isLevelMainInfo?block:level);
  }

  @override
  void longPressAction() {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    showMenu(
        context: context,
        items: <PopupMenuEntry<MenuEntries>>[EditDeleteEntry()],
        position: RelativeRect.fromRect(
            tapPosition & const Size(40, 40),
            Offset.zero & overlay.semanticBounds.size
        )
    ).then<void>((MenuEntries value) {
      if (value == null) return;
      setState(() {
        print(value);
      });
    });

}
}

/// En-tête d'une compétence, selon le point de vue étudiant
// ignore: must_be_immutable
class _GlobalSkillHeaderWidget extends SkillHeaderWidget{

  _GlobalSkillHeaderWidget(Text secondaryInformation) : super.withoutAssessment(secondaryInformation);

  @override
  _GlobalSkillHeaderWidgetState createState() => _GlobalSkillHeaderWidgetState();
}

class _GlobalSkillHeaderWidgetState extends SkillHeaderWidgetState{

  @override
  List<Widget> headerChildren()=> [Expanded(child:widget.secondaryInformation),];
}

// Choix possibles dans le menu popup
enum MenuEntries {edit, delete}

// Entrées du menu popup
// ignore: must_be_immutable
class EditDeleteEntry extends PopupMenuEntry<MenuEntries> {

  @override
  double height = 100; // Aucune importance, puisqu'on donne pas de valeur initiale au showMenu()

  @override
  bool represents(MenuEntries n) => n == MenuEntries.delete || n == MenuEntries.edit;

  @override
  EditDeleteEntryState createState() => EditDeleteEntryState();
}

class EditDeleteEntryState extends State<EditDeleteEntry> {

  void _edit() => Navigator.pop<MenuEntries>(context, MenuEntries.edit);

  void _delete() => Navigator.pop<MenuEntries>(context, MenuEntries.delete);

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