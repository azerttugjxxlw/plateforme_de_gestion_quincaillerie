
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:plateforme_de_gestion_quincaillerie/screens/dashboard/components/article_model.dart';
import 'package:http/http.dart' as http;
import '../../../api_connection/api_connection.dart';
import '../../../core/constants/color_constants.dart';


class Article extends StatelessWidget {
   Article({
    Key? key,
  }) : super(key: key);
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

  }

  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint){
      return Center(
          child: loadReservations());
    });
  }
  @override
  reservationList(data,dataLength){
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: kdashdcolor,
          borderRadius: const BorderRadius.all(Radius.circular(10),),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Article",
              //   style: Theme.of(context).textTheme.subtitle1,
            ),
            SingleChildScrollView(
              //scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: double.infinity,

                child: DataTable(
                  horizontalMargin: 0,
                  columnSpacing: defaultPadding,
                  columns: [
                    DataColumn(
                      label: Text("Nom article"),
                    ),
                    DataColumn(
                      label: Text("position"),
                    ),

                    DataColumn(
                      label: Text("Date Registre"),
                    ),
                    DataColumn(
                      label: Text("stock"),
                    ),
                    DataColumn(
                      label: Text(""),
                    ),
                  ],
                  rows: List<DataRow>.generate(
                    dataLength,
                        (i) => articleDataRow(data[i]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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



DataRow articleDataRow(var articlInfo) {

var sto;
sto =double.parse(articlInfo['qteStock'].toString()) ;
double stof=sto*0.00001;
  return new DataRow(
              cells: [
               // DataCell(Text(articlInfo['id_article'].toString())),
                DataCell(Text(articlInfo['Nom_article'].toString())),
                DataCell(Text(articlInfo['etat_article'].toString())),
                DataCell(Text(articlInfo['prix_up'].toString())),
                DataCell(Text(articlInfo['qteStock'].toString())),
                DataCell(
                  Row(
                    children: [
                      LinearPercentIndicator(
                        width: 180,

                        lineHeight: 3,
                        backgroundColor: Colors.red,
                        progressColor: Colors.green,
                        percent:stof ,

                        alignment: MainAxisAlignment.center,
                        animation: true,
                        animationDuration: 1000,
                        onAnimationEnd: () {
                          print("Linear Animation finished");
                        },
                        barRadius: Radius.circular(20),
                      ),
                      SizedBox(
                        width: 6,
                      ),],

                  ),),
               // DataCell(Text(articlInfo['categorie'].toString())),

              ]

  );


}
}
