import 'package:flutter/material.dart';
import 'package:revisiones_spm/models/user.dart';
import 'package:revisiones_spm/services/UserService.dart';
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
  TextEditingController _firstNameController;
  TextEditingController _lastNameController;
  User _selectedUser;
  bool _isUpdating;
  String _titleProgress;
  ScrollController _scrollController = ScrollController();

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

  // DataTable->show the user list
  /*SingleChildScrollView _dataBody() {
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
  }*/

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
                          IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {}, icon: Icon(Icons.delete)),
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

/*---------------------------------
    return SingleChildScrollView(
        child: SafeArea(
            child: Container(
      color: Colors.blue,
      child: myWidgetExpansion(),
    )));
    /*return Scaffold(
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
          );*/
  }

  Widget myWidgetExpansion() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _users[index].isExpanded = !isExpanded;
        });
      },
      children: _users.map<ExpansionPanel>((user) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(user.firstName.toUpperCase() +
                  ' ' +
                  user.lastName.toUpperCase()),
            );
          },
          body: SafeArea(
            child: ListTile(
              title: Text('rol:' + user.roleId),
              subtitle: Text(user.email),
              leading: Icon(Icons.edit),
              trailing: Icon(Icons.delete),
              onTap: () {
                setState(() {
                  print('borro user');
                  //_deleteUser(user);
                });
              },
            ),
          ),
          isExpanded: user.isExpanded,
        );
      }).toList(),
    );
  }
}

List<ItemUser> generateItemAsList(int size) {
  return List.generate(size, (index) {
    return ItemUser('Role_id', 'nom' + ' ' + 'cognom', false);
  });
}
*/
