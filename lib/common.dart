//current user
import 'package:flutter/material.dart';
import 'package:revisiones_spm/models/user.dart';
import 'package:revisiones_spm/screens/AuditsScreen.dart';
import 'package:revisiones_spm/screens/FormAddAuditScreen.dart';
import 'package:revisiones_spm/screens/FormAddUserScreen.dart';
import 'package:revisiones_spm/screens/FormUpdateAuditScreen.dart';
import 'package:revisiones_spm/screens/FormUpdateUserScreen.dart';
import 'package:revisiones_spm/screens/HomeScreen.dart';
import 'package:revisiones_spm/screens/MyAuditsScreen.dart';
import 'package:revisiones_spm/screens/MyWorksScreen.dart';
import 'package:revisiones_spm/screens/PermissionScreen.dart';
import 'package:revisiones_spm/screens/ShipsScreen.dart';
import 'package:revisiones_spm/screens/StartAuditScreen.dart';
import 'package:revisiones_spm/screens/SummaryAuditScreen.dart';
import 'package:revisiones_spm/screens/UsersScreen.dart';
import 'package:revisiones_spm/screens/WorksScreen.dart';

User currentUser;

//routes
final myRoutes = {
  '/home': (BuildContext context) => HomeScreen(),
  '/users': (BuildContext context) => UsersScreen(),
  '/ships': (BuildContext context) => ShipsScreen(),
  '/audits': (BuildContext context) => AuditsScreen(),
  '/myAudits': (BuildContext context) => MyAuditsScreen(),
  '/myWorks': (BuildContext context) => MyWorksScreen(),
  '/permission': (BuildContext context) => PermissionScreen(),
  '/works': (BuildContext context) => WorksScreen(),
  '/form': (BuildContext context) => FormAddUserScreen(),
  '/form_update': (BuildContext context) => FormUpdateUserScreen(),
  '/form_audit': (BuildContext context) => FormAddAuditScreen(),
  '/form_audit_update': (BuildContext context) => FormUpdateAuditScreen(),
  '/start_audit': (BuildContext context) => StartAuditScreen(),
  //'/summary_audit': (BuildContext context) => SummaryAuditScreen(),
};

//FOR SCRIPTS PHP
//login
const ROOT_LOGIN = 'http://10.0.2.2/revisiones_spmaritim/login.php';
//user
const ROOT_USER_ACTION =
    'http://10.0.2.2/revisiones_spmaritim/user_actions.php';
const GET_ALL_USERS_ACTION = 'GET_ALL_USERS';
const GET_ALL_AUDITORS_ACTION = 'GET_ALL_AUDITORS';
const ADD_USER_ACTION = 'ADD_USER';
const UPDATE_USER_ACTION = 'UPDATE_USER';
const DELETE_USER_ACTION = 'DELETE_USER';
//ship
const ROOT_SHIP_ACTION =
    'http://10.0.2.2/revisiones_spmaritim/ship_actions.php';
const GET_ALL_SHIPS_ACTION = 'GET_ALL_SHIPS';
const GET_ALL_SHIPS_OF_USER_ACTION = 'GET_ALL_SHIPS_OF_USER';
const ADD_SHIP_ACTION = 'ADD_SHIP';
const UPDATE_SHIP_ACTION = 'UPDATE_SHIP';
const DELETE_SHIP_ACTION = 'DELETE_SHIP';
//audit
const ROOT_AUDIT_ACTION =
    'http://10.0.2.2/revisiones_spmaritim/audit_actions.php';
const GET_ALL_AUDITS_ACTION = 'GET_ALL_AUDITS';
const GET_ALL_MYAUDITS_ACTION = 'GET_ALL_MY_AUDITS';
const GET_ALL_CHECKLIST_NAME_ACTION = 'GET_ALL_CHECKLIST_NAME';
const GET_ALL_ANSWER_ACTION = 'GET_ALL_ANSWER';
const SUMMARY_CHART_AUDIT_ACTION = 'SUMMARY_CHART_AUDIT';
const ADD_AUDIT_ACTION = 'ADD_AUDIT';
const UPDATE_AUDIT_ACTION = 'UPDATE_AUDIT';
const DELETE_AUDIT_ACTION = 'DELETE_AUDIT';
//permission
const ROOT_PERMISSION_ACTION =
    'http://10.0.2.2/revisiones_spmaritim/permission_actions.php';
const GET_PERMISSIONS = 'GET_ALL_PERMISSIONS_OF_ROLES';
const GET_ALL_ROLES_ACTION = 'GET_ALL_ROLES';
