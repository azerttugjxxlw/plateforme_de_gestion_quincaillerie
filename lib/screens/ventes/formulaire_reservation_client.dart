import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/constants/color_constants.dart';


class FormulaireReservationClient extends StatefulWidget {
  @override
  _FormulairReservationClient createState() => _FormulairReservationClient();
}

class _FormulairReservationClient extends State<FormulaireReservationClient> {
  int id = 1;
  String selectedValue = "Double_Deluxe";
  var nom = TextEditingController();
  var prenom = TextEditingController();
  var email = TextEditingController();
  var genre = TextEditingController();
  var tel = TextEditingController();
  var adresse = TextEditingController();
  String? sexe;
  var res_dateDebut = DateTime.now();
  var res_dateFin = DateTime.now();
  late String type_chambre_id;
  double total = 0.0;
  int nb_personne = 0;

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Double Deluxe"), value: "Double_Deluxe"),
      DropdownMenuItem(
          child: Text("Double Economique"), value: "Double_Economique"),
      DropdownMenuItem(
          child: Text("Double Classique"), value: "Double_Classique"),
      DropdownMenuItem(child: Text("Double Confort"), value: "Double_Confort"),
      DropdownMenuItem(
          child: Text("lits Jumeaux Classique"),
          value: "lits_Jumeaux_Classique"),
      DropdownMenuItem(
          child: Text("Triple Economique"), value: "Triple_Economique"),
      DropdownMenuItem(
          child: Text("Quadruple Familiale"), value: "Quadruple_Familiale"),
      DropdownMenuItem(
          child: Text("Quadruple Familiale (lit sup.)"),
          value: "Quadruple_Familiale_(lit sup.)"),
    ];
    return menuItems;
  }

  String radioButtonItem = 'H';
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(builder: (context, constraints) {
      return AnimatedContainer(
          duration: Duration(milliseconds: 500),
          color: Color.fromRGBO(241, 234,227, 1),
          padding: constraints.maxWidth < 800
              ? EdgeInsets.zero
              : const EdgeInsets.all(30.0),
          child: Form(
            key: formKey,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.50,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 100),
                      margin: EdgeInsets.symmetric(vertical: 0),
                      color: Color.fromRGBO(11, 6, 65, 1),
                      child: Text(
                        "FORMULAIRE DE RESERVATION",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 26),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                width: MediaQuery.of(context).size.width * 0.23,
                                height: 50,
                                child: TextFormField(
                                  controller: nom,
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return "Champ vide";
                                    }
                                  },
                                  keyboardType: TextInputType.name,
                                  maxLines: 1,
                                  minLines: 1,
                                  decoration: new InputDecoration(
                                    hintText: "Nom : ",
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                height: 50,
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      'Genre : ',
                                      style: new TextStyle(fontSize: 17.0),
                                    ),
                                    Radio(
                                      value: 1,
                                      groupValue: id,
                                      onChanged: (val) {
                                        setState(() {
                                          radioButtonItem = 'F';
                                          sexe= 'F';
                                          id = 1;
                                        });
                                      },
                                    ),
                                    Text(
                                      'F',
                                      style: new TextStyle(fontSize: 17.0),
                                    ),
                                    Radio(
                                      value: 2,
                                      groupValue: id,
                                      onChanged: (val) {
                                        setState(() {
                                          radioButtonItem = 'H';
                                          sexe= 'H';
                                          id = 2;
                                        });
                                      },
                                    ),
                                    Text(
                                      'H',
                                      style: new TextStyle(
                                        fontSize: 17.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                            width: MediaQuery.of(context).size.width * 0.50,
                            height: 50,
                            child: TextFormField(
                              controller: prenom,
                              validator: (value){
                                if(value!.isEmpty){
                                  return "Champ vide";
                                }
                              },
                              keyboardType: TextInputType.text,
                              maxLines: 1,
                              minLines: 1,
                              decoration: new InputDecoration(
                                hintText: "Prenom : ",
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                            width: MediaQuery.of(context).size.width * 0.50,
                            height: 50,
                            child: TextFormField(
                              controller: email,
                              validator: (value){
                                if(value!.isEmpty){
                                  return "Champ vide";
                                }
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: new InputDecoration(
                                hintText: "Email : ",
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                            width: MediaQuery.of(context).size.width * 0.50,
                            height: 50,
                            child: TextFormField(
                              controller: tel,
                              validator: (value){
                                if(value!.isEmpty){
                                  return "Champ vide";
                                }
                              },
                              keyboardType: TextInputType.phone,
                              maxLines: 1,
                              minLines: 1,
                              decoration: new InputDecoration(
                                hintText: "Tel : ",
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                width: MediaQuery.of(context).size.width * 0.23,
                                height: 50,
                                child: TextFormField(
                                  onChanged: (value){
                                    nb_personne = int.parse(value);
                                  },
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return "Champ vide";
                                    }
                                  },
                                  keyboardType: TextInputType.number,
                                  maxLines: 1,
                                  minLines: 1,
                                  decoration: new InputDecoration(
                                    hintText: "Nb personne :",
                                  ),
                                ),
                              ),

                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                                width: MediaQuery.of(context).size.width * 0.23,
                                height: 50,
                                child: DropdownButton(
                                  disabledHint: Text("selectionner"),
                                  value: selectedValue,
                                  items: dropdownItems,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedValue = newValue!;
                                    });
                                  },
                                ),
                              ),

                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                width: MediaQuery.of(context).size.width * 0.22,
                                height: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(05),
                                  //  color: kTextpagecardColor
                                ),
                                child: Center(
                                    child: Text("Total : 1000",
                                        style: TextStyle(fontSize: 20))),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: kTiroirColor,
                                      //onPrimary: Colors.black,
                                    ),
                                    child: Text("Enregistrer",
                                        style: TextStyle(color: Colors.white)),
                                    onPressed: () {
                                      setState(() {
                                       /* if(formKey.currentState!.validate()){
                                          ReservationModel resModel = ReservationModel(
                                              nb_personne: nb_personne,
                                              date_debut_res: res_dateDebut,
                                              date_fin_res: res_dateFin,
                                              nom: nom.text,
                                              prenom: prenom.text.trim(),
                                              email: email.text.trim(),
                                              telephone: tel.text.trim(),
                                              sexe: sexe!.trim());
                                          /* ClientModel clientModel = ClientModel(
                                                nom: nom.text,
                                                prenom: prenom.text.trim(),
                                                email: email.text.trim(),
                                                telephone: tel.text.trim(),
                                                sexe: sexe!.trim());*/
                                       //   ReservationModel.insertReservation(resModel,context);
                                          nom.clear();
                                          prenom.clear();
                                          email.clear();
                                          tel.clear();
                                        }*/


                                      });




                                    }),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ));
    }));
  }
}
