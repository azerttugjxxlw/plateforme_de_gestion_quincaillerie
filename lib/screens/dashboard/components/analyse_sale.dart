
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


import '../../../core/constants/color_constants.dart';

class AnalyseSale extends StatelessWidget {
  AnalyseSale({super.key});


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
            "ventes",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SingleChildScrollView(
            //scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: double.infinity,

              child:SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  // Chart title
                  title: ChartTitle(text: 'Analyse semestrielle des ventes',textStyle: Theme.of(context).textTheme.subtitle1,),
                  // Enable legend
                  legend: Legend(isVisible: true),
                  // Enable tooltip
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <ChartSeries<_SalesData, String>>[
                    LineSeries<_SalesData, String>(
                        dataSource: data,
                        xValueMapper: (_SalesData sales, _) => sales.year,
                        yValueMapper: (_SalesData sales, _) => sales.sales,
                        name: 'ventes',
                        // Enable data label
                        dataLabelSettings: DataLabelSettings(isVisible: true))
                  ]),
            ),
          ),
        ],
      ),
    );
  }
  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 2),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40)
  ];
}


class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
