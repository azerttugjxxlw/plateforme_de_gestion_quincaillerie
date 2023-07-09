class Emploer {
  int id_employe;
  String nom_employe;
 // String prenom_employe;
  String mot_de_passe;
  //String post;
  Emploer(
  this.id_employe,
  this.nom_employe,
  //this.prenom_employe,
  this.mot_de_passe,
  //this.post,

      );
  Map<String, dynamic> toJson() =>{
    'id_employe': id_employe.toString(),
    'nom_employe': nom_employe.toString(),
   // 'prenom_employe': prenom_employe.toString(),
    'mot_de_passe': mot_de_passe.toString(),
    //'post': post.toString(),
  };
}