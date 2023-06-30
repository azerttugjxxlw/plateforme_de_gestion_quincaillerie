import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../core/constants/color_constants.dart';

class VentesList extends StatefulWidget {
  @override
  State<VentesList> createState() => _VentesListState();
}

class _VentesListState extends State<VentesList> {
  @override
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // getReservation();
    //getClientById("6399e795a6c6e08cdc449e75");
  }


  reservationList(data,dataLength){
    var total;
      return Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
                headingRowColor: MaterialStateColor.resolveWith(
                        (states) => const Color.fromRGBO(11, 6, 65, 1)),
                dataRowHeight: 35,
                headingRowHeight: 35,
                columnSpacing: MediaQuery
                    .of(context)
                    .size
                    .width * 0.03,
                columns: [
                  DataColumn(
                    label: Text(
                      "ID",
                      style: dashdTextaStyle,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Nom",
                      style: dashdTextaStyle,
                      overflow: TextOverflow.visible,
                      softWrap: true,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Prenom",
                      style: dashdTextaStyle,
                      overflow: TextOverflow.visible,
                      softWrap: true,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Telephone",
                      style: dashdTextaStyle,
                      overflow: TextOverflow.visible,
                      softWrap: true,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Description Chb",
                      style: dashdTextaStyle,
                      overflow: TextOverflow.visible,
                      softWrap: true,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Personne",
                      style: dashdTextaStyle,
                      overflow: TextOverflow.visible,
                      softWrap: true,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Coût ",
                      style: dashdTextaStyle,
                      overflow: TextOverflow.visible,
                      softWrap: true,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Date debut",
                      style: dashdTextaStyle,
                      overflow: TextOverflow.visible,
                      softWrap: true,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Date fin",
                      style: dashdTextaStyle,
                      overflow: TextOverflow.visible,
                      softWrap: true,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "nb nuit",
                      style: dashdTextaStyle,
                      overflow: TextOverflow.visible,
                      softWrap: true,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Source",
                      style: dashdTextaStyle,
                      overflow: TextOverflow.visible,
                      softWrap: true,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Status",
                      style: dashdTextaStyle,
                      overflow: TextOverflow.visible,
                      softWrap: true,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Action",
                      style: dashdTextaStyle,
                      overflow: TextOverflow.visible,
                      softWrap: true,
                    ),
                  )
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
                          DataCell(
                              onTap: () {
                                // Your code here
                           //     generateInvoice('nom',  'prenomfac', 1234,6789, 7865, '11/21/1234', '93/43/3423', 'cafe', 12.3, 21.7, 2,20 ,1230438);
                              },
                              Text(data[i]['id_res'])
                          ),
                          DataCell(
                              onTap: () {
                                // Your code here
                             //   generateInvoice('nom',  'prenomfac', 1234,6789, 7865, '11/21/1234', '93/43/3423', 'cafe', 12.3, 21.7, 2,20 ,1230438);
                              },
                              Text(data[i]['nom'].toString())
                          ),
                          DataCell(Text(data[i]['prenom'].toString())),
                          DataCell(Text(data[i]['telephone'].toString())),
                          DataCell(Text(data[i]['descriptions'].toString())),
                          DataCell(Text("${data[i]['nb_personne'].toString()}")),
                          DataCell(Text(data[i]['cout'].toString())),
                          DataCell(Text(DateFormat.yMMMd().format(data[i]['date_debut_res']))),
                          DataCell(Text(DateFormat.yMMMd().format(data[i]['date_fin_res']))),
                          DataCell(Text("${data[i]['nb_nuit'].toString()}")),
                          DataCell(Text(data[i]['source'].toString())),
                          DataCell(data[i]['status_res']?Icon(Icons.check_circle,color: Colors.green,):Icon(Icons.cancel,color: Colors.redAccent,)),
                          DataCell(Text("Action"))
                        ]
                    )

               ]
            ),
          ),
        ],
      );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
  
  
}
