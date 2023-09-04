import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:plateforme_de_gestion_quincaillerie/model/employer.dart';
import 'package:plateforme_de_gestion_quincaillerie/screens/dashboard/components/article_model.dart';
import 'package:plateforme_de_gestion_quincaillerie/screens/stock/article_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:toggle_switch/toggle_switch.dart';

import '../../api_connection/api_connection.dart';
import '../../core/constants/color_constants.dart';
import '../../core/constants/input_widget.dart';
import 'employer/employer.dart';
import 'fourniseur/fourniseur.dart';




class Parametre extends StatefulWidget {
  const Parametre({Key? key}) : super(key: key);

  @override
  State<Parametre> createState() => _ParametreState();
}

class _ParametreState extends State<Parametre> {



  @override
  void reload(){
    setState(() {
      currentPage = Parametre();
      currentPage2 = Fourniseur();
      currentPage2 = Employer();
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
                    "Parametre",
                    style: GoogleFonts.josefinSans(
                        textStyle: TextStyle(
                          fontSize: 24,
                          color: Color.fromRGBO(11, 6, 65, 1),
                        )),
                  ),
                ),

              ],
            ),
          ),const SizedBox(height: 5,),
          Container(
              child:Row(
                children: [
                  const SizedBox(width: 10,),
                  BottonContainer( text: 'Employer', onTap: () { currentPage =  Employer(); },),
                  const SizedBox(width: 5,),
                  BottonContainer( text: 'Fourniseur', onTap: () { currentPage =  Fourniseur(); },)
                ],
              )
          ),


          //  const DateScreen(),

          SizedBox(width: double.infinity,height: 2,child: Container(color: Colors.black,),),
          Container(
            height: MediaQuery.of(context).size.height *0.7,
            child: currentPage2
          ),
        ],
      ),

    );
  }
  ///////////////////////////////////////////////////



  }

