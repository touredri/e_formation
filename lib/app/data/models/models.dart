class Utilisateur {
  final String id;
  final String nom;
  final String email;
  final String motDePasse;

  Utilisateur({
    required this.id,
    required this.nom,
    required this.email,
    required this.motDePasse,
  });

  factory Utilisateur.fromJson(Map<String, dynamic> json) => Utilisateur(
    id: json['id'],
    nom: json['nom'],
    email: json['email'],
    motDePasse: json['motDePasse'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'nom': nom,
    'email': email,
    'motDePasse': motDePasse,
  };
}

class Formation {
  final String id;
  final String titre;
  final String description;
  final int duree;

  Formation({
    required this.id,
    required this.titre,
    required this.description,
    required this.duree,
  });

  factory Formation.fromJson(Map<String, dynamic> json) => Formation(
    id: json['id'],
    titre: json['titre'],
    description: json['description'],
    duree: json['duree'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'titre': titre,
    'description': description,
    'duree': duree,
  };
}

class Inscription {
  final String id;
  final String idUtilisateur;
  final String idFormation;
  final DateTime dateInscription;

  Inscription({
    required this.id,
    required this.idUtilisateur,
    required this.idFormation,
    required this.dateInscription,
  });

  factory Inscription.fromJson(Map<String, dynamic> json) => Inscription(
    id: json['id'],
    idUtilisateur: json['idUtilisateur'],
    idFormation: json['idFormation'],
    dateInscription: DateTime.parse(json['dateInscription']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'idUtilisateur': idUtilisateur,
    'idFormation': idFormation,
    'dateInscription': dateInscription.toIso8601String(),
  };
}

class Quiz {
  final String id;
  final String idFormation;
  final String question;
  final String bonneReponse;

  Quiz({
    required this.id,
    required this.idFormation,
    required this.question,
    required this.bonneReponse,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) => Quiz(
    id: json['id'],
    idFormation: json['idFormation'],
    question: json['question'],
    bonneReponse: json['bonneReponse'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'idFormation': idFormation,
    'question': question,
    'bonneReponse': bonneReponse,
  };
}

class ReponseQuiz {
  final String id;
  final String idUtilisateur;
  final String idQuiz;
  final String reponseDonnee;
  final bool estCorrecte;

  ReponseQuiz({
    required this.id,
    required this.idUtilisateur,
    required this.idQuiz,
    required this.reponseDonnee,
    required this.estCorrecte,
  });

  factory ReponseQuiz.fromJson(Map<String, dynamic> json) => ReponseQuiz(
    id: json['id'],
    idUtilisateur: json['idUtilisateur'],
    idQuiz: json['idQuiz'],
    reponseDonnee: json['reponseDonnee'],
    estCorrecte: json['estCorrecte'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'idUtilisateur': idUtilisateur,
    'idQuiz': idQuiz,
    'reponseDonnee': reponseDonnee,
    'estCorrecte': estCorrecte,
  };
}
