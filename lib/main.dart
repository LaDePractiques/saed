import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:revisiones_spm/models/user.dart';
import 'package:revisiones_spm/provider/user_provider.dart';
import 'package:revisiones_spm/screens/home.dart';
import 'package:revisiones_spm/screens/login1.dart';
import 'package:revisiones_spm/screens/users.dart';
import 'package:revisiones_spm/services/functions.dart';
import 'package:revisiones_spm/widgets/loading.dart';
import 'package:provider/provider.dart';

void main() => runApp(new MyApp());

String id = '';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Revisiones SPM',
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

    var datauser = json.decode(jsonEncode(response.body));
    print(datauser);

    if (datauser.length == 0) {
      setState(() {
        msg = "Login Fail";
      });
    } else {
      if (datauser[0]['role_id'] == '1') {
        print('client');
        changeScreenReplacement(context, HomeScreen());
      } else if (datauser[0]['role_id'] == '2') {}

      setState(() {
        id = datauser[0]['id'];
      });
    }

    return datauser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Form(
        child: Container(
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
                            hintText: 'example@email.com'),
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
                      style: TextStyle(fontSize: 20.0, color: Colors.blue),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
/*void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: UserProvider.initialize())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.blue),
        //home: ScreensController(),
        home: LoginOne(),
      )));
}*/
  /*class ScreensController extends StatelessWidget {
    @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    switch (user.status) {
      case Status.Uninitialized:
        return Loading();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return LoginOne();
      case Status.Authenticated:
        return HomeScreen();
      default:
        return LoginOne();
    }
  }*/
}
