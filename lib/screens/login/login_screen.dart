
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:plateforme_de_gestion_quincaillerie/api_connection/api_connection.dart';
import 'package:plateforme_de_gestion_quincaillerie/core/constants/color_constants.dart';

import '../../core/constants/color_constants.dart';
import '../../core/constants/color_constants.dart';
import '../../model/employer.dart';
import '../../responsive.dart';
import '../home/home_screen.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  Login({required this.title});
  final String title;
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  var tweenLeft = Tween<Offset>(begin: Offset(2, 0), end: Offset(0, 0))
      .chain(CurveTween(curve: Curves.ease));
  var tweenRight = Tween<Offset>(begin: Offset(0, 0), end: Offset(2, 0))
      .chain(CurveTween(curve: Curves.ease));
  late String errormsg;
  late bool error, showprogress;
  late String username, password;

  var _username = TextEditingController();
  var _password = TextEditingController();

  startLogin() async {
    //String API.singnUp = "http://192.168.1.86/api_pdgquincaillerie_store/user/login.php"; //api url
    //dont use http://localhost , because emulator don't get that address
    //insted use your local IP address or use live URL
    //hit "ipconfig" in windows or "ip a" in linux to get you local IP
    print(username);
    print(password);

    var response = await http.post(Uri.parse(API.singnUp), body: {
      'username': username, //get the username text
      'password': password  //get password text
    });

    if(response.statusCode == 200){
      var jsondata = json.decode(response.body);
      if(jsondata["error"]){
        setState(() {
          showprogress = false; //don't show progress indicator
          error = true;
          errormsg = jsondata["message"];
        });
      }else{
        if(jsondata["success"]){
          setState(() {

              Navigator.push(

                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );

            error = false;
            showprogress = false;
          });
          //save the data returned from server
          //and navigate to home page
          String uid = jsondata["uid"];
          String fullname = jsondata["fullname"];
          String address = jsondata["address"];
          print(fullname);
          //user shared preference to save data
        }else{
          showprogress = false; //don't show progress indicator
          error = true;
          errormsg = "Something went wrong.";
        }
      }
    }else{
      setState(() {
        showprogress = false; //don't show progress indicator
        error = true;
        errormsg = "Error during connecting to server.";
      });
    }
  }

  @override
  void initState() {
    username = "";
    password = "";
    errormsg = "";
    error = false;
    showprogress = false;

    //_username.text = "defaulttext";
    //_password.text = "defaultpassword";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent
      //color set to transperent or set your own color
    ));

    return  Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          Row(
            children: <Widget>[
              if (Responsive.isDesktop(context))
                Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width / 2,
                    color: Colors.white,
                    child: Image.asset('assets/images/mockup-2.png')
                ),
              Container(
                height: MediaQuery.of(context).size.height,
                width: Responsive.isDesktop(context)?  MediaQuery.of(context).size.width / 2:MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Center(
                  child: Card(
                    //elevation: 5,
                    color: Colors.white,
                    child: Container(
                      padding: EdgeInsets.all(42),
                      width: Responsive.isDesktop(context)? MediaQuery.of(context).size.width / 3.6:MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 1.2,
                      child: Column(
                        children: <Widget>[
                          Image.asset("assets/images/logo.png", scale: 3),
                          SizedBox(height: 10.0),
                          Flexible(
                            child: Stack(
                                fit: StackFit.loose,
                                clipBehavior: Clip.none,
                                children: [
                                  _formLogin(),
                                ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
/////////////////////////////////////////////////////////////////////////////

  Widget _formLogin() {

    return Column(children:<Widget>[
            Container(
              //show error message here
              margin: EdgeInsets.only(top:20),
              padding: EdgeInsets.all(10),
              child:error? errmsg(errormsg):Container(),
              //if error == true then show error message
              //else set empty container as child
            ),

            Container(
              padding: EdgeInsets.fromLTRB(10,0,10,0),
              margin: EdgeInsets.only(top:10),
              child: TextField(
                controller: _username, //set username controller
                style:TextStyle(color:Colors.orange[100], fontSize:20),
                decoration: myInputDecoration(
                  label: "Nom",
                  icon: Icons.person,
                ),
                onChanged: (value){
                  //set username  text on change
                  username = value;
                },

              ),
            ),

            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: _password, //set password controller
                style: TextStyle(color:Colors.white, fontSize:20),
                obscureText: true,
                decoration: myInputDecoration(
                  label: "Password",
                  icon: Icons.lock,
                ),
                onChanged: (value){
                  // change password text
                  password = value;
                },

              ),
            ),

            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(top:20),
              child: SizedBox(
                height: 60, width: double.infinity,
                child:ElevatedButton(
                  onPressed: (){
                    setState(() {
                      //show progress indicator on click
                      showprogress = true;
                    });
                    startLogin();

                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: showprogress?
                  SizedBox(
                    height:10, width:30,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                    ),
                  ):Text("LOGIN NOW", style: TextStyle(fontSize: 20),),
                ),
              ),
            ),


          ]);
  }
  ///////////////////////////////////////////////////////////////////////////////
  InputDecoration myInputDecoration({required String label, required IconData icon}){
    return InputDecoration(
      hintText: label, //show label as placeholder
      hintStyle: TextStyle(color:Colors.white, fontSize:20), //hint text style
      prefixIcon: Padding(
          padding: EdgeInsets.only(left:20, right:10),
          child:Icon(icon, color: Colors.orange[100],)
        //padding and icon for prefix
      ),

      contentPadding: EdgeInsets.fromLTRB(30, 20, 30, 20),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color:Colors.orange[300]!, width: 1)
      ), //default border of input

      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color:Colors.white!, width: 1)
      ), //focus border

      fillColor:secondaryColor,
      filled: true, //set true if you want to show input background
    );
  }

  Widget errmsg(String text){
    //error message widget.
    return Container(
      padding: EdgeInsets.all(15.00),
      margin: EdgeInsets.only(bottom: 10.00),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color:secondaryColor,
          border: Border.all(color:Colors.red!, width:2)
      ),
      child: Row(children: <Widget>[
        Container(
          margin: EdgeInsets.only(right:6.00),
          child: Icon(Icons.info, color: Colors.white),
        ), // icon for error message

        Text(text, style: TextStyle(color: Colors.white, fontSize: 18)),
        //show error message text
      ]),
    );
  }
}

