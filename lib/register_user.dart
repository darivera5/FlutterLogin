import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterUser extends StatefulWidget {
  RegisterUserState createState() => RegisterUserState();
}

class Persona{
  final String name;
  final String lastName;
  final String place;
  Persona({this.name, this.lastName, this.place});
  factory Persona.fromJson(Map<String, dynamic> json){
    return Persona(
        name:json['first_name'],
        lastName:json['last_name'],
        place:json['place'],
    );
  }
}

class RegisterUserState extends State {
  // Boolean variable for CircularProgressIndicator.
  bool visible = false ;
  // Getting value from TextField widget.
  final nameController = TextEditingController();
  Future userRegistration() async{
    // Showing CircularProgressIndicator.
    setState(() {
      visible = true ;
    });

    String name = nameController.text;

    var url = 'http://192.168.1.251/PELPROOF/pelprof.php';
    var data = {'email': name};
    print(data);

    var response = await http.post(url, body: json.encode(data));
    var message;

    if(response.statusCode == 200){
      setState(() {
        visible = false;
      });
      var persona =  Persona.fromJson(json.decode(response.body));
      print(persona.name);
      print(persona.lastName);
      print(persona.place);
      message = persona.name.toUpperCase() + persona.lastName.toUpperCase() + persona.place.toUpperCase();
    }

    // Showing Alert Dialog with Response JSON Message.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(message),
          actions: <Widget>[
            FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('User Login Form')),
        body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text('User Registration Form',
                          style: TextStyle(fontSize: 21))),
                  Divider(),
                  Container(
                      width: 280,
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                        controller: nameController,
                        autocorrect: true,
                        decoration: InputDecoration(hintText: 'Enter Your Name Here'),
                      )
                  ),
                  RaisedButton(
                    onPressed: userRegistration,
                    color: Colors.green,
                    textColor: Colors.white,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Text('Click Here To Register User Online'),
                  ),
                  Visibility(
                      visible: visible,
                      child: Container(
                          margin: EdgeInsets.only(bottom: 30),
                          child: CircularProgressIndicator()
                      )
                  ),
                ],
              ),
            )));
  }
}