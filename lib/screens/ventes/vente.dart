import 'dart:convert';
import 'dart:ffi';
import 'dart:math';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../api_connection/api_connection.dart';
import '../../core/constants/color_constants.dart';
import 'article_liste_formulaire.dart';
import 'vente_list.dart';




//client
TextEditingController nom_client = TextEditingController();
TextEditingController prenom_client = TextEditingController();
TextEditingController num = TextEditingController();
//facture
//TextEditingController prix_up  = TextEditingController();
int? bon=1;
DateTime now = DateTime.now();
var formattedDate = DateFormat('EEEE, MMM d, yyyy').format(now);
double? tva= 0.0;
double? prix=0.0;
TextEditingController remise = TextEditingController();
//panier
TextEditingController qt_article = TextEditingController();

TextEditingController article_panier= TextEditingController();



class Ventes extends StatefulWidget {
  const Ventes({Key? key}) : super(key: key);

  @override
  State<Ventes> createState() => _VentesState();
}

class _VentesState extends State<Ventes> {
  late bool error, sending, success;
  late String msg;
//listeformulaire


  bool _showForm = false;
  void _toggleFormVisibility() {
    setState(() {
      _showForm = !_showForm;
    });
  }
// listeformulaire
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
                      "Ventes",
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
                          onPressed: _toggleFormVisibility,
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
              child: Imprespsion(reload,_toggleFormVisibility),
            ),
            //  const DateScreen(),
            SizedBox(width: double.infinity,height: 2,child: Container(color: Colors.black,),),
            Container(

              height: MediaQuery.of(context).size.height *0.77,
                child:Stack(
                  children: [
                    VentesList(),
                    if (_showForm) Positioned(

                child: formulaire(),
              ),
                  ],
                )
            ),
          ],
        ),

    );

  }
  ///////////////////////////////////////////////////

  @override
  void initState() {

    super.initState();

    error = false;
    sending = false;
    success = false;
    msg = "";
    super.initState();
  }



 /* void form() async{


    return showDialog(

        context: context, builder: (BuildContext context){
          return StatefulBuilder(builder: (context, setState){
            return AlertDialog( content:Container(
              child: Container(
                    width: MediaQuery.of(context).size.width * 0.550,
                    height: MediaQuery.of(context).size.height * 0.65,
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
                                    keyboardType: TextInputType.number,
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
                                    keyboardType: TextInputType.number,
                                    maxLines: 1,
                                    minLines: 1,
                                    decoration: new InputDecoration(
                                      hintText: "Remise : ",
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  width: MediaQuery.of(context).size.width * 0.23,
                                  height: 50,
                                  child: Text("TVA :"),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  width: MediaQuery.of(context).size.width * 0.23,
                                  height: 50,
                                  child: Text("Prix Hors Taxe :"),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  width: MediaQuery.of(context).size.width * 0.23,
                                  height: 50,
                                  child: Text( 'Total: \$${_calculateTotal().toStringAsFixed(2)}'),
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
                                  height: 20,
                                  child:Text("")

                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  width: MediaQuery.of(context).size.width * 0.21,
                                  height:MediaQuery.of(context).size.width * 0.23,
                                  decoration:  BoxDecoration(

                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    )
                                  ),
                                  child:Expanded(

                                    child: ListView.builder(
                                      itemCount: _cartItems.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          title: Text(_cartItems[index].Nom_article),
                                          subtitle: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('Price: \$${_cartItems[index].prix_up.toStringAsFixed(2)}'),
                                              TextField(
                                                decoration: InputDecoration(labelText: 'Quantity'),
                                                keyboardType: TextInputType.number,
                                                onChanged: (newValue) {
                                                  _updateQuantity(index, double.parse(newValue));

                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      },
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
                            )
                        ),




                      ],

                    ),
                  ),

            ) );
          });
    }
    );
  }*/


////////////////////////////////////////////////////

}
Widget Imprespsion(reload,VoidCallback onPressed)
{
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      IconButton(onPressed: onPressed, icon: Icon(Icons.add)),
      IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
      IconButton(onPressed: (){},icon: Icon(Icons.print),),
      IconButton(onPressed: (){},icon: Icon(Icons.document_scanner_sharp),),


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


/*class FloatingSalesForm extends StatefulWidget {

//double total =0;
  @override
  State<FloatingSalesForm> createState() => _FloatingSalesFormState();
}

class _FloatingSalesFormState extends State<FloatingSalesForm> {
  List<Product> _cartItems = [];
  void _fetchProducts() async {
    final response = await http.get(Uri.parse(API.listarticleapi));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        _cartItems = data.map((item) => Product(item['id_article'], item['Nom_article'].toString() , item['prix_up'].toDouble(), 0.0)).toList();
      });
    }
  }

  void _updateQuantity(int index, double newQuantity) {
    setState(() {
      _cartItems[index].quantity = newQuantity;
    });
  }

  double _calculateTotal() {
    double total = 0;
    for (var item in _cartItems) {
      total += item.prix_up * item.quantity;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.550,
        height: MediaQuery.of(context).size.height * 0.65,
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
                        keyboardType: TextInputType.number,
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
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        minLines: 1,
                        decoration: new InputDecoration(
                          hintText: "Remise : ",
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                      width: MediaQuery.of(context).size.width * 0.23,
                      height: 50,
                      child: Text("TVA :"),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                      width: MediaQuery.of(context).size.width * 0.23,
                      height: 50,
                      child: Text("Prix Hors Taxe :"),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                      width: MediaQuery.of(context).size.width * 0.23,
                      height: 50,
                      child: Text( 'Total: \$${_calculateTotal().toStringAsFixed(2)}'),
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
                        height: 20,
                        child:Text("")

                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                      width: MediaQuery.of(context).size.width * 0.21,
                      height:MediaQuery.of(context).size.width * 0.23,
                      decoration:  BoxDecoration(

                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          )
                      ),
                      child:Expanded(

                        child: ListView.builder(
                          itemCount: _cartItems.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(_cartItems[index].Nom_article),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Price: \$${_cartItems[index].prix_up.toStringAsFixed(2)}'),
                                  TextField(
                                    decoration: InputDecoration(labelText: 'Quantity'),
                                    keyboardType: TextInputType.number,
                                    onChanged: (newValue) {
                                      _updateQuantity(index, double.parse(newValue));

                                    },
                                  ),
                                ],
                              ),
                            );
                          },
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
                )
            ),




          ],

        ),
      ),
    );
  }
}*/
