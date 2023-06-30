import 'package:flutter/material.dart';
import 'package:plateforme_de_gestion_quincaillerie/screens/dashboard/dashboard_screen.dart';
import 'package:plateforme_de_gestion_quincaillerie/screens/ventes/ventes.dart';


import '../../../core/constants/color_constants.dart';
/*enum Gender { client, Tableaudebore, Ventes, Facture, Stock, Parametres}

class SideMenu extends StatefulWidget {
  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {

  Gender selectedGender =Gender.Tableaudebore;

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                  title:Text( "Tableau de bord")
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
                  title:Text( "Ventes")
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
                  title:Text( "Facture")
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
                  title:Text( "Stocks")
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
                  title:Text( "Client")
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
    );
  }
}
*/
class DrawerListTile extends StatelessWidget {
   DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.cardchild,
    required this.color,
    required this.onPress,
  });
  final Color color;
  final Widget cardchild;
  final void Function() onPress;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width / 2,
        child: cardchild,
        margin:EdgeInsets.fromLTRB(0, 10, 0, 10),

        decoration: BoxDecoration(
          color: color,

        ),
      ),
    );
  }
}
