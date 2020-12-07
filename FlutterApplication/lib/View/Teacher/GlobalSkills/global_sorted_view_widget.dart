import 'package:info706/Model/Data/Info.dart';
import 'package:info706/Resources/app_strings.dart';
import 'package:info706/View/Common/SkillsViews/skill_block_widget.dart';
import 'package:info706/View/Common/SkillsViews/sorted_view_widget.dart';

import 'global_skill_block_widget.dart';

/// Liste de blocs de competences globales, à surcharger selon la façon dont on veut trier

abstract class GlobalSortedViewWidget extends SortedViewWidget {}

abstract class _GlobalSortedViewState extends SortedViewState {

  _GlobalSortedViewState(List<BlockInfo> blocks) : super(blocks);

  @override
  List<SkillBlockWidget> generateBlocks() {
    return List.generate(blocks.length, (int index) => GlobalSkillBlockWidget(blocks[index], true, isLevelMainInfo()));
  }
}

///Liste de blocs de competences globales, tries selon le niveau de chaque competence
class GlobalSortedByLevelWidget extends GlobalSortedViewWidget{
  @override
  SortedViewState createState(){
    state = _GlobalSortedByLevelState();
    return state;
  }

  @override
  String getName() => AppStrings.SORT_BY_LEVEL;
}

class _GlobalSortedByLevelState extends _GlobalSortedViewState{

  _GlobalSortedByLevelState():super(BlocksListInfo.sortedByLevel);

  @override
  bool isLevelMainInfo() => true;
}

///Liste de blocs de competences du point de vue étudiant, tries selon la categorie de chaque competence
class GlobalSortedBySkillBlockWidget extends GlobalSortedViewWidget{
  @override
  SortedViewState createState(){
    state = GlobalSortedBySkillBlockState();
    return state;
  }

  @override
  String getName() => AppStrings.SORT_BY_BLOCK;
}

class GlobalSortedBySkillBlockState extends _GlobalSortedViewState{

  GlobalSortedBySkillBlockState():super(BlocksListInfo.sortedByCategory);

  @override
  bool isLevelMainInfo() => false;
}

