import 'package:flutter/material.dart';
import 'package:revisiones_spm/models/user.dart';
import 'package:revisiones_spm/services/user.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class UsersScreen extends StatefulWidget {
  get title => 'Usuarios';

  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  List<User> _users;
  GlobalKey<ScaffoldState> _scaffoldKey;
  // First Name TextField
  TextEditingController _firstNameController;
  // Last Name TextField
  TextEditingController _lastNameController;
  User _selectedUser;
  bool _isUpdating;
  String _titleProgress;

  @override
  void initState() {
    super.initState();
    _users = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey(); // key to get the context to show a SnackBar
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
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
    if (_firstNameController.text.isEmpty || _lastNameController.text.isEmpty) {
      print('Empty Fields');
      return;
    }
    _showProgress('Adding User...');
    UserService.addUser(_firstNameController.text, _lastNameController.text)
        .then((result) {
      if ('success' == result) {
        _getUsers(); // Refresh the List
        _clearValues();
      }
    });
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
    setState(() {
      _isUpdating = true;
    });
    _showProgress('Updating User...');
    UserService.updateUser(
            user.id, _firstNameController.text, _lastNameController.text)
        .then((result) {
      if ('success' == result) {
        _getUsers(); // Refresh the list
        setState(() {
          _isUpdating = false;
        });
        _clearValues();
      }
    });
  }

  _deleteUser(User user) {
    _showProgress('Deleting User...');
    UserService.deleteUser(user.id).then((result) {
      if ('success' == result) {
        _getUsers(); // Refresh after delete...
      }
    });
  }

  // Method to clear TextField values
  _clearValues() {
    _firstNameController.text = '';
    _lastNameController.text = '';
  }

  _showValues(User user) {
    _firstNameController.text = user.firstName;
    _lastNameController.text = user.lastName;
  }

  //ExpansionPanel
   
  
  // DataTable->show the user list
  SingleChildScrollView _dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text('ID'),
            ),
            DataColumn(
              label: Text('FIRST NAME'),
            ),
            DataColumn(
              label: Text('LAST NAME'),
            ),
            DataColumn(
              label: Text('DELETE'),
            )
          ],
          rows: _users
              .map(
                (user) => DataRow(cells: [
                  DataCell(
                    Text(user.id.toString()),
                    onTap: () {
                      _showValues(user);
                      // Set the Selected user to Update
                      _selectedUser = user;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      user.firstName.toUpperCase(),
                    ),
                    onTap: () {
                      _showValues(user);
                      // Set the Selected user to Update
                      _selectedUser = user;
                      // Set flag updating to true to indicate in Update Mode
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      user.lastName.toUpperCase(),
                    ),
                    onTap: () {
                      _showValues(user);
                      // Set the Selected user to Update
                      _selectedUser = user;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteUser(user);
                    },
                  ))
                ]),
              )
              .toList(),
        ),
      ),
    );
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
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _firstNameController,
                decoration: InputDecoration.collapsed(
                  hintText: 'First Name',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _lastNameController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Last Name',
                ),
              ),
            ),
            // Add an update button and a Cancel Button
            // show these buttons only when updating an user
            _isUpdating
                ? Row(
                    children: <Widget>[
                      OutlinedButton(
                        child: Text('UPDATE'),
                        onPressed: () {
                          _updateUser(_selectedUser);
                        },
                      ),
                      OutlinedButton(
                        child: Text('CANCEL'),
                        onPressed: () {
                          setState(() {
                            _isUpdating = false;
                          });
                          _clearValues();
                        },
                      ),
                    ],
                  )
                : Container(),
            Expanded(
              child: _dataBody(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addUser();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
