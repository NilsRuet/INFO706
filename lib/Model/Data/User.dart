// Utilisateur de l'application
abstract class User{
  int _id;
  String name;

  //Accès à id en lecture seule
  int get id{
    return _id;
  }

  //Constructeur par défaut à partir d'un json
  User(Map<String, dynamic> json){
    this._id = json['user_id'];
    this.name = json['name'];
  }
}

// Utilisateur etudiant
class Student extends User
{
  //Constructeur par défaut
  Student(Map<String, dynamic> json) : super(json);

  String repr() {
    return "repr : $name ($_id)";
  }
}

// Utilisateur enseignant
class Teacher extends User
{
  //Constructeur par défaut
  Teacher(Map<String, dynamic> json) : super(json);
}