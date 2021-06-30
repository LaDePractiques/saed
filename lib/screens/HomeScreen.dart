import 'package:flutter/material.dart';
import 'package:revisiones_spm/models/user.dart';
import 'package:revisiones_spm/services/styles.dart';
import 'package:revisiones_spm/widgets/custom_text.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    final User user = ModalRoute.of(context).settings.arguments;
    var email = user.email;
    var name = user.firstName + ' ' + user.lastName;
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
                Navigator.pushNamed(context, '/users', arguments: user);
              },
            ),
            ListTile(
              leading: Icon(Icons.anchor),
              title: CustomText(
                msg: "Barcos",
              ),
              onTap: () {
                Navigator.pushNamed(context, '/ships', arguments: user);
              },
            ),
            ListTile(
              leading: Icon(Icons.build_circle),
              title: CustomText(
                msg: "Permisos",
              ),
              onTap: () {
                Navigator.pushNamed(context, '/permission', arguments: user);
              },
            ),
            ListTile(
              leading: Icon(Icons.add_task),
              title: CustomText(
                msg: "Auditorias",
              ),
              onTap: () {
                Navigator.pushNamed(context, '/audits', arguments: user);
              },
            ),
            ListTile(
              leading: Icon(Icons.work),
              title: CustomText(
                msg: "Trabajos y presupuestos",
              ),
              onTap: () {
                Navigator.pushNamed(context, '/works', arguments: user);
              },
            ),
            ListTile(
              leading: Icon(Icons.folder),
              title: CustomText(
                msg: "Mis trabajos",
              ),
              onTap: () {
                Navigator.pushNamed(context, '/myWorks', arguments: user);
              },
            ),
            ListTile(
              leading: Icon(Icons.folder),
              title: CustomText(
                msg: "Mis auditorias",
              ),
              onTap: () {
                Navigator.pushNamed(context, '/myAudits', arguments: user);
              },
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
                        Navigator.pushNamed(context, '/users', arguments: user);
                        break;
                      case 1:
                        Navigator.pushNamed(context, '/ships', arguments: user);
                        break;
                      case 2:
                        Navigator.pushNamed(context, '/permission',
                            arguments: user);
                        break;
                      case 3:
                        Navigator.pushNamed(context, '/audits',
                            arguments: user);
                        break;
                      case 4:
                        Navigator.pushNamed(context, '/works', arguments: user);
                        break;
                      case 5:
                        Navigator.pushNamed(context, '/myWorks',
                            arguments: user);
                        break;
                      case 6:
                        Navigator.pushNamed(context, '/myAudits',
                            arguments: user);
                        break;
                      default:
                        Navigator.pushNamed(context, '/home', arguments: user);
                    }
                  });
            }),
      ),
    );
  }
}
