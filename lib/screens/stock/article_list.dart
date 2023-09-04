import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:linked_scroll_controller/linked_scroll_controller.dart';


import '../../api_connection/api_connection.dart';
import '../../core/constants/color_constants.dart';


class ArticleList extends StatefulWidget {
  @override
  _ArticleListState createState() => _ArticleListState();
}
class _ArticleListState extends State<ArticleList>with TickerProviderStateMixin {
  late AnimationController _controller;
LinkedScrollControllerGroup controllerGroup =LinkedScrollControllerGroup();

ScrollController? headerScrollController;
ScrollController? dataScrollController;
   @override
   Future<List<dynamic>>getArticle() async{
    final response = await http.get(Uri.parse(API.listarticleapi));
    var list = json.decode(response.body);


    return list;
  }

  @override
  void initState() {
    // TODO: implement initState
    getArticle();
     headerScrollController = controllerGroup.addAndGet();
      dataScrollController= controllerGroup.addAndGet();
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
                  rows:List<DataRow>.generate(
                      dataLength,
                          (i) => DataRow( color: MaterialStateColor.resolveWith((states) {
                        //total = data[i]['nb_nuit'] * data[i]['cout']*1.0;
                        return const Color.fromRGBO(
                            241, 234, 227, 1); //make tha magic!
                      }),
                          cells: [
                            DataCell(Text(data[i]['id_article'].toString())),
                            DataCell(Text(data[i]['Nom_article'].toString())),
                            DataCell(Text(data[i]['etat_article'].toString())),
                            DataCell(Text(data[i]['prix_up'].toString())),
                            DataCell(Text(data[i]['qteStock'].toString())),
                            DataCell(Text(data[i]['description'].toString())),
                            DataCell(Text(data[i]['categorie'].toString())),

                          ]))

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
