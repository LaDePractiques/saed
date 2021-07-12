import 'package:flutter/material.dart';
import 'package:revisiones_spm/models/user.dart';
import 'package:revisiones_spm/services/UserService.dart';
import 'dart:async';

class UsersScreen extends StatefulWidget {
  get title => 'Usuarios';

  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  List<User> _users;
  GlobalKey<ScaffoldState> _scaffoldKey;
  String _titleProgress;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _users = [];
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey(); // key to get the context to show a SnackBar
    _getUsers();
  }

  // Method to update title in the AppBar Title
  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  _showSnackBar(context, message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  // add an User
  _addUser() {
    _showProgress('Adding User...');
    Navigator.pushNamed(context, '/form'); // go to FormScreen
  }

  _getUsers() {
    _showProgress('Loading Users...');
    UserService.getUsers().then((users) {
      setState(() {
        _users = users;
      });
      _showProgress(widget.title); // Reset the title
      print("Length ${users.length}");
    });
  }

  _updateUser(User user) {
    _showProgress('Updating User...');
    Navigator.pushNamed(context, '/form_update', arguments: user);
  }

  _deleteUser(User user) {
    _showProgress('Deleting User...');
    UserService.deleteUser(user.id).then((result) {
      if ('success' == result) {
        _getUsers(); // Refresh after delete...
      }
    });
  }

  // UI
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
              _getUsers();
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
                  _users[panelIndex].isExpanded = !isExpanded;
                });
              },
              children: _users.map<ExpansionPanel>((User user) {
                List fields = [
                  user.email,
                  'DNI: ' + user.dni,
                  'Dirección: ' + user.direction,
                  'Población: ' + user.city,
                  'Fecha nacimiento: ' + user.birthdate.toString()
                ];
                return ExpansionPanel(
                  headerBuilder: (context, isExpanded) {
                    return ListTile(
                        contentPadding: EdgeInsets.all(10.0),
                        title: Text(
                          user.firstName + ' ' + user.lastName,
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        subtitle: Text(user.roleName),
                        trailing: Wrap(spacing: 12, children: <Widget>[
                          IconButton(
                              onPressed: () {
                                _updateUser(user);
                              },
                              icon: Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                _deleteUser(user);
                              },
                              icon: Icon(Icons.delete)),
                        ]),
                        leading: Text(user.id));
                  },
                  body: Container(
                    height: 200,
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: ListView.builder(
                      itemCount: fields.length,
                      itemBuilder: (BuildContext context, int position) {
                        return getRow(position, fields);
                      },
                    ),
                  ),
                  isExpanded: user.isExpanded,
                );
              }).toList(),
            ),
          ),
        ),
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 2), () {
            // do something
            _getUsers();
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addUser();
        },
        child: Icon(Icons.add),
      ),
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
