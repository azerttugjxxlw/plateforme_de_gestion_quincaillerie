import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plateforme_de_gestion_quincaillerie/screens/dashboard/dashboard_screen.dart';
import 'package:plateforme_de_gestion_quincaillerie/screens/home/home_screen.dart';
import 'package:plateforme_de_gestion_quincaillerie/screens/login/login_screen.dart';
import 'package:provider/provider.dart';

import 'core/constants/color_constants.dart';
import 'core/init/provider_list.dart';

void main() {
  runApp(MyApp());
}

Widget build(BuildContext context) {
  return MultiProvider(
      providers: [...ApplicationProvider.instance.dependItems],
      child: FutureBuilder(
        builder: (context, snapshot) {
          return MyApp();
        },
      ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/fRclient":(context) => DashboardScreen()
      },
      debugShowCheckedModeBanner: false,
      title: 'Smart Dashboard - Admin Panel v0.1 ',
      theme: ThemeData(scaffoldBackgroundColor: kbagColor,dialogBackgroundColor: kbagColor,canvasColor: secondaryColor,),
      home:Login(title: '',),
    );
  }
}
/*ThemeData.dark().copyWith(
appBarTheme: AppBarTheme(backgroundColor: bgColor, elevation: 0),
scaffoldBackgroundColor: primaryColor,
primaryColor: greenColor,
dialogBackgroundColor: secondaryColor,
textTheme: GoogleFonts.openSansTextTheme(Theme.of(context).textTheme)
    .apply(bodyColor: Colors.black),
canvasColor: secondaryColor,
),*/