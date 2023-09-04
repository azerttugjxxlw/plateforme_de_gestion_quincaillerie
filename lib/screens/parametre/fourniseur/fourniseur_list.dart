import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

import '../../../api_connection/api_connection.dart';
import '../../../core/constants/color_constants.dart';




class FourniseurList extends StatefulWidget {
  @override
  _FourniseurListState createState() => _FourniseurListState();
}
class _FourniseurListState extends State<FourniseurList>with TickerProviderStateMixin {
  late AnimationController _controller;
LinkedScrollControllerGroup controllerGroup =LinkedScrollControllerGroup();

ScrollController? headerScrollController;
ScrollController? dataScrollController;
   @override
   Future<List<dynamic>>getArticle() async{
    final response = await http.get(Uri.parse(API.listfourniseurapi));
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
                        "Prenom",
                        style: columnTextStyle,
                        overflow: TextOverflow.visible,
                        softWrap: true,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Tel",
                        style: columnTextStyle,
                        overflow: TextOverflow.visible,
                        softWrap: true,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Article",
                        style: columnTextStyle,
                        overflow: TextOverflow.visible,
                        softWrap: true,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "",
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
                            DataCell(Text(data[i]['id_fourniseur'].toString())),
                            DataCell(Text(data[i]['nom_fourniseur'].toString())),
                            DataCell(Text(data[i]['prenom_fourniseur'].toString())),
                            DataCell(Text(data[i]['numero_fourniseur'].toString())),
                            DataCell(Text(data[i]['article_fourni'].toString())),
                            DataCell(ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Color.fromRGBO(
                                      241, 234, 227, 1), //background color of button
                               //border width and color
                                  elevation: 0, //elevation of button
                                  shape: RoundedRectangleBorder( //to set border radius to button
                                      borderRadius: BorderRadius.circular(30)
                                  ),
                                  padding: EdgeInsets.all(20) //content padding inside button
                              ),
                              onPressed: () {
                                setState(() {


                                });
                              },
                              child: new Icon(Icons.delete,color:Colors.red,),

                            ),),
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
              return Text('vide.');
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
