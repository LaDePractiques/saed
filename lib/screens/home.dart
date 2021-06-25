import 'package:flutter/material.dart';
import 'package:revisiones_spm/models/user.dart';
import 'package:revisiones_spm/screens/audits.dart';
import 'package:revisiones_spm/screens/myAudits.dart';
import 'package:revisiones_spm/screens/myWorks.dart';
import 'package:revisiones_spm/screens/permission.dart';
import 'package:revisiones_spm/screens/ships.dart';
import 'package:revisiones_spm/screens/users.dart';
import 'package:revisiones_spm/screens/works.dart';
import 'package:revisiones_spm/services/functions.dart';
import 'package:revisiones_spm/services/styles.dart';
import 'package:revisiones_spm/widgets/custom_text.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var email = '';
  var name = '';
  final List<String> myMenu = [
    'Usuarios',
    'Barcos',
    'Permisos',
    'Auditorias',
    'Trabajos y presupuestos',
    'Mis Trabajos',
    'Mis auditorias'
  ];

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: myMenu.length,
            itemBuilder: (BuildContext context, index) {
              return GestureDetector(
                  child: new Card(
                      elevation: 5.0,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          myMenu[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.blue[700],
                            borderRadius: BorderRadius.circular(15)),
                      )),
                  onTap: () {
                    switch (index) {
                      case 0:
                        changeScreen(context, UsersScreen());
                        break;
                      case 1:
                        changeScreen(context, ShipsScreen());
                        break;
                      case 2:
                        changeScreen(context, PermissionScreen());
                        break;
                      case 3:
                        changeScreen(context, AuditsScreen());
                        break;
                      case 4:
                        changeScreen(context, WorksScreen());
                        break;
                      case 5:
                        changeScreen(context, MyWorksScreen());
                        break;
                      case 6:
                        changeScreen(context, MyAuditsScreen());
                        break;
                      default:
                    }
                  });
            }),
      ),
    );
  }
}
