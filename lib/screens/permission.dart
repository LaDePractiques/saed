import 'package:flutter/material.dart';

class PermissionScreen extends StatefulWidget {
  @override
  _PermissionScreenState createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  final options = [
    'Administrador',
    'Cliente',
    'Tècnico',
    'Auditor',
    'Auditor y Técnico'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Permisos')),
      body: ListView(
        children: createItems(),
      ),
    );
  }

  List<Widget> createItems() {
    List listItem;
    for (String opt in options) {
      final tempWidget = ListTile(title: Text(opt));
      listItem.add(tempWidget);
      listItem.add(Divider());
    }
    return listItem;
  }
}
