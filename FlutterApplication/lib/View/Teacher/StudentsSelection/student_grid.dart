import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:info706/Resources/app_colors.dart';
import 'package:info706/View/Common/navigation_drawer_route.dart';
import 'package:info706/Model/Cache/CacheManager.dart';
import 'package:info706/Model/Data/User.dart';
import 'package:info706/View/Teacher/StudentSkills/selected_student_skills_route.dart';

class _StudentGridState extends State<StudentGrid>{

  List<Student> _students = List<Student>();
  List<Student> _filteredStudents = List<Student>();
  String _filter = "";
  Image _placeholder = Image(
    image:NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg')//TODO remove
  );

  @override
  void initState(){
    super.initState();
    _loadStudents();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder:(context, orientation){
        return GridView.builder(
          itemCount: _filteredStudents.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: orientation==Orientation.portrait ? 3 : 6,
              childAspectRatio: 0.8
          ),
          itemBuilder: (BuildContext context, int index){
            return _getStudentWidget(_filteredStudents[index]);
          },
        );
      }
    );
  }

  Widget _getStudentWidget(Student student){
    return InkWell(
      onTap: (){},//TODO
      child: Card(
        child: Container(
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _placeholder,
              Expanded(
                child:Container(
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                  color: AppColors.BACKGROUND_COLOR,
                  child: Align(
                    child: Text(student.name,
                        textAlign: TextAlign.center),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );

  }

  bool matches(Student student, String filter){
    if(filter.length == 0) return true;
    return student.name.toLowerCase().startsWith(filter.toLowerCase());
  }

  void filter(String filter){
    setState(() {
      this._filter = filter;
      _filteredStudents = _students.where((student) => matches(student, _filter)).toList();
    });
  }

  void _loadStudents() async{
    //final students = await CacheManager.getStudents();
    final List<Student> students = List();
    students.add(Student({'user_id': 1, 'name': 'Paul'}));
    _updateStudents(students);
  }

  void _updateStudents(List<Student> students){
    setState(() {
      this._students = students;
      _filteredStudents = _students.where((student) => matches(student, _filter)).toList();
    });
  }
}

class StudentGrid extends StatefulWidget{

  _StudentGridState _currentState;

  @override
  State<StatefulWidget> createState(){
    _currentState = _StudentGridState();
    return _currentState;
  }

  void filter(String filter){
    _currentState.filter(filter);
  }
}