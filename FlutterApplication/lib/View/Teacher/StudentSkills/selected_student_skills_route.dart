import 'package:info706/Model/Data/Info.dart';
import 'package:info706/Model/Data/Skill.dart';
import 'package:info706/Model/Data/User.dart';
import 'package:info706/Resources/app_strings.dart';
import 'package:info706/View/Common/SkillsViews/skills_view.dart';
import 'package:info706/View/Teacher/StudentSkills/teacher_sorted_view_widget.dart';

// Vue des compétences d'un étudiant, du point de vue enseignant

// ignore: must_be_immutable
class SelectedStudentSkillsView extends SkillsView {

  Teacher teacher;

  SelectedStudentSkillsView(Student currentStudent, this.teacher)
      : super(currentStudent, AppStrings.SELECTED_STUDENT_SKILLS_ROUTE_TITLE + currentStudent.name);

  @override
  SkillsViewState createState() => _SelectedStudentSkillsViewState(teacher);
}

class _SelectedStudentSkillsViewState extends SkillsViewState {
  _SelectedStudentSkillsViewState(Teacher teacher):
        super.fromOverridingClass(TeacherSortedBySkillBlockWidget(teacher), TeacherSortedByLevelWidget(teacher));

  @override
  Skill createEmptySkill() => PersonalSkill.fromData(0, 0, "", CompetencyLevel.A1, widget.currentStudent.id);

  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}