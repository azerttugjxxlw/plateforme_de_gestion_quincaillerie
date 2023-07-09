
import 'package:flutter/material.dart';

int id = 1;
String selectedValue = "B1";
var designation = TextEditingController();
var prix_up = TextEditingController();
var quantite = TextEditingController();
var description = TextEditingController();

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("B1"), value: "B1"),
    DropdownMenuItem(child: Text("B2"), value: "B2"),
    DropdownMenuItem(child: Text("B3"), value: "B3"),
    DropdownMenuItem(child: Text("B4"), value: "B4"),
  ];
  return menuItems;
}

String radioButtonItem = 'H';


Container buildContainer(BuildContext context) {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const SizedBox(height: 80,),
        Container(
          width: MediaQuery.of(context).size.width * 0.450,
          height: 400,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 18),
                      onPressed: () {},
                      icon: const Icon(Icons.cancel_rounded,color: Color.fromRGBO(11, 6, 65, 1),)
                  ),
                ],
              ),

              const SizedBox(height: 10,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                      width: MediaQuery.of(context).size.width * 0.23,
                      height: 50,
                      child: TextFormField(
                        controller: designation,
                        validator: (value){
                          if(value!.isEmpty){
                            return "Champ vide";
                          }
                        },
                        keyboardType: TextInputType.name,
                        maxLines: 1,
                        minLines: 1,
                        decoration: new InputDecoration(
                          hintText: "Designation : ",
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                      width: MediaQuery.of(context).size.width * 0.1,
                      height: 50,
                      child: DropdownButton(
                        disabledHint: Text("Categorie"),
                        value: selectedValue,
                        items: dropdownItems,
                        style: TextStyle(
                            color: Colors.black, fontSize: 15),
                        onChanged: (String? newValue) {
                          //  setState(() {selectedValue = newValue!;});
                        },
                      ),
                    ),

                  ]),
              const SizedBox(height: 12,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    width: MediaQuery.of(context).size.width * 0.23,
                    height: 50,
                    child: TextFormField(
                      controller: prix_up,
                      validator: (value){
                        if(value!.isEmpty){
                          return "Champ vide";
                        }
                      },
                      keyboardType: TextInputType.name,
                      maxLines: 1,
                      minLines: 1,
                      decoration: new InputDecoration(
                        hintText: "Prix UP : ",
                      ),
                    ),
                  ),
                  Radio(
                    value: 2,
                    groupValue: id,
                    onChanged: (val) {
                      /*  setState(() {
                              radioButtonItem = 'H';
                              sexe= 'H';
                              id = 2;
                            });*/
                    },
                  ),
                  Text(
                    'Active',
                    style: new TextStyle(
                      fontSize: 17.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12,),
              Container(
                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                width: MediaQuery.of(context).size.width * 0.23,
                height: 50,
                child: TextFormField(
                  controller: quantite,
                  validator: (value){
                    if(value!.isEmpty){
                      return "Champ vide";
                    }
                  },
                  keyboardType: TextInputType.name,
                  maxLines: 1,
                  minLines: 1,
                  decoration: new InputDecoration(
                    hintText: "Quantité : ",
                  ),
                ),
              ),
              const SizedBox(height: 15,),
              Container(
                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                width: MediaQuery.of(context).size.width * 0.23,
                height: 50,
                child: TextFormField(
                  controller: description,
                  validator: (value){
                    if(value!.isEmpty){
                      return "Champ vide";
                    }
                  },
                  keyboardType: TextInputType.name,
                  maxLines: 1,
                  minLines: 1,
                  decoration: new InputDecoration(
                    hintText: "Description : ",
                  ),
                ),
              ),
              const SizedBox(height: 35,),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      width: 130,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Color.fromRGBO(11, 6, 65, 1),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text('Enregistre',
                          style: TextStyle(color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15,),
                ],
              )
            ],
          ),
        )
      ],
    ),
  );
}