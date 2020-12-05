import 'package:info706/Model/Data/Info.dart';
import 'package:info706/Resources/app_strings.dart';
import 'package:info706/View/Common/SkillsViews/skill_block_widget.dart';
import 'package:info706/View/Common/SkillsViews/sorted_view_widget.dart';
import 'package:info706/View/Student/PersonalSkills/student_skill_block_widget.dart';

/// Liste de blocs de competences du point de vue étudiant, à surcharger selon la façon dont on veut trier

abstract class StudentSortedViewWidget extends SortedViewWidget {}

abstract class _StudentSortedViewState extends SortedViewState {

  _StudentSortedViewState(List<BlockInfo> blocks) : super(blocks);

  @override
  List<SkillBlockWidget> generateBlocks() {
    return List.generate(blocks.length, (int index) => StudentSkillBlockWidget(blocks[index], true, isLevelMainInfo()));
  }
}

///Liste de blocs de competences du point de vue étudiant, tries selon le niveau de chaque competence
class StudentSortedByLevelWidget extends StudentSortedViewWidget{
  @override
  SortedViewState createState() => _StudentSortedByLevelState();

  @override
  String getName() => AppStrings.SORT_BY_LEVEL;
}

class _StudentSortedByLevelState extends _StudentSortedViewState{

  _StudentSortedByLevelState():super(BlocksListInfo.sortedByLevel);

  @override
  bool isLevelMainInfo() => true;
}

///Liste de blocs de competences du point de vue étudiant, tries selon la categorie de chaque competence
class StudentSortedBySkillBlockWidget extends StudentSortedViewWidget{
  @override
  SortedViewState createState() => StudentSortedBySkillBlockState();

  @override
  String getName() => AppStrings.SORT_BY_BLOCK;
}

class StudentSortedBySkillBlockState extends _StudentSortedViewState{

  StudentSortedBySkillBlockState():super(BlocksListInfo.sortedByCategory);

  @override
  bool isLevelMainInfo() => false;
}

