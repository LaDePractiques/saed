import 'package:flutter/material.dart';
import 'package:revisiones_spm/models/user.dart';
import 'package:revisiones_spm/screens/permission.dart';
import 'package:revisiones_spm/screens/users.dart';
import 'package:revisiones_spm/services/functions.dart';
import 'package:revisiones_spm/services/styles.dart';
import 'package:revisiones_spm/widgets/custom_text.dart';

class HomeScreen1 extends StatefulWidget {
  @override
  _HomeScreen1State createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1> {
  var email = '';
  var name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text(
          "Revisiones Náuticas",
          style: TextStyle(color: Colors.blue),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: CustomText(
                msg: email,
                color: white,
              ),
              accountName: CustomText(
                msg: name,
                color: white,
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: CustomText(
                msg: "Usuarios",
              ),
              onTap: () {
                changeScreen(context, UsersScreen());
              },
            ),
            ListTile(
              leading: Icon(Icons.anchor),
              title: CustomText(
                msg: "Barcos",
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.build_circle),
              title: CustomText(
                msg: "Permisos",
              ),
              onTap: () {
                changeScreen(context, PermissionScreen());
              },
            ),
            ListTile(
              leading: Icon(Icons.add_task),
              title: CustomText(
                msg: "Auditorias",
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.work),
              title: CustomText(
                msg: "Trabajos y presupuestos",
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.folder),
              title: CustomText(
                msg: "Mis trabajos",
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.folder),
              title: CustomText(
                msg: "Mis auditorias",
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Container(
        color: white,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Image.asset(
                "images/mobile.png",
                width: 200,
                height: 200,
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  decoration: BoxDecoration(color: blue),
                  child: GestureDetector(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                          child: TextButton(
                            child: Text('Barcos'),
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: blue,
                              textStyle: TextStyle(
                                  color: white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600),
                            ),
                            onPressed: () {},
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  decoration: BoxDecoration(color: blue),
                  child: GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                          child: TextButton(
                            child: Text('Revisiones'),
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: blue,
                              textStyle: TextStyle(
                                  color: white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600),
                            ),
                            onPressed: () {
                              //changeScreenReplacement(context, HomeScreen1());
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
