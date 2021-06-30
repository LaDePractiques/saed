import 'package:flutter/material.dart';
import 'package:revisiones_spm/models/user.dart';
import 'package:revisiones_spm/screens/AuditsScreen.dart';
import 'package:revisiones_spm/screens/HomeScreen.dart';
import 'package:revisiones_spm/screens/MyAuditsScreen.dart';
import 'package:revisiones_spm/screens/MyWorksScreen.dart';
import 'package:revisiones_spm/screens/PermissionScreen.dart';
import 'package:revisiones_spm/screens/ShipsScreen.dart';
import 'package:revisiones_spm/screens/UsersScreen.dart';
import 'package:revisiones_spm/screens/WorksScreen.dart';

final myRoutes = {
  '/home': (BuildContext context) => HomeScreen(),
  '/users': (BuildContext context) => UsersScreen(),
  '/ships': (BuildContext context) => ShipsScreen(),
  '/audits': (BuildContext context) => AuditsScreen(),
  '/myAudits': (BuildContext context) => MyAuditsScreen(),
  '/myWorks': (BuildContext context) => MyWorksScreen(),
  '/permission': (BuildContext context) => PermissionScreen(),
  '/works': (BuildContext context) => WorksScreen(),
};

void changeScreen(BuildContext context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => widget));
}

void changeScreenReplacement(BuildContext context, Widget widget) {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => widget));
}

void comeBack(BuildContext context) {
  Navigator.pop(context);
}
