import 'package:flutter/material.dart';
import 'package:LogIn/login_user_state.dart';

void main() => runApp(
    MaterialApp(
      home: MyApp(),
    )
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text('User Login Form')),
            body: Center(
                child: LoginUser()
            )
        )
    );
  }
}

class LoginUser extends StatefulWidget {
  LoginUserState createState() => LoginUserState();
}








