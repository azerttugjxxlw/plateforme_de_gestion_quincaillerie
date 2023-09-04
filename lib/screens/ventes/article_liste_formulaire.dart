/*
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:plateforme_de_gestion_quincaillerie/api_connection/api_connection.dart';

class Product {
  final int id_article;
  final String Nom_article;
  final double prix_up;
  double quantity;


  Product(this.id_article, this.Nom_article, this.prix_up, this.quantity);


}
class SearchBarDemo extends StatefulWidget {
  @override
  _SearchBarDemoState createState() => _SearchBarDemoState();
}

class _SearchBarDemoState extends State<SearchBarDemo> {
  List<Product> _cartItems = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  void _fetchProducts() async {
    final response = await http.get(Uri.parse(API.listarticleapi));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        _cartItems = data.map((item) => Product(item['id_article'], item['Nom_article'].toString() , item['prix_up'].toDouble(), 0.0)).toList();
      });
    }
  }

  void _updateQuantity(int index, double newQuantity) {
    setState(() {
      _cartItems[index].quantity = newQuantity;
    });
  }

  double _calculateTotal() {
    double total = 0;
    for (var item in _cartItems) {
      total += item.prix_up * item.quantity;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
    Expanded(

    child: ListView.builder(
    itemCount: _cartItems.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_cartItems[index].Nom_article),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Price: \$${_cartItems[index].prix_up.toStringAsFixed(2)}'),
              TextField(
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                onChanged: (newValue) {
                  _updateQuantity(index, double.parse(newValue));

                },
              ),
            ],
          ),
        );
      },
    ),
    ),

            Container(
                width: MediaQuery.of(context).size.width * 0.21,
                height:30,
               child: Text('\$${_calculateTotal().toStringAsFixed(2)}')
            )

      ],
    );
  }
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////
class Product {
  final String Nom_article;
  final double prix_up;
  int quantity;

  Product(this.Nom_article, this.prix_up, this.quantity);
}

class SearchBarDemo extends StatefulWidget {
  const SearchBarDemo({super.key});

  @override
  State<SearchBarDemo> createState() => _SearchBarDemoState();
}

class _SearchBarDemoState extends State<SearchBarDemo> {
  List<String> _items = [];
  List<String> filteritems = [];
  List<bool> _checkedItems = [];
  List<TextEditingController> _brutos = [];

  @override
  void initState() {
    super.initState();
    _fetchData();

  }

  _fetchData() async {
    final response = await http.get(Uri.parse(API.listarticleapi));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        _items = data.map((item) => item['Nom_article'].toString()).toList();
        _checkedItems = List.generate(_items.length, (index) => false);

          _brutos.add(new TextEditingController());

      });
    }
  }

  late final TextEditingController controller = TextEditingController()
    ..addListener(() {
      /// filter logic will be here
      final text = controller.text.trim();
      filteritems =
          _items.where(
                  (element) => element.toLowerCase().startsWith(text.toLowerCase()))
              .toList();

      setState(() {});
    });

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CupertinoTextField(
            controller: controller,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteritems.length,
            itemBuilder: (context, index) {
              return ListTile(
                title:  Text(filteritems[index]),/* Row(
                  children: [

                    Text(filteritems[index]),
                    Expanded(
                      child: TextFormField(
                        decoration: new InputDecoration(
                          labelText: "Bruto",
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        style: new TextStyle(
                          fontFamily: "Poppins",
                        ),

                        controller: _brutos[index],
                      ),
                    ),
                  ],
                ),*/
                leading: Checkbox(
                  value: _checkedItems[index],
                  onChanged: (bool? value) {

                    setState(() {
                      _checkedItems[index] = value!;

                    });
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

}


*/
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plateforme_de_gestion_quincaillerie/screens/ventes/vente.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import 'package:toggle_switch/toggle_switch.dart';

import '../../api_connection/api_connection.dart';
import '../../core/constants/color_constants.dart';
import '../facture/facture_generate.dart';
import '../facture/facture_generate/save_file_mobile.dart';


//client
TextEditingController nom_client = TextEditingController();
TextEditingController prenom_client = TextEditingController();
TextEditingController num = TextEditingController();

int? bon=1;
DateTime now = DateTime.now();
var formattedDate = DateFormat('yyyy-MM-dd').format(now);
double tva= 0.18;
double prix=0.0;
double prixt = 0.0;
var date_facture;
int? idetr_employe= 1 ;
//int? idetr_employe;
TextEditingController remise_facture = TextEditingController();

//panier
double qt_article = 0;
int CE_article=0;
double upprix=0.0;
String nomarticle='';

class formulaire extends StatefulWidget {
  const formulaire({Key? key}) : super(key: key);

  @override
  State<formulaire> createState() => _formulaireState();
}

class _formulaireState extends State<formulaire> {
   final clientData={};
  final factureData={};

  bool _showForm = false;


  void _toggleFormVisibility() {
    setState(() {
      _showForm = !_showForm;
    });
  }
  late bool error, sending, success;
  late String msg;
   var productList = [];

  List<Product> _cartItems = [];
/*  void fetchData() async {
    final response = await http.get(Uri.parse(API.idfacapi));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        maxClientId = data['max_id_client'];
      });
    } else {
      throw Exception('Échec de la requête');
    }
  }*/

  void _fetchProducts() async {
    final response = await http.get(Uri.parse(API.listarticleapi));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        _cartItems = data.map((item) => Product(item['id_article'], item['Nom_article'].toString() , item['prix_up'].toDouble(), 0.0)).toList();
      });
    }
  }

  void _updateQuantity(int index, double newQuantity) {
    setState(() {
      _cartItems[index].quantity = newQuantity;
    });
  }
/*double _valeurqte(){
    double qt =0;
  for (var item in _cartItems) {
    qt_article=  item.quantity;
    qt =qt_article;
    print("qt= $qt");

  }
    return qt;

}*/
  double _calculateTotal() {

    double total = 0;
    for (var item in _cartItems) {
      total += item.prix_up * item.quantity ;
    }
    return total;
  }

  @override
  void initState() {
    _fetchProducts();
    super.initState();

  }
  @override
  void reload(){
    setState(() {
      currentPage = formulaire();
    });
  }
  Future<void> sendData() async {
    final url = Uri.parse('http://127.0.0.1/api_pdgquincaillerie_store/teste3.php');
    for (var item in _cartItems) {
      int index = _cartItems.indexOf(item);


      if(item.quantity > 0){
        //  productList.add(item);
        nomarticle= item.Nom_article;
        qt_article= item.quantity;
        CE_article = item.id_article;
        upprix =item.prix_up;
        productList.add({'nom': CE_article, 'quantite': qt_article, 'nomarticle': nomarticle,'upprix':upprix});
      } }
    final response = await http.post(
      url,
      body: json.encode({
        'nom_client':nom_client.text.toString(),
        'prenom_client':prenom_client.text.toString(),
        'num':num.text.toString(),
        //facture

        'date_facture':date_facture.toString(),
        'prix':prix.toString(),
        'tva':tva.toString(),
        'remise_facture':remise_facture.text.toString(),
        'bon':bon.toString(),
        'idetr_employe':idetr_employe.toString(),

        'panier':productList}),
      headers: {'Content-Type': 'application/json'},
    );
    generateInvoice(productList);
    print("php debut");
    print(productList);
    print("php fin");

    if (response.statusCode == 200) {
      print('Données envoyées avec succès');

    } else {
      print('Erreur lors de l\'envoi des données');

    }
  }

  void addData()  {
   /*
    for (var item in _cartItems) {
      int index = _cartItems.indexOf(item);


      if(item.quantity > 0){
      //  productList.add(item);


         qt_article= item.quantity;
         CE_article = item.id_article;
        productList.add({'nom': CE_article, 'quantite': qt_article});
      } }*/
         var resp =  http.post(Uri.parse(API.addvent),

             body: {
               //client
               "nom_client":nom_client.text.toString(),
               "prenom_client":prenom_client.text.toString(),
               "num":num.text.toString(),
               //facture
               "date_facture":date_facture.toString(),
               "prix":prix.toString(),
               "tva":tva.toString(),
               "remise_facture":remise_facture.text.toString(),
               "bon":bon.toString(),
               "idetr_employe": idetr_employe.toString(),
               //panier
               "panier": productList.toString(),
              // "CE_article":CE_article.toString(),
              // "qt_article":qt_article.toString(),
              // 'productList': _cartItems.toString(),


             }
         );
    print("php debut");
print(productList);
    print("php fin");
  //  print("liste3"); print(productList3); print("liste3");
  }
  //void addProduct() {}

  Widget build(BuildContext context) {
    prix=_calculateTotal();
    prixt=( prix+(prix * 0.18));
   // print("qt2== ${_valeurqte()}");
    idetr_employe=  int.parse(uid.toString());
    date_facture=formattedDate;




    return Container(
        alignment: Alignment.center,
        width: 800,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.550,
          height: MediaQuery.of(context).size.height * 0.65,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child:Row(
            children:<Widget> [
              Container(
                  child: Column(
                    children:<Widget> [

                      Container(
                        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        width: MediaQuery.of(context).size.width * 0.23,
                        height: 50,
                        child: TextFormField(
                          controller: nom_client,
                          validator: (value){
                            if(value!.isEmpty){
                              return "Champ vide";
                            }
                          },
                          keyboardType: TextInputType.name,
                          maxLines: 1,
                          minLines: 1,
                          decoration: new InputDecoration(
                            hintText: "Nom du client : ",
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        width: MediaQuery.of(context).size.width * 0.23,
                        height: 50,
                        child: TextFormField(
                          controller: prenom_client,
                          validator: (value){
                            if(value!.isEmpty){
                              return "Champ vide";
                            }
                          },
                          keyboardType: TextInputType.name,
                          maxLines: 1,
                          minLines: 1,
                          decoration: new InputDecoration(
                            hintText: "prenom du client : ",
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        width: MediaQuery.of(context).size.width * 0.23,
                        height: 50,
                        child: TextFormField(
                          controller: num,
                          validator: (value){
                            if(value!.isEmpty){
                              return "Champ vide";
                            }
                          },
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          minLines: 1,
                          decoration: new InputDecoration(
                            hintText: "Tel du client : ",
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        width: MediaQuery.of(context).size.width * 0.23,
                        height: 50,
                        child: TextFormField(
                          controller: remise_facture,
                          validator: (value){
                            if(value!.isEmpty){
                              return "Champ vide";
                            }
                          },
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          minLines: 1,
                          decoration: new InputDecoration(
                            hintText: "Remise : ",
                          ),
                        ),
                      ),
                      ToggleSwitch(
                        minWidth: 50.0,
                        cornerRadius: 5.0,
                        activeBgColors: [
                          [Colors.red[800]!],
                          [Colors.green[800]!]

                        ],
                        activeFgColor: Colors.white,
                        inactiveBgColor: Colors.grey,
                        inactiveFgColor: Colors.white,
                        initialLabelIndex: 1,
                        totalSwitches: 2,
                        labels: ['Bon', 'Fac'],
                        radiusStyle: true,
                        onToggle: (index) {
                          print('switched to: $index');
                          bon = index;
                          print('bon ==  $bon');
                        },
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        width: MediaQuery.of(context).size.width * 0.23,
                        height: 50,
                        child: Text("TVA :18%"),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        width: MediaQuery.of(context).size.width * 0.23,
                        height: 50,
                        child: Text("Prix Hors Taxe :\$${prix.toStringAsFixed(2)}"),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        width: MediaQuery.of(context).size.width * 0.23,
                        height: 50,

                        child: Text( 'Total: \$${prixt.toStringAsFixed(2)}'),
                      ),
                    ],
                  )
              ),
              Container(
                  child: Column(
                    children:<Widget> [
                      Container(
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                          width: MediaQuery.of(context).size.width * 0.23,
                          height: 20,
                          child:Text("")

                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        width: MediaQuery.of(context).size.width * 0.21,
                        height:MediaQuery.of(context).size.width * 0.23,
                        decoration:  BoxDecoration(

                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            )
                        ),
                        child:Container(

                          child: ListView.builder(
                            itemCount: _cartItems.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(_cartItems[index].Nom_article),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Price: \$${_cartItems[index].prix_up.toStringAsFixed(2)}'),
                                    TextField(
                                      decoration: InputDecoration(labelText: 'Quantity'),
                                      keyboardType: TextInputType.number,
                                      onChanged: (newValue) {
                                        _updateQuantity(index, double.parse(newValue));

                                      },
                                    ),
                                  ],
                                ),

                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 35,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: kTiroirColor, //background color of button
                                side: BorderSide(width:3, color:Colors.brown), //border width and color
                                elevation: 3, //elevation of button
                                shape: RoundedRectangleBorder( //to set border radius to button
                                    borderRadius: BorderRadius.circular(30)
                                ),
                                padding: EdgeInsets.all(20) //content padding inside button
                            ),
                            onPressed: () {
                              setState(() {
                                //addProduct();

                                sending = true;
                              });
                            },
                            child: new Text(
                              "imprimer Panier",
                              style: TextStyle(color: Colors.white),
                            ),

                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: kTiroirColor, //background color of button
                                side: BorderSide(width:3, color:Colors.brown), //border width and color
                                elevation: 3, //elevation of button
                                shape: RoundedRectangleBorder( //to set border radius to button
                                    borderRadius: BorderRadius.circular(30)
                                ),
                                padding: EdgeInsets.all(20) //content padding inside button
                            ),
                            onPressed: () {
                              setState(() {

                                sending = true;
                              });
                            },
                            child: new Text(
                              "Valider Panier",
                              style: TextStyle(color: Colors.white),
                            ),

                          ),
                          ElevatedButton(
    style: ElevatedButton.styleFrom(
    primary: kTiroirColor, //background color of button
    side: BorderSide(width:3, color:Colors.brown), //border width and color
    elevation: 3, //elevation of button
    shape: RoundedRectangleBorder( //to set border radius to button
    borderRadius: BorderRadius.circular(30)
    ),
    padding: EdgeInsets.all(20) //content padding inside button
    ),

    onPressed: () {
                              setState(() {
                                //addProduct();
                                sending = true;

                                sendData();

                                //showUpperContainer = false;
                                nom_client.clear();
                                prenom_client.clear();
                                num.clear();
                                remise_facture.clear();
                                bon=1;
                                prix=0;
                                date_facture=formattedDate;
                              });
                            },
                            child: new Text(
                              "Enregistre",
                              style: TextStyle(color: Colors.white),
                            ),

                          ),
                          const SizedBox(height: 15,),
                        ],
                      )
                    ],
                  )
              ),




            ],

          ),
        ),
      );
  }
////facture

  generateInvoice( var productList) async {
    //Create a PDF document.
    final PdfDocument document = PdfDocument();
    //Add page to the PDF
    final PdfPage page = document.pages.add();
    //Get page client size
    final Size pageSize = page.getClientSize();
    //Draw rectangle
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
        pen: PdfPen(PdfColor(142, 170, 219)));
    //Generate PDF grid.
    final PdfGrid grid = getGrid(productList);
    //Draw the header section by creating text element
    final PdfLayoutResult result = drawHeader(page, pageSize, grid);
    //Draw grid
    drawGrid(page, grid, result);
    //Add invoice footer
    drawFooter(page, pageSize);
    //Save the PDF document
    final List<int> bytes = document.saveSync();
    //Dispose the document.
    document.dispose();
    //Save and launch the file.
    await saveAndLaunchFile(bytes, 'Invoice.pdf');
  }

//Draws the invoice header
  PdfLayoutResult drawHeader(PdfPage page, Size pageSize, PdfGrid grid) {
    //Draw rectangle
    page.graphics.drawRectangle(
        brush: PdfSolidBrush(PdfColor(91, 126, 215)),
        bounds: Rect.fromLTWH(0, 0, pageSize.width - 115, 90));
    //Draw string
    page.graphics.drawString(
        'FACTURE', PdfStandardFont(PdfFontFamily.helvetica, 30),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(25, 0, pageSize.width - 115, 90),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));

    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 90),
        brush: PdfSolidBrush(PdfColor(65, 104, 205)));

    page.graphics.drawString(r'F' + getTotalAmount(grid).toString(),
        PdfStandardFont(PdfFontFamily.helvetica, 18),
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 100),
        brush: PdfBrushes.white,
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.middle));

    final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 9);
    //Draw string
    page.graphics.drawString('Total', contentFont,
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.bottom));
    //Create data foramt and convert it to text.
    final DateFormat format = DateFormat.yMMMMd('en_US');
    final String invoiceNumber =
        'Facture N°: 2058557939\r\n\r\nDate: ${format.format(DateTime.now())}';
    final Size contentSize = contentFont.measureString(invoiceNumber);
    // ignore: leading_newlines_in_multiline_strings
    const String address = '''Nom du client: \r\n\r\nAbraham Swearegin, 
        \r\n\r\nTOGO, Lome,''';

    PdfTextElement(text: invoiceNumber, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(pageSize.width - (contentSize.width + 30), 120,
            contentSize.width + 30, pageSize.height - 120));

    return PdfTextElement(text: address, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(30, 120,
            pageSize.width - (contentSize.width + 30), pageSize.height - 120))!;
  }

//Draws the grid
  void drawGrid(PdfPage page, PdfGrid grid, PdfLayoutResult result) {
    Rect? totalPriceCellBounds;
    Rect? quantityCellBounds;
    //Invoke the beginCellLayout event.
    grid.beginCellLayout = (Object sender, PdfGridBeginCellLayoutArgs args) {
      final PdfGrid grid = sender as PdfGrid;
      if (args.cellIndex == grid.columns.count - 1) {
        totalPriceCellBounds = args.bounds;
      } else if (args.cellIndex == grid.columns.count - 2) {
        quantityCellBounds = args.bounds;
      }
    };
    //Draw the PDF grid and get the result.
    result = grid.draw(
        page: page, bounds: Rect.fromLTWH(0, result.bounds.bottom + 40, 0, 0))!;

    //Draw grand total.
    page.graphics.drawString('Total',
        PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
        bounds: Rect.fromLTWH(
            quantityCellBounds!.left,
            result.bounds.bottom + 10,
            quantityCellBounds!.width,
            quantityCellBounds!.height));
    page.graphics.drawString(getTotalAmount(grid).toString(),
        PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
        bounds: Rect.fromLTWH(
            totalPriceCellBounds!.left,
            result.bounds.bottom + 10,
            totalPriceCellBounds!.width,
            totalPriceCellBounds!.height));
  }

//Draw the invoice footer data.
  void drawFooter(PdfPage page, Size pageSize) {
    final PdfPen linePen =
    PdfPen(PdfColor(142, 170, 219), dashStyle: PdfDashStyle.custom);
    linePen.dashPattern = <double>[3, 3];
    //Draw line
    page.graphics.drawLine(linePen, Offset(0, pageSize.height - 100),
        Offset(pageSize.width, pageSize.height - 100));

    const String footerContent =
    // ignore: leading_newlines_in_multiline_strings
    '''Lome.\r\n\r\nSuite 2501, agoes,
         TX 78721\r\n\r\nDes questions? pdgq@pdgq-works.com''';

    //Added 30 as a margin for the layout
    page.graphics.drawString(
        footerContent, PdfStandardFont(PdfFontFamily.helvetica, 9),
        format: PdfStringFormat(alignment: PdfTextAlignment.right),
        bounds: Rect.fromLTWH(pageSize.width - 30, pageSize.height - 70, 0, 0));
  }

//Create PDF grid and return
  PdfGrid getGrid(var productList) {
    //Create a PDF grid
    final PdfGrid grid = PdfGrid();
    //Secify the columns count to the grid.
    grid.columns.add(count: 5);
    //Create the header row of the grid.
    final PdfGridRow headerRow = grid.headers.add(1)[0];
    //Set style
    headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 114, 196));
    headerRow.style.textBrush = PdfBrushes.white;
    headerRow.cells[0].value = 'N°';
    headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.center;
    headerRow.cells[1].value = 'Designation';
    headerRow.cells[2].value = 'PU';
    headerRow.cells[3].value = 'Qt';
    headerRow.cells[4].value = 'Total';
    //Add rows
    addProducts( productList, grid);

    //Apply the table built-in style
    grid.applyBuiltInStyle(PdfGridBuiltInStyle.listTable4Accent5);
    //Set gird columns width
    grid.columns[1].width = 200;
    for (int i = 0; i < headerRow.cells.count; i++) {
      headerRow.cells[i].style.cellPadding =
          PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
    }
    for (int i = 0; i < grid.rows.count; i++) {
      final PdfGridRow row = grid.rows[i];
      for (int j = 0; j < row.cells.count; j++) {
        final PdfGridCell cell = row.cells[j];
        if (j == 0) {
          cell.stringFormat.alignment = PdfTextAlignment.center;
        }
        cell.style.cellPadding =
            PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
      }
    }
    return grid;
  }

//Create and row for the grid.
  void addProducts(var productList, PdfGrid grid) {
    for (var item in productList) {
      final PdfGridRow row = grid.rows.add();
      row.cells[0].value = productList.indexOf(item);
      row.cells[1].value = item['nomarticle'].toString();
      row.cells[2].value = item['upprix'].toString();
      row.cells[3].value = item['quantite'].toString();
      row.cells[4].value = (item['upprix'] * item['quantite']).toString();
    }
  }

//Get the total amount.
  double getTotalAmount(PdfGrid grid) {
    double total = 0;
    for (int i = 0; i < grid.rows.count; i++) {
      final String value =
      grid.rows[i].cells[grid.columns.count - 1].value as String;
      total += double.parse(value);
    }
    return total;
  }

////facture

}
class Product {
  final int id_article;
  final String Nom_article;
  final double prix_up;
  double quantity;


  Product(this.id_article, this.Nom_article, this.prix_up, this.quantity);


}