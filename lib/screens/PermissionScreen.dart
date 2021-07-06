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
  List<Permission> _roles;
  List<PermissionsList> _permissions;
  GlobalKey<ScaffoldState> _scaffoldKey;
  TextEditingController _firstNameController;
  TextEditingController _lastNameController;
  Permission _selectedRole;
  bool _isUpdating;
  String _titleProgress;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _permissions = [];
    _roles = [];
    _isUpdating = false;
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
    //_showProgress('Loading Users...');
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
              children: _roles.map<ExpansionPanel>((Permission role) {
                return ExpansionPanel(
                  headerBuilder: (context, isExpanded) {
                    return ListTile(
                      contentPadding: EdgeInsets.all(10.0),
                      title: Text(
                        role.name,
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      trailing: Wrap(spacing: 12, children: <Widget>[
                        IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                        IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                      ]),
                    );
                  },
                  body: Container(
                    height: 200,
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: getListView(role),
                  ),
                  isExpanded: role.isExpanded,
                );
              }).toList(),
            ),
          ),
        ),
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 2), () {
            // do something
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

  Widget getListView(Permission role) {
    _getPermissions(role.id);
    return ListView.builder(
      itemCount: _permissions == null ? 0 : _permissions.length,
      itemBuilder: (BuildContext context, int position) {
        return getRow(position, _permissions);
      },
    );
  }

  Widget getRow(int i, List permissions) {
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
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
