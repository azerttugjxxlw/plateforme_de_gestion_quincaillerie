import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../api_connection/api_connection.dart';
import '../../core/constants/color_constants.dart';
import 'article_list.dart';




String selectedValue = "B1";
TextEditingController designation = TextEditingController();
TextEditingController prix_up  = TextEditingController();
TextEditingController quantite = TextEditingController();
TextEditingController description = TextEditingController();
TextEditingController categorie= TextEditingController();
int? etat=1;


class Stock extends StatefulWidget {
  const Stock({Key? key}) : super(key: key);

  @override
  State<Stock> createState() => _StockState();
}

class _StockState extends State<Stock> {
  late bool error, sending, success;
  late String msg;

  bool showUpperContainer = false;
  @override
  void reload(){
    setState(() {
        currentPage = Stock();
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
                      "Stock",
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
            ),const SizedBox(height: 20,),
            Container(
              child: Imprespsion(reload),
            ),


            //  const DateScreen(),

            SizedBox(width: double.infinity,height: 2,child: Container(color: Colors.black,),),
            Container(
              height: MediaQuery.of(context).size.height *0.77,
                child:  ArticleList(),
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
   var resp =  http.post(Uri.parse(API.addarticleapi),
        body: {
          "Nom_article":designation.text.toString(),
          "prix_up":prix_up.text.toString(),
          "qteStock":quantite.text.toString(),
          " description":description.text.toString(),
          "etat_article":etat.toString(),
          "categorie":categorie.text.toString(),
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

                        const SizedBox(height: 10,),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                width: MediaQuery.of(context).size.width * 0.23,
                                height: 50,
                                child: TextFormField(
                                  controller: designation,
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return "Champ vide";
                                    }
                                  },
                                  keyboardType: TextInputType.name,
                                  maxLines: 1,
                                  minLines: 1,
                                  decoration: new InputDecoration(
                                    hintText: "Designation : ",
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                width: MediaQuery.of(context).size.width * 0.203,
                                height: 50,
                                child: TextFormField(
                                  controller:categorie ,
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return "Champ vide";
                                    }
                                  },
                                  keyboardType: TextInputType.name,
                                  maxLines: 1,
                                  minLines: 1,
                                  decoration: new InputDecoration(
                                    hintText: "categorie : ",
                                  ),
                                ),
                              ),

                            ]),
                        const SizedBox(height: 12,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                              width: MediaQuery.of(context).size.width * 0.23,
                              height: 50,
                              child: TextFormField(
                                controller: prix_up,
                                validator: (value){
                                  if(value!.isEmpty){
                                    return "Champ vide";
                                  }
                                },
                                keyboardType: TextInputType.name,
                                maxLines: 1,
                                minLines: 1,
                                decoration: new InputDecoration(
                                  hintText: "Prix UP : ",
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
                            controller: quantite,
                            validator: (value){
                              if(value!.isEmpty){
                                return "Champ vide";
                              }
                            },
                            keyboardType: TextInputType.name,
                            maxLines: 1,
                            minLines: 1,
                            decoration: new InputDecoration(
                              hintText: "Quantité : ",
                            ),
                          ),
                        ),
                        const SizedBox(height: 15,),
                        Container(
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                          width: MediaQuery.of(context).size.width * 0.23,
                          height: 50,
                          child: TextFormField(
                            controller: description,
                            validator: (value){
                              if(value!.isEmpty){
                                return "Champ vide";
                              }
                            },
                            keyboardType: TextInputType.name,
                            maxLines: 1,
                            minLines: 1,
                            decoration: new InputDecoration(
                              hintText: "Description : ",
                            ),
                          ),
                        ),
                        const SizedBox(height: 35,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  sending = true;
                                  addData();
                                  showUpperContainer = false;
                                  designation.clear();
                                  prix_up.clear();
                                  quantite.clear();
                                  categorie.clear();
                                  etat=1;
                                  quantite.clear();
                                  description.clear();
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
