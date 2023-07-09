import 'dart:ffi';

import 'package:flutter/material.dart';


class ArticleModel {
  String? id_article;
  String? Nom_article;
  late Bool etat_article;
  late Double prix_up;
  late Double qteStock;
  late String description;
  late String categorie;

  ArticleModel(
      {
        required this.Nom_article,
        required this.etat_article,
        required this.prix_up,
        required this.qteStock,
        required this.description,
        required this.categorie
      });

  ArticleModel.fromJson(Map<String, dynamic> json) {
    id_article = json['id_article'];
    Nom_article = json['Nom_article'];
    etat_article= json['etat_article'];
     prix_up = json['prix_up'];
    qteStock= json['qteStock'];
    description = json['description'];
    categorie= json['categorie'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = new Map <String, dynamic>();
    _data['id_article'] = id_article;
    _data['Nom_article'] = Nom_article;
    _data['etat_article'] = etat_article;
    _data['prix_up'] = prix_up;
    _data['qteStock'] = qteStock;
    _data['description'] = description;
    _data['categorie'] = categorie;
    return _data;
  }
}
