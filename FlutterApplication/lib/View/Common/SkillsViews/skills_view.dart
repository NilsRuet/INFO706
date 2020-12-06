import 'package:flutter/material.dart';
import 'package:info706/Model/Data/Info.dart';
import 'package:info706/Model/Data/User.dart';
import 'package:info706/View/Common/SkillsViews/sorted_view_widget.dart';

/// Vue des compétences, à surcharger selon s'il on veux le point de vue étudiant ou enseignant

// ignore: must_be_immutable
abstract class SkillsView extends StatefulWidget {
  Student _currentStudent;
  String _routeTitle;

  SkillsView(this._currentStudent, this._routeTitle);
  SkillsView.globalView(this._routeTitle);
}

abstract class SkillsViewState extends State<SkillsView> {
  static SkillsViewState currentSkillViewState;
  SortedViewWidget _currentSortedView;
  SortedViewWidget _sortedBySkillBlockView;
  SortedViewWidget _sortedByLevelView;
  bool loaded = false;

  SkillsViewState(){
    _currentSortedView = _sortedBySkillBlockView;
  }

  SkillsViewState.fromOverridingClass(this._sortedBySkillBlockView, this._sortedByLevelView){
    _currentSortedView = _sortedBySkillBlockView;
  }

  @override
  void initState(){
    super.initState();
    currentSkillViewState = this;
    loadDataForDisplay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _skillsPageAppBar(),
        floatingActionButton: _addingSkillButton(),
        body: loaded? Column(children: [_sortingButton(), Expanded(child: _currentSortedView)])
                      :Center(child:CircularProgressIndicator()));
  }

  AppBar _skillsPageAppBar() {
    return AppBar(
      title: Text(widget._routeTitle),
      centerTitle: true,
    );
  }

  Widget _sortingButton() {
    return Container(
        child: DropdownButton<SortedViewWidget>(
          value: _currentSortedView,
          underline: Container(height: 2, color: Theme.of(context).accentColor,),
          onChanged: (SortedViewWidget newValue) {
            setState(() => _currentSortedView = newValue);
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

  FloatingActionButton _addingSkillButton() {
    return FloatingActionButton(
      onPressed: _addingSkillForm,
      child: Icon(Icons.add),
    );
  }

  // TODO: a lier au formulaire, et surement à deplacer en meme temps
  void _addingSkillForm() {}

  void loadDataForDisplay() async {
    setState(() => this.loaded = false);
    await InfoManager.loadSelectedStudentSkillsRouteInformation(widget._currentStudent.id);
    updateDataForDisplay();
  }

  void updateDataForDisplay() {
    setState(() => this.loaded = true);
  }
}