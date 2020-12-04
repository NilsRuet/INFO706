import 'package:flutter/material.dart';
import 'package:info706/Model/Data/Info.dart';
import 'package:info706/Model/Data/User.dart';
import 'package:info706/Resources/app_strings.dart';
import 'package:info706/View/Common/sorted_view_widget.dart';


// ignore: must_be_immutable
class SelectedStudentSkillsRoute extends StatefulWidget {
  Student currentStudent;

  SelectedStudentSkillsRoute(this.currentStudent);

  @override
  _SelectedStudentSkillsRouteState createState() => _SelectedStudentSkillsRouteState();
}

class _SelectedStudentSkillsRouteState extends State<SelectedStudentSkillsRoute> {
  SortedViewWidget _currentSortedView;
  SortedBySkillBlockWidget _sortedBySkillBlockView = SortedBySkillBlockWidget();
  SortedByLevelWidget _sortedByLevelView = SortedByLevelWidget();
  bool _loaded = false;

  _SelectedStudentSkillsRouteState(){
    _currentSortedView = _sortedBySkillBlockView;
  }

  @override
  void initState(){
    super.initState();
    _loadDataForDisplay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _skillsPageAppBar(),
        floatingActionButton: _addingSkillButton(),
        body: _loaded? Column(children: [_sortingButton(), Expanded(child: _currentSortedView)])
                      :Center(child:CircularProgressIndicator()));
  }

  AppBar _skillsPageAppBar() {
    return AppBar(
      title: Text(AppStrings.SELECTED_STUDENT_SKILLS_ROUTE_TITLE + widget.currentStudent.name),
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
          items: <SortedViewWidget>[_sortedBySkillBlockView, _sortedByLevelView].
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

  // TODO: est-ce qu'on le garde?
  FloatingActionButton _addingSkillButton() {
    return FloatingActionButton(
      onPressed: _addingSkillForm,
      child: Icon(Icons.add),
    );
  }

  // TODO: a lier au formulaire, et surement à deplacer en meme temps
  void _addingSkillForm() {}

  void _loadDataForDisplay() async {
    await InfoManager.loadSelectedStudentSkillsRouteInformation(widget.currentStudent.id);
    _updateDataForDisplay();
  }

  void _updateDataForDisplay() {
    setState(() {
      this._loaded = true;
    });
  }
}