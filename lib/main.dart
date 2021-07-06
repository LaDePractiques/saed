import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:revisiones_spm/models/user.dart';
import 'package:revisiones_spm/screens/HomeScreen.dart';
import 'package:revisiones_spm/screens/UsersScreen.dart';
import 'package:revisiones_spm/services/functions.dart';

import 'common.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Revisiones SPM',
      routes: myRoutes,
      //home: HomeScreen(),
      //open login:
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController controllerEmail = new TextEditingController();
  TextEditingController controllerPass = new TextEditingController();

  String msg = '';

  Future<List> _login() async {
    final response = await http
        .post("http://10.0.2.2/revisiones_spmaritim/login.php", body: {
      "email": controllerEmail.text,
      "password": controllerPass.text,
    });

    final jsonresponse = json.decode(response.body);
    print(jsonresponse);

    if (jsonresponse.length == 0) {
      /*setState(() {
        msg = "Login Fail";
      });*/
      changeScreenReplacement(context, MyHomePage());
    } else {
      currentUser = User.fromJson(jsonresponse[0]);
      Navigator.pushNamed(context, '/home', arguments: currentUser);
    }
    return jsonresponse;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Form(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 77.0),
                  child: new CircleAvatar(
                    child: new Image(
                      width: 135,
                      height: 135,
                      image: new AssetImage('images/userandroid.png'),
                    ),
                  ),
                  width: 170.0,
                  height: 170.0,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: 93),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        height: 50,
                        padding: EdgeInsets.only(
                            top: 4, left: 16, right: 16, bottom: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            color: Colors.blue[50],
                            boxShadow: [
                              BoxShadow(color: Colors.blueGrey, blurRadius: 5)
                            ]),
                        child: TextFormField(
                          controller: controllerEmail,
                          decoration: InputDecoration(
                              icon: Icon(Icons.email),
                              hintText: 'email@example.com'),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        height: 50,
                        margin: EdgeInsets.only(top: 32),
                        padding: EdgeInsets.only(
                            top: 4, left: 16, right: 16, bottom: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            color: Colors.blue[50],
                            boxShadow: [
                              BoxShadow(color: Colors.blueGrey, blurRadius: 5)
                            ]),
                        child: TextField(
                          controller: controllerPass,
                          obscureText: true,
                          decoration: InputDecoration(
                              icon: Icon(Icons.vpn_key), hintText: 'password'),
                        ),
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 6,
                              right: 32,
                            ),
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Recordar contraseña',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )),
                      Spacer(),
                      ElevatedButton(
                        child: Text(
                          "Login",
                          style: TextStyle(fontSize: 25),
                        ),
                        onPressed: () {
                          _login();
                        },
                      ),
                      Text(
                        msg,
                        style: TextStyle(fontSize: 20.0, color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
