import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


import '../../api_connection/api_connection.dart';
import '../../core/constants/color_constants.dart';


class ventefacture_list extends StatefulWidget {
  @override
  _ventefacture_listState createState() => _ventefacture_listState();
}
class _ventefacture_listState extends State<ventefacture_list>with TickerProviderStateMixin {
  late AnimationController _controller;

   @override
   Future<List<dynamic>>getArticle() async{
    final response = await http.get(Uri.parse(API.listventefactureapi));
    var list = json.decode(response.body);


    return list;
  }

  @override
  void initState() {
    // TODO: implement initState
    getArticle();
  }

  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint){
      return Center(
          child: loadReservations());
    });
  }

   reservationList(data,dataLength){
    return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child:DataTable(
                  headingRowColor: MaterialStateColor.resolveWith(
                          (states) => const Color.fromRGBO(11, 6, 65, 1)),
                  dataRowHeight: 35,
                  headingRowHeight: 35,
                  columnSpacing: MediaQuery
                      .of(context)
                      .size
                      .width * 0.091,
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
                        "Date",
                        style: columnTextStyle,
                        overflow: TextOverflow.visible,
                        softWrap: true,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Prix T",
                        style: columnTextStyle,
                        overflow: TextOverflow.visible,
                        softWrap: true,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "TVA",
                        style: columnTextStyle,
                        overflow: TextOverflow.visible,
                        softWrap: true,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Remise",
                        style: columnTextStyle,
                        overflow: TextOverflow.visible,
                        softWrap: true,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Bon ",
                        style: columnTextStyle,
                        overflow: TextOverflow.visible,
                        softWrap: true,
                      ),
                    ),

                  ],
                  rows:[
                    for(int i = 0; i < dataLength; i++)

                       DataRow(


                          color: MaterialStateColor.resolveWith((states) {
                            //total = data[i]['nb_nuit'] * data[i]['cout']*1.0;
                            return const Color.fromRGBO(
                                241, 234, 227, 1); //make tha magic!
                          }),
                          cells: [
                            DataCell(Text(data[i]['id_facture'].toString())),
                            DataCell(Text(data[i]['nom_client'].toString())),
                            DataCell(Text(data[i]['date_facture'].toString())),
                            DataCell(Text(data[i]['prix'].toString())),
                            DataCell(Text(data[i]['tva'].toString())),
                            DataCell(Text(data[i]['remise_facture'].toString())),
                            DataCell(Text(data[i]['bon'].toString())),

                          ]
                      ),
                  ]
              ), )
    );
  }
  Stream<int> _timerStream = Stream.periodic(Duration(seconds: 3), (i) => i);
  StreamBuilder<int> loadReservations() {
    return StreamBuilder<int>(
      stream: _timerStream,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        return FutureBuilder<List<dynamic>>(
          future: getArticle(),
          builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData) {
              int dataLength = snapshot.data!.length;
              return reservationList(snapshot.data, dataLength);
            } else if (snapshot.hasError) {
              return Text('Une erreur s\'est produite.');
            } else {
              return LinearProgressIndicator();
            }
          },
        );
      },
    );
  }

  //////////////////////////////////////////////


}
