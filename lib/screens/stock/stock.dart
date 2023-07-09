import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/color_constants.dart';
import 'article_list.dart';
import 'formulairearticle.dart';

class Stock extends StatefulWidget {
  const Stock({Key? key}) : super(key: key);

  @override
  State<Stock> createState() => _StockState();
}

class _StockState extends State<Stock> {
  @override
  void reload(){
    setState(() {
        currentPage = Stock();
    });
  }
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
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
                            buildContainer( context);
                           // currentPage = FormulaireReservationClient();
                            Navigator.pop(context);
                          //  Navigator.push(context, MaterialPageRoute(builder: (context)=>DesktopBody()));
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
          ),
          const SizedBox(
            height: 20,
          ),
        //  const DateScreen(),
          Impression(reload),
          SizedBox(width: double.infinity,height: 2,child: Container(color: Colors.black,),),
          ArticleList(),
        ],
      ),
    );
  }
}
Widget Impression(reload)
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