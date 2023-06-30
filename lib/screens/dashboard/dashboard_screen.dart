
import 'package:flutter/material.dart';

import '../../core/constants/color_constants.dart';
import '../../responsive.dart';
import 'components/analyse_sale.dart';
import 'components/bon_de_vente.dart';
import 'components/header.dart';
import 'components/article.dart';


class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        //padding: EdgeInsets.all(defaultPadding),
        child: Container(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Header(),
              SizedBox(height: defaultPadding),
              //MiniInformation(),
              SizedBox(height: defaultPadding),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        AnalyseSale(),
                        SizedBox(height: defaultPadding),
                        Article(),
                        SizedBox(height: defaultPadding),
                        //RecentDiscussions(),
                        if (Responsive.isMobile(context))
                          SizedBox(height: defaultPadding),
                        if (Responsive.isMobile(context)) Container()//UserDetailsWidget(),
                      ],
                    ),
                  ),
                  if (!Responsive.isMobile(context))
                    SizedBox(width: defaultPadding),
                  // On Mobile means if the screen is less than 850 we dont want to show it
                  if (!Responsive.isMobile(context))
                    Expanded(
                      flex: 2,
                      child: UserDetailsWidget(),
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
