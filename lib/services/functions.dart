import 'package:flutter/material.dart';
import 'package:revisiones_spm/screens/audits.dart';
import 'package:revisiones_spm/screens/home.dart';
import 'package:revisiones_spm/screens/myAudits.dart';
import 'package:revisiones_spm/screens/myWorks.dart';
import 'package:revisiones_spm/screens/permission.dart';
import 'package:revisiones_spm/screens/ships.dart';
import 'package:revisiones_spm/screens/users.dart';
import 'package:revisiones_spm/screens/works.dart';

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
