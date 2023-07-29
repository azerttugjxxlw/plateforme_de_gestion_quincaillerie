import 'dart:convert';
import 'dart:math';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../api_connection/api_connection.dart';
import '../../core/constants/color_constants.dart';
import 'vente_list.dart';




String selectedValue = "B1";
TextEditingController nom_client = TextEditingController();
TextEditingController prix_up  = TextEditingController();
TextEditingController prenom_client = TextEditingController();
TextEditingController remise = TextEditingController();
TextEditingController num = TextEditingController();
TextEditingController article_panier= TextEditingController();
int? etat=1;



class Ventes extends StatefulWidget {
  const Ventes({Key? key}) : super(key: key);

  @override
  State<Ventes> createState() => _VentesState();
}

class _VentesState extends State<Ventes> {
  late bool error, sending, success;
  late String msg;

  bool showUpperContainer = false;
  @override
  void reload(){
    setState(() {
        currentPage = Ventes();
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
                child:  VentesList(),
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
          "nom_client":nom_client.text.toString(),
          "prenom_client":prenom_client.text.toString(),
          " num":num.text.toString(),
          "prix_up":prix_up.text.toString(),

          "etat_article":etat.toString(),
          "categorie":article_panier.text.toString(),
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
                    child:Row(
                      children:<Widget> [
                        Expanded(
                            child: Column(
                              children:<Widget> [
                                Container(
                                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  width: MediaQuery.of(context).size.width * 0.23,
                                  height: 50,
                                  child: TextFormField(
                                    controller: nom_client,
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return "Champ vide";
                                      }
                                    },
                                    keyboardType: TextInputType.name,
                                    maxLines: 1,
                                    minLines: 1,
                                    decoration: new InputDecoration(
                                      hintText: "Nom du client : ",
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  width: MediaQuery.of(context).size.width * 0.23,
                                  height: 50,
                                  child: TextFormField(
                                    controller: prenom_client,
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return "Champ vide";
                                      }
                                    },
                                    keyboardType: TextInputType.name,
                                    maxLines: 1,
                                    minLines: 1,
                                    decoration: new InputDecoration(
                                      hintText: "prenom du client : ",
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  width: MediaQuery.of(context).size.width * 0.23,
                                  height: 50,
                                  child: TextFormField(
                                    controller: num,
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return "Champ vide";
                                      }
                                    },
                                    keyboardType: TextInputType.name,
                                    maxLines: 1,
                                    minLines: 1,
                                    decoration: new InputDecoration(
                                      hintText: "Tel du client : ",
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  width: MediaQuery.of(context).size.width * 0.23,
                                  height: 50,
                                  child: TextFormField(
                                    controller: remise,
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return "Champ vide";
                                      }
                                    },
                                    keyboardType: TextInputType.name,
                                    maxLines: 1,
                                    minLines: 1,
                                    decoration: new InputDecoration(
                                      hintText: "Remise : ",
                                    ),
                                  ),
                                ),

                              ],
                            )
                        ),
                        Expanded(
                            child: Column(
                              children:<Widget> [
                                Container(
                                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  width: MediaQuery.of(context).size.width * 0.23,
                                  height: 50,
                                  child:
                                  TypeAheadField(
                                    textFieldConfiguration: TextFieldConfiguration(
                                      autofillHints: ["AutoFillHints 1", "AutoFillHints 2"],
                                      autofocus: true,
                                      style: DefaultTextStyle.of(context)
                                          .style
                                          .copyWith(fontStyle: FontStyle.italic),
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'What are you looking for?'),
                                    ),
                                    suggestionsCallback: (pattern) async {
                                      return await BackendService.getSuggestions(pattern);
                                    },
                                    itemBuilder: (context, Map<String, String> suggestion) {
                                      return ListTile(
                                        leading: Icon(Icons.shopping_cart),
                                        title: Text(suggestion['name']!),
                                        subtitle: Text('\$${suggestion['price']}'),
                                      );
                                    },
                                    itemSeparatorBuilder: (context, index) {
                                      return Divider();
                                    },
                                    onSuggestionSelected: (Map<String, String> suggestion) {
                                    //  Navigator.of(context).push<void>(MaterialPageRoute(
                                       //   builder: (context) => ProductPage(product: suggestion)));
                                    },
                                    suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      elevation: 8.0,
                                      color: Theme.of(context).cardColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  width: MediaQuery.of(context).size.width * 0.23,
                                  height: 50,
                                  child: TextFormField(
                                    controller: nom_client,
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return "Champ vide";
                                      }
                                    },
                                    keyboardType: TextInputType.name,
                                    maxLines: 1,
                                    minLines: 1,
                                    decoration: new InputDecoration(
                                      hintText: "selection article : ",
                                    ),
                                  ),
                                ),
                              ],
                            )
                        )
                      ],
                    ),
                  ),

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
class BackendService {
  static Future<List<Map<String, String>>> getSuggestions(String query) async {
    await Future<void>.delayed(Duration(seconds: 1));

    return List.generate(3, (index) {
      return {
        'name': query + index.toString(),
        'price': Random().nextInt(100).toString()
      };
    });
  }
}