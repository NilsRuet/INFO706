class AppStrings{

  //SkillsPage
  static const ASK_ROLE = 'Je suis un enseignant';
  static const MY_SKILLS_ROUTE_TITLE = 'Mes compétences';
  static const SORT_BY_BLOCK = "Trier par bloc";
  static const SORT_BY_LEVEL = "Trier par niveau";
  static const ADD_SKILL_TITLE = "Ajouter une compétence";
  static const EDIT_SKILL_TITLE = "Modifier la compétence";
  static const ADD_SKILL_NAME_FIELD = "Intitulé";
  static const ADD_SKILL_LEVEL_FIELD = "Niveau de la compétence";
  static const ADD_SKILL_BLOCK_FIELD = "Bloc de la compétence";
  static const CONFIRM_BUTTON = "Valider";

  //TODO: all these const have to disappear with the DB
  static const SKILLS_BLOCKS = ['Compréhension écrite', 'Compréhension orale', 'Expression écrite', 'Expression orale'];
  static const LEVEL_BLOCKS = ['A1', 'A2', 'B1', 'B2', 'C1', 'C2'];

  static const SKILLS_BY_BLOCK = {
    'Compréhension écrite':
    ['Je peux lire des textes courts très simples.',
      'Je peux comprendre la description d\'événements, l\'expression de sentiments et de souhaits dans des lettres personnelles.'],
    'Compréhension orale': [
      'Je peux comprendre des mots familiers et des expressions très courantes au sujet de moi-même, de ma famille et de l\'environnement concret et immédiat, si les gens parlent lentement et distinctement.',
      'Je peux comprendre les émissions de télévision et les films sans trop d\'effort.'],
    'Expression écrite': [
      'Je peux écrire des textes clairs etdétaillés sur une grande gamme desujets relatifs à mes intérêts.',
      'Je peux comprendre les livres sans trop d\'effort.'],
    'Expression orale': [
      'Je peux utiliser une série de phrases ou d\'expressions pour décrire en termes simples ma famille et d\'autres gens, mes conditions de vie, ma formation et mon activité professionnelle actuelle ou récente.',
      'Je peux raconter une histoire ou l\'intrigue d\'un livre ou d\'un film et exprimer mes réactions.'
    ]};
  static const SKILLS_BY_LEVEL ={
    'A1':
    ['Je peux comprendre des mots familiers et des expressions très courantes au sujet de moi-même, de ma famille et de l\'environnement concret et immédiat, si les gens parlent lentement et distinctement.'],
    'A2':
    [ 'Je peux lire des textes courts très simples.',
      'Je peux utiliser une série de phrases ou d\'expressions pour décrire en termes simples ma famille et d\'autres gens, mes conditions de vie, ma formation et mon activité professionnelle actuelle ou récente.'],
    'B1':
    [ 'Je peux comprendre la description d\'événements, l\'expression de sentiments et de souhaits dans des lettres personnelles.',
      'Je peux raconter une histoire ou l\'intrigue d\'un livre ou d\'un film et exprimer mes réactions.'],
    'B2':
    ['Je peux écrire des textes clairs etdétaillés sur une grande gamme desujets relatifs à mes intérêts.'],
    'C1':
    ['Je peux comprendre les émissions de télévision et les films sans trop d\'effort.'],
    'C2':
    ['Je peux comprendre les livres sans trop d\'effort.'],
  };

  static const LEVELS_BY_SKILL = {
    'Je peux lire des textes courts très simples.' : 'A2',
    'Je peux comprendre la description d\'événements, l\'expression de sentiments et de souhaits dans des lettres personnelles.' : 'B1',
    'Je peux comprendre des mots familiers et des expressions très courantes au sujet de moi-même, de ma famille et de l\'environnement concret et immédiat, si les gens parlent lentement et distinctement.' : 'A1',
    'Je peux comprendre les émissions de télévision et les films sans trop d\'effort.' : 'C1',
    'Je peux écrire des textes clairs etdétaillés sur une grande gamme desujets relatifs à mes intérêts.' : 'B2',
    'Je peux comprendre les livres sans trop d\'effort.' : 'C2',
    'Je peux utiliser une série de phrases ou d\'expressions pour décrire en termes simples ma famille et d\'autres gens, mes conditions de vie, ma formation et mon activité professionnelle actuelle ou récente.' : 'A2',
    'Je peux raconter une histoire ou l\'intrigue d\'un livre ou d\'un film et exprimer mes réactions.': 'B1'
  };
  static const BLOCKS_BY_SKILL = {
    'Je peux lire des textes courts très simples.' : 'CE',
    'Je peux comprendre la description d\'événements, l\'expression de sentiments et de souhaits dans des lettres personnelles.' : 'CE',
    'Je peux comprendre des mots familiers et des expressions très courantes au sujet de moi-même, de ma famille et de l\'environnement concret et immédiat, si les gens parlent lentement et distinctement.' : 'CO',
    'Je peux comprendre les émissions de télévision et les films sans trop d\'effort.' : 'CO',
    'Je peux écrire des textes clairs etdétaillés sur une grande gamme desujets relatifs à mes intérêts.' : 'EE',
    'Je peux comprendre les livres sans trop d\'effort.' : 'CE',
    'Je peux utiliser une série de phrases ou d\'expressions pour décrire en termes simples ma famille et d\'autres gens, mes conditions de vie, ma formation et mon activité professionnelle actuelle ou récente.' : 'EO',
    'Je peux raconter une histoire ou l\'intrigue d\'un livre ou d\'un film et exprimer mes réactions.': 'EO'
  };

  static const TEACHERS_CHECKS_BY_SKILL = {
    'Je peux lire des textes courts très simples.' : true,
    'Je peux comprendre la description d\'événements, l\'expression de sentiments et de souhaits dans des lettres personnelles.' : false,
    'Je peux comprendre des mots familiers et des expressions très courantes au sujet de moi-même, de ma famille et de l\'environnement concret et immédiat, si les gens parlent lentement et distinctement.' : true,
    'Je peux comprendre les émissions de télévision et les films sans trop d\'effort.' : false,
    'Je peux écrire des textes clairs etdétaillés sur une grande gamme desujets relatifs à mes intérêts.' : false,
    'Je peux comprendre les livres sans trop d\'effort.' : false,
    'Je peux utiliser une série de phrases ou d\'expressions pour décrire en termes simples ma famille et d\'autres gens, mes conditions de vie, ma formation et mon activité professionnelle actuelle ou récente.' : true,
    'Je peux raconter une histoire ou l\'intrigue d\'un livre ou d\'un film et exprimer mes réactions.': true
  };
  static const AUTO_CHECKS_BY_SKILL = {
    'Je peux lire des textes courts très simples.' : true,
    'Je peux comprendre la description d\'événements, l\'expression de sentiments et de souhaits dans des lettres personnelles.' : false,
    'Je peux comprendre des mots familiers et des expressions très courantes au sujet de moi-même, de ma famille et de l\'environnement concret et immédiat, si les gens parlent lentement et distinctement.' : true,
    'Je peux comprendre les émissions de télévision et les films sans trop d\'effort.' : false,
    'Je peux écrire des textes clairs etdétaillés sur une grande gamme desujets relatifs à mes intérêts.' : false,
    'Je peux comprendre les livres sans trop d\'effort.' : false,
    'Je peux utiliser une série de phrases ou d\'expressions pour décrire en termes simples ma famille et d\'autres gens, mes conditions de vie, ma formation et mon activité professionnelle actuelle ou récente.' : true,
    'Je peux raconter une histoire ou l\'intrigue d\'un livre ou d\'un film et exprimer mes réactions.': true
  };

  static const NAVIGATION_DRAWER = ['Compétences','Liste des élèves'];

}