import 'package:flutter/material.dart';
import 'package:revisiones_spm/common.dart';
import 'package:revisiones_spm/models/ship.dart';
import 'package:revisiones_spm/services/ShipService.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class ShipsScreen extends StatefulWidget {
  get title => 'Barcos';

  @override
  _ShipsScreenState createState() => _ShipsScreenState();
}

class _ShipsScreenState extends State<ShipsScreen> {
  List<Ship> _ships;
  GlobalKey<ScaffoldState> _scaffoldKey;
  TextEditingController _ownerDniController;
  TextEditingController _identificationController;
  TextEditingController _nameController;
  TextEditingController _countryController;
  Ship _selectedShip;
  bool _isUpdating;
  String _titleProgress;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _ships = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey(); // key to get the context to show a SnackBar
    _ownerDniController = TextEditingController();
    _identificationController = TextEditingController();
    _nameController = TextEditingController();
    _countryController = TextEditingController();
    _getShips();
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

  // add an Ship
  _addShip() {
    if (_ownerDniController.text.isEmpty ||
        _identificationController.text.isEmpty ||
        _nameController.text.isEmpty ||
        _countryController.text.isEmpty) {
      print('Empty Fields');
      return;
    }
    _showProgress('Adding Ship...');
    ShipService.addShip(
            _ownerDniController.text,
            _identificationController.text,
            _nameController.text,
            _countryController.text)
        .then((result) {
      if ('success' == result) {
        _getShips(); // Refresh the List
        _clearValues();
      }
    });
  }

  _getShips() {
    _showProgress('Loading Ships...');
    if (currentUser.roleId == '1') {
      ShipService.getUserShips().then((ships) {
        setState(() {
          _ships = ships;
        });
        _showProgress(widget.title); // Reset the title
        print("Length ${ships.length}");
      });
    } else {
      ShipService.getAllShips().then((ships) {
        setState(() {
          _ships = ships;
        });
        _showProgress(widget.title); // Reset the title
        print("Length ${ships.length}");
      });
    }
  }

  _updateShip(Ship ship) {
    setState(() {
      _isUpdating = true;
    });
    _showProgress('Updating Ship...');
    ShipService.updateShip(
            ship.id,
            _ownerDniController.text,
            _identificationController.text,
            _nameController.text,
            _countryController.text)
        .then((result) {
      if ('success' == result) {
        _getShips(); // Refresh the list
        setState(() {
          _isUpdating = false;
        });
        _clearValues();
      }
    });
  }

  _deleteShip(Ship ship) {
    _showProgress('Deleting Ship...');
    ShipService.deleteShip(ship.id).then((result) {
      if ('success' == result) {
        _getShips(); // Refresh after delete...
      }
    });
  }

  // Method to clear TextField values
  _clearValues() {
    _ownerDniController.text = '';
    _identificationController.text = '';
    _nameController.text = '';
    _countryController.text = '';
  }

  _showValues(Ship ship) {
    //_ownerDniController.text = ship.ownerName;
    _identificationController.text = ship.identification;
    _nameController.text = ship.shipName;
    _countryController.text = ship.country;
  }

  // DataTable->show the ship list
  SingleChildScrollView _dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: (currentUser.roleId == '1')
            ? DataTable(
                columns: [
                  /*DataColumn(
                    label: Text('ID'),
                  ),*/
                  DataColumn(
                    label: Text('IDENTIFICACIÓN'),
                  ),
                  DataColumn(
                    label: Text('NOMBRE'),
                  ),
                  DataColumn(
                    label: Text('PAÍS'),
                  ),
                  DataColumn(
                    label: Text('BORRAR'),
                  ),
                ],
                rows: _ships
                    .map(
                      (ship) => DataRow(cells: [
                        /*DataCell(
                          Text(ship.id),
                          onTap: () {
                            _showValues(ship);
                            // Set the Selected ship to Update
                            _selectedShip = ship;
                            setState(() {
                              _isUpdating = true;
                            });
                          },
                        ),*/
                        DataCell(
                          Text(
                            ship.identification.toUpperCase(),
                          ),
                          onTap: () {
                            _showValues(ship);
                            // Set the Selected ship to Update
                            _selectedShip = ship;
                            setState(() {
                              _isUpdating = true;
                            });
                          },
                        ),
                        DataCell(
                          Text(
                            ship.shipName.toUpperCase(),
                          ),
                          onTap: () {
                            _showValues(ship);
                            // Set the Selected ship to Update
                            _selectedShip = ship;
                            setState(() {
                              _isUpdating = true;
                            });
                          },
                        ),
                        DataCell(
                          Text(
                            ship.country.toUpperCase(),
                          ),
                          onTap: () {
                            _showValues(ship);
                            // Set the Selected ship to Update
                            _selectedShip = ship;
                            setState(() {
                              _isUpdating = true;
                            });
                          },
                        ),
                        DataCell(IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _deleteShip(ship);
                          },
                        ))
                      ]),
                    )
                    .toList(),
              )
            : DataTable(
                columns: [
                  /*DataColumn(
                    label: Text('ID'),
                  ),*/
                  DataColumn(
                    label: Text('PROPIETARIO'),
                  ),
                  DataColumn(
                    label: Text('IDENTIFICACIÓN'),
                  ),
                  DataColumn(
                    label: Text('NOMBRE'),
                  ),
                  DataColumn(
                    label: Text('PAÍS'),
                  ),
                  DataColumn(
                    label: Text('BORRAR'),
                  ),
                ],
                rows: _ships
                    .map(
                      (ship) => DataRow(cells: [
                        /*DataCell(
                          Text(ship.id),
                          onTap: () {
                            _showValues(ship);
                            // Set the Selected ship to Update
                            _selectedShip = ship;
                            setState(() {
                              _isUpdating = true;
                            });
                          },
                        ),*/
                        DataCell(
                          Text(
                            ship.ownerName.toUpperCase() +
                                ' ' +
                                ship.ownerLastName.toUpperCase(),
                          ),
                          onTap: () {
                            _showValues(ship);
                            // Set the Selected ship to Update
                            _selectedShip = ship;
                            // Set flag updating to true to indicate in Update Mode
                            setState(() {
                              _isUpdating = true;
                            });
                          },
                        ),
                        DataCell(
                          Text(
                            ship.identification.toUpperCase(),
                          ),
                          onTap: () {
                            _showValues(ship);
                            // Set the Selected ship to Update
                            _selectedShip = ship;
                            setState(() {
                              _isUpdating = true;
                            });
                          },
                        ),
                        DataCell(
                          Text(
                            ship.shipName.toUpperCase(),
                          ),
                          onTap: () {
                            _showValues(ship);
                            // Set the Selected ship to Update
                            _selectedShip = ship;
                            setState(() {
                              _isUpdating = true;
                            });
                          },
                        ),
                        DataCell(
                          Text(
                            ship.country
                                .toUpperCase(), //ship.countryId.toUpperCase(),
                          ),
                          onTap: () {
                            _showValues(ship);
                            // Set the Selected ship to Update
                            _selectedShip = ship;
                            setState(() {
                              _isUpdating = true;
                            });
                          },
                        ),
                        DataCell(IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _deleteShip(ship);
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
              _getShips();
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: TextField(
                controller: _ownerDniController,
                decoration: InputDecoration.collapsed(
                  hintText: 'DNI del propietario',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: TextField(
                controller: _identificationController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Identificador',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Nombre',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: TextField(
                controller: _countryController,
                decoration: InputDecoration.collapsed(
                  hintText: 'País',
                ),
              ),
            ),
            // Add an update button and a Cancel Button
            // show these buttons only when updating an ship
            _isUpdating
                ? Row(
                    children: <Widget>[
                      OutlinedButton(
                        child: Text('UPDATE'),
                        onPressed: () {
                          _updateShip(_selectedShip);
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
          _addShip();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
