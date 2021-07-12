import 'package:flutter/material.dart';
import 'package:revisiones_spm/models/permission.dart';
import 'package:revisiones_spm/services/PermissionService.dart';
import 'dart:async';

class PermissionScreen extends StatefulWidget {
  get title => 'Permisos';
  @override
  _PermissionScreenState createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  List<Role> _roles;
  List<String> _permissions;
  GlobalKey<ScaffoldState> _scaffoldKey;
  String _titleProgress;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _permissions = [];
    _roles = [];
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey();
    _getRoles();
  }

  _getRoles() {
    PermissionService.getAllRoles().then((roles) {
      setState(() {
        _roles = roles;
      });
      print("Length ${roles.length}");
    });
  }

  _getPermissions(String role) {
    PermissionService.getAllPermissions(role).then((permissions) {
      setState(() {
        _permissions = permissions;
      });
      //_showProgress(widget.title); // Reset the title
      print("Length ${permissions.length}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_titleProgress),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _getRoles();
            },
          )
        ],
      ),
      body: RefreshIndicator(
        color: Theme.of(context).primaryColor,
        displacement: 40,
        child: SafeArea(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: ExpansionPanelList(
              animationDuration: Duration(milliseconds: 500),
              expansionCallback: (panelIndex, isExpanded) {
                setState(() {
                  _roles[panelIndex].isExpanded = !isExpanded;
                });
              },
              children: _roles.map<ExpansionPanel>((Role role) {
                return ExpansionPanel(
                  headerBuilder: (context, isExpanded) {
                    return ListTile(
                      contentPadding: EdgeInsets.all(10.0),
                      title: Text(
                        role.name,
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    );
                  },
                  body: myBody(role.id),
                  isExpanded: role.isExpanded,
                );
              }).toList(),
            ),
          ),
        ),
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 2), () {
            _getRoles();
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //_addRole();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget myBody(String id) {
    _getPermissions(id);
    return Container(
      height: 200,
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      //child: getListView(role),
      child: ListView.builder(
        itemCount: _permissions.length,
        itemBuilder: (BuildContext context, int position) {
          return getRow(position, _permissions);
        },
      ),
    );
    //}
    //}
  }

  Widget getListView(Role role) {
    return ListView.builder(
      itemCount: _permissions == null ? 0 : _permissions.length,
      itemBuilder: (BuildContext context, int position) {
        return getRow(position, _permissions);
      },
    );
  }

  Widget getRow(int i, List fields) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        child: ListTile(
          title: Text(
            fields[i],
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ),
    );
  }

  /*Widget getRow(int i, List permissions) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        child: ListTile(
          title: Text(
            permissions[i].name,
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ),
    );
  }*/

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
