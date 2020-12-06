import 'package:info706/Model/Data/Info.dart';
import 'package:info706/Resources/app_strings.dart';
import 'package:info706/View/Common/SkillsViews/skill_block_widget.dart';
import 'package:info706/View/Common/SkillsViews/sorted_view_widget.dart';
import 'package:info706/View/Teacher/StudentSkills/teacher_skill_block_widget.dart';

/// Liste de blocs de competences du point de vue enseignant, à surcharger selon la façon dont on veut trier
abstract class TeacherSortedViewWidget extends SortedViewWidget {}

abstract class _TeacherSortedViewState extends SortedViewState {

  _TeacherSortedViewState(List<BlockInfo> blocks) : super(blocks);

  @override
  List<SkillBlockWidget> generateBlocks() {
    return List.generate(blocks.length, (int index) => TeacherSkillBlockWidget(blocks[index], true, isLevelMainInfo()));
  }
}

///Liste de blocs de competences du point de vue enseignant, tries selon le niveau de chaque competence
class TeacherSortedByLevelWidget extends TeacherSortedViewWidget{
  @override
  SortedViewState createState() => _TeacherSortedByLevelState();

  @override
  String getName() => AppStrings.SORT_BY_LEVEL;
}

class _TeacherSortedByLevelState extends _TeacherSortedViewState{

  _TeacherSortedByLevelState() : super(BlocksListInfo.sortedByLevel);

  @override
  bool isLevelMainInfo() => true;
}

///Liste de blocs de competences du point de vue enseignant, tries selon la categorie de chaque competence
class TeacherSortedBySkillBlockWidget extends TeacherSortedViewWidget{
  @override
  SortedViewState createState() => TeacherSortedBySkillBlockState();

  @override
  String getName() => AppStrings.SORT_BY_BLOCK;
}

class TeacherSortedBySkillBlockState extends _TeacherSortedViewState{
  
  TeacherSortedBySkillBlockState() : super(BlocksListInfo.sortedByCategory);

  @override
  bool isLevelMainInfo() => false;
}
