import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/color_constants.dart';
import 'client_list.dart';

class Client extends StatefulWidget {
  const Client({Key? key}) : super(key: key);

  @override
  State<Client> createState() => _ClientState();
}

class _ClientState extends State<Client> {
  @override
  void reload(){
    setState(() {
        currentPage = Client();
    });
  }
  Widget build(BuildContext context) {

    return Scaffold(
      body:Column(
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
              "Client",
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

            ],
          ),
        ],
      ),
    ),const SizedBox(height: 20,),
    Container(
    child: Impression(reload),
    ),


    //  const DateScreen(),3
    SizedBox(width: double.infinity,height: 2,child: Container(color: Colors.black,),),
    Container(
      height: MediaQuery.of(context).size.height *0.77,
    child:  ClientList(),
    ),
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

    ],
  );
}