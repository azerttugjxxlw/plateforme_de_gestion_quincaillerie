
import 'package:flutter/material.dart';

import '../../core/constants/color_constants.dart';
import '../../responsive.dart';
import '../dashboard/dashboard_screen.dart';
import '../ventes/ventes.dart';
import 'components/side_menu.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreen createState() => _HomeScreen();
}
enum Gender { client, Tableaudebore, Ventes, Facture, Stock, Parametres}
class _HomeScreen extends State<HomeScreen> {



  Gender selectedGender =Gender.Tableaudebore;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: context.read<MenuController>().scaffoldKey,
      //drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: Drawer(
                  child: SingleChildScrollView(
                    // it enables scrolling
                    child: Column(
                      children: [
                        DrawerHeader(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: defaultPadding * 3,
                                ),
                                Image.asset(
                                  "assets/images/logo.png",


                                  scale: 7,
                                ),
                                SizedBox(
                                  height: defaultPadding,
                                ),
                                Text("Quincaillerie PDGQ",style: dashdTextStyle)
                              ],
                            )),
                        DrawerListTile(
                          cardchild: ListTile(
                              leading:ImageIcon(AssetImage("assets/icon/tableaudebore.png") ,),
                              title:Text( "Tableau de bord",style:selectedGender== Gender.Tableaudebore? drawaTextStyle
                                  : dashdTextStyle,)
                          ),

                          color: selectedGender == Gender.Tableaudebore
                              ? kdashdcolor
                              : kTranspColor,
                          onPress: () {
                            setState(() {
                              selectedGender = Gender.Tableaudebore;
                              currentPage = DashboardScreen();
                              print("D");
                            });
                          },
                        ),
                        DrawerListTile(
                          cardchild: ListTile(
                              leading:ImageIcon(AssetImage("assets/icon/ventes.png") ,),
                              title:Text( "Ventes",style:selectedGender== Gender.Ventes? drawaTextStyle
                                  : dashdTextStyle,)
                          ),
                          color: selectedGender == Gender.Ventes
                              ? kdashdcolor
                              : kTranspColor,
                          onPress: () {
                            setState(() {
                              selectedGender = Gender.Ventes;

                              currentPage = Ventes();

                              print("vente");

                            });
                          },
                        ),
                        DrawerListTile(
                          cardchild: ListTile(
                              leading:ImageIcon(AssetImage("assets/icon/facture.png") ,),
                              title:Text( "Facture",style:selectedGender== Gender.Facture? drawaTextStyle
                                  : dashdTextStyle,)
                          ),
                          color: selectedGender == Gender.Facture
                              ? kdashdcolor
                              : kTranspColor,
                          onPress: () {
                            setState(() {
                              selectedGender = Gender.Facture;
                              // currentPage = Facture();
                              print("factur");

                            });
                          },
                        ),
                        DrawerListTile(
                          cardchild: ListTile(
                              leading:ImageIcon(AssetImage("assets/icon/stock.png") ,),
                              title:Text( "Stocks",style:selectedGender== Gender.Stock? drawaTextStyle
                                  : dashdTextStyle,)
                          ),

                          color: selectedGender == Gender.Stock
                              ? kdashdcolor
                              : kTranspColor,
                          onPress: () {
                            setState(() {
                              selectedGender = Gender.Stock;
                              // currentPage = Stock();
                              print("stock");

                            });
                          },
                        ),
                        DrawerListTile(
                          cardchild: ListTile(
                              leading:ImageIcon(AssetImage("assets/icon/client.png") ,),
                              title:Text( "Client",style:selectedGender== Gender.client? drawaTextStyle
                                  : dashdTextStyle,)
                          ),
                          color: selectedGender == Gender.client
                              ? kdashdcolor
                              : kTranspColor,
                          onPress: () {
                            setState(() {
                              selectedGender = Gender.client;
                              // currentPage = Client();
                              print("client");

                            });
                          },
                        ),

                        DrawerListTile(
                          color: selectedGender == Gender.Parametres
                              ? kdashdcolor
                              : kTranspColor,
                          onPress: () {
                            setState(() {
                              selectedGender = Gender.Parametres;
                              // currentPage = Parametre();
                              print("parametre");

                            });},
                          cardchild: ListTile(
                              leading:ImageIcon(AssetImage("assets/icon/parametre.png") ,),
                              title:Text( "Paramètres")
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: currentPage,

              ),
          ],
        ),
      ),
    );
  }

}