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
      body: ListView.builder(
        itemCount: options.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(options[index]),
            ),
          );
        },
      ),
    );
  }
}
