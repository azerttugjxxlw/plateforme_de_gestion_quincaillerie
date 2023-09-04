import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

import '../../../api_connection/api_connection.dart';
import '../../../core/constants/color_constants.dart';




class EmployerList extends StatefulWidget {
  @override
  _EmployerListState createState() => _EmployerListState();
}
class _EmployerListState extends State<EmployerList>with TickerProviderStateMixin {
  late AnimationController _controller;
LinkedScrollControllerGroup controllerGroup =LinkedScrollControllerGroup();

ScrollController? headerScrollController;
ScrollController? dataScrollController;
   @override
   Future<List<dynamic>>getArticle() async{
    final response = await http.get(Uri.parse(API.listemploiyeapi));
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
                        "Post",
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
                            DataCell(Text(data[i]['id_employe'].toString())),
                            DataCell(Text(data[i]['nom_employe'].toString())),
                            DataCell(Text(data[i]['prenom_employe'].toString())),
                            DataCell(Text(data[i]['post'].toString())),

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
