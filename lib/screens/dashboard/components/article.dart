
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:plateforme_de_gestion_quincaillerie/screens/dashboard/components/article_model.dart';

import '../../../core/constants/color_constants.dart';


class Article extends StatelessWidget {
  const Article({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            style: Theme.of(context).textTheme.subtitle1,
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
                rows: List.generate(
                  articleliste.length,
                  (index) => articleDataRow(articleliste[index], context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow articleDataRow(Artcle_mode articlInfo, BuildContext context) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(
                articlInfo.nom!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      DataCell(Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(


            borderRadius: BorderRadius.all(Radius.circular(5.0) //
                ),
          ),
          child: Text(articlInfo.position!))),

      DataCell(Text(articlInfo.date!)),
      DataCell(Text(articlInfo.stock!)),
      DataCell(
        Row(
          children: [
            LinearPercentIndicator(
              width: 180,

              lineHeight: 5,
              backgroundColor: Colors.grey,
              progressColor: Colors.green,
              percent: 0.8,

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
            ),

          ],
        ),
      ),
    ],
  );
}
