import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:plateforme_de_gestion_quincaillerie/screens/dashboard/components/article_model.dart';
import 'package:plateforme_de_gestion_quincaillerie/screens/stock/article_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:toggle_switch/toggle_switch.dart';

import '../../../api_connection/api_connection.dart';
import '../../../core/constants/color_constants.dart';
import 'fourniseur_list.dart';





TextEditingController nom_fourniseur  = TextEditingController();
TextEditingController prenom_fourniseur = TextEditingController();
TextEditingController numero_fourniseur = TextEditingController();
TextEditingController article = TextEditingController();
int? etat=1;


class Fourniseur extends StatefulWidget {
  const Fourniseur({Key? key}) : super(key: key);

  @override
  State<Fourniseur> createState() => _FourniseurState();
}

class _FourniseurState extends State<Fourniseur> {
  late bool error, sending, success;
  late String msg;

  bool showUpperContainer = false;
  @override
  void reload(){
    setState(() {
        currentPage = Fourniseur();
    });
  }
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
          children:<Widget> [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height *0.09,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black45, offset: Offset(1, 1), blurRadius: 1)
                ],
                color: const Color.fromRGBO(241, 234, 227, 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Fourniseur",
                      style: GoogleFonts.josefinSans(
                          textStyle: TextStyle(
                            fontSize: 24,
                            color: Color.fromRGBO(11, 6, 65, 1),
                          )),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16),
                        child: Row(
                          children: [
                            Container(
                              width: 200,
                              child: const TextField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Recherche',
                                    fillColor: Colors.white),
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.search),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton.icon(
                          icon: Icon(Icons.add_box_rounded),
                          onPressed: () {
                            setState(() {
                              form();
                              showUpperContainer = true;
                              print("action sur le button");
                            });

                          },
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromRGBO(241, 234, 227, 1),
                            backgroundColor: const Color.fromRGBO(11, 6, 65, 1),
                          ),
                          label: Text("Nouvelle"),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),const SizedBox(height: 5,),
            Container(
              child:Column(
                children: [
                  Imprespsion(reload),
                  //tableHeader()
                ],
              )
            ),


            //  const DateScreen(),

            SizedBox(width: double.infinity,height: 2,child: Container(color: Colors.black,),),
            Container(
              height: MediaQuery.of(context).size.height *0.4,
                child:  FourniseurList(),
            ),
          ],
        ),

    );
  }
  ///////////////////////////////////////////////////


  @override
  void initState() {
    error = false;
    sending = false;
    success = false;
    msg = "";
    super.initState();
  }

 void addData()  {
   var resp =  http.post(Uri.parse(API.addfourniseurapi),
        body: {
          "nom_fourniseur":nom_fourniseur.text.toString(),
          "prenom_fourniseur":prenom_fourniseur.text.toString(),
          "num_fourniseur":numero_fourniseur.text.toString(),
          "article":article.text.toString(),
        }
    );

  }
  form(){
    return showDialog(
        context: context, builder: (BuildContext context){
          return StatefulBuilder(builder: (context, setState){
            return AlertDialog( content:Container(
              child: Container(
                    width: MediaQuery.of(context).size.width * 0.450,
                    height: MediaQuery.of(context).size.height * 0.55,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 18),
                                onPressed: () {
                                  setState(() {
                                    showUpperContainer = false;
                                    Navigator.pop(context);
                                  });
                                },
                                icon: const Icon(Icons.cancel_rounded,color: Color.fromRGBO(11, 6, 65, 1),)
                            ),
                          ],
                        ),

                        const SizedBox(height: 12,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                              width: MediaQuery.of(context).size.width * 0.23,
                              height: 50,
                              child: TextFormField(
                                controller: nom_fourniseur,
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
                            ToggleSwitch(
                              minWidth: 50.0,
                              cornerRadius: 5.0,
                              activeBgColors: [
                                [Colors.red[800]!],
                                [Colors.green[800]!]

                              ],
                              activeFgColor: Colors.white,
                              inactiveBgColor: Colors.grey,
                              inactiveFgColor: Colors.white,
                              initialLabelIndex: 1,
                              totalSwitches: 2,
                              labels: ['Desa', 'Acti'],
                              radiusStyle: true,
                              onToggle: (index) {
                                print('switched to: $index');
                                etat = index;
                                print('etat ==  $etat');
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 12,),
                        Container(
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                          width: MediaQuery.of(context).size.width * 0.23,
                          height: 50,
                          child: TextFormField(
                            controller: prenom_fourniseur,
                            validator: (value){
                              if(value!.isEmpty){
                                return "Champ vide";
                              }
                            },
                            keyboardType: TextInputType.name,
                            maxLines: 1,
                            minLines: 1,
                            decoration: new InputDecoration(
                              hintText: "Prenom : ",
                            ),
                          ),
                        ),
                        const SizedBox(height: 15,),
                        Container(
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                          width: MediaQuery.of(context).size.width * 0.23,
                          height: 50,
                          child: TextFormField(
                            controller: article,
                            validator: (value){
                              if(value!.isEmpty){
                                return "Champ vide";
                              }
                            },
                            keyboardType: TextInputType.name,
                            maxLines: 1,
                            minLines: 1,
                            decoration: new InputDecoration(
                              hintText: "Article: ",
                            ),
                          ),
                        ),
                        const SizedBox(height: 15,),
                        Container(
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                          width: MediaQuery.of(context).size.width * 0.23,
                          height: 50,
                          child: TextFormField(
                            controller: numero_fourniseur,
                            validator: (value){
                              if(value!.isEmpty){
                                return "Champ vide";
                              }
                            },
                            keyboardType: TextInputType.number,
                            maxLines: 1,
                            minLines: 1,
                            decoration: new InputDecoration(
                              hintText: "Tel: ",
                            ),
                          ),
                        ),
                        const SizedBox(height: 15,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: kTiroirColor, //background color of button
                                  side: BorderSide(width:3, color:Colors.brown), //border width and color
                                  elevation: 3, //elevation of button
                                  shape: RoundedRectangleBorder( //to set border radius to button
                                      borderRadius: BorderRadius.circular(30)
                                  ),
                                  padding: EdgeInsets.all(20) //content padding inside button
                              ),
                              onPressed: () {
                                setState(() {
                                  sending = true;
                                  addData();
                                  print('envoier');
                                  showUpperContainer = false;
                                  nom_fourniseur.clear();
                                  prenom_fourniseur.clear();
                                  numero_fourniseur.clear();
                                  article.clear();
                                });
                              },
                              child: new Text(
                                "Enregistre",
                                style: TextStyle(color: Colors.white),
                              ),

                            ),
                            const SizedBox(height: 15,),
                          ],
                        )
                      ],
                    ),
                  )

            ) );
          });
    }
    );
  }

  tableHeader() {

      return Row(
        children: [
          DataTable(
            headingRowColor: MaterialStateColor.resolveWith(
                    (states) => const Color.fromRGBO(11, 6, 65, 1)),
            dataRowHeight: 35,
            headingRowHeight: 35,
            columnSpacing: MediaQuery.of(context).size.width * 0.091,

            columns: [
              DataColumn(
                label: Text(
                  "ID",
                  style: columnTextStyle,
                ),
              ),
              DataColumn(
                label: Text(
                  "Nom",
                  style: columnTextStyle,
                  overflow: TextOverflow.visible,
                  softWrap: true,
                ),
              ),
              DataColumn(
                label: Text(
                  "Etat",
                  style: columnTextStyle,
                  overflow: TextOverflow.visible,
                  softWrap: true,
                ),
              ),
              DataColumn(
                label: Text(
                  "Prix UP",
                  style: columnTextStyle,
                  overflow: TextOverflow.visible,
                  softWrap: true,
                ),
              ),
              DataColumn(
                label: Text(
                  "QTE",
                  style: columnTextStyle,
                  overflow: TextOverflow.visible,
                  softWrap: true,
                ),
              ),
              DataColumn(
                label: Text(
                  "Description",
                  style: columnTextStyle,
                  overflow: TextOverflow.visible,
                  softWrap: true,
                ),
              ),
              DataColumn(
                label: Text(
                  "categorie ",
                  style: columnTextStyle,
                  overflow: TextOverflow.visible,
                  softWrap: true,
                ),
              ),

            ],
            rows: const [],

            dataRowColor: MaterialStateProperty.all(Colors.green.shade100),
          ), // start

          // end
        ],
      );


  }


////////////////////////////////////////////////////

}
Widget Imprespsion(reload)
{
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      IconButton(onPressed: (){}, icon: Icon(Icons.add)),
      IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
      IconButton(onPressed: (){},icon: Icon(Icons.print),),
      IconButton(onPressed: (){},icon: Icon(Icons.document_scanner_sharp),),
      IconButton(onPressed: (){
        reload;
      },icon: Icon(Icons.refresh),),
      TextButton(onPressed: (){}, child: Text("vent récent")),
    ],
  );
}

