import 'package:flutter/material.dart';
import 'package:revisiones_spm/models/audit.dart';
import 'package:revisiones_spm/models/checklist.dart';
import 'package:revisiones_spm/models/ship.dart';
import 'package:revisiones_spm/models/user.dart';
import 'package:revisiones_spm/services/AuditService.dart';
import 'package:revisiones_spm/services/ShipService.dart';
import 'package:revisiones_spm/services/UserService.dart';
import 'package:regexed_validator/regexed_validator.dart';

class FormUpdateAuditScreen extends StatefulWidget {
  @override
  _FormUpdateAuditScreenState createState() => _FormUpdateAuditScreenState();
}

class _FormUpdateAuditScreenState extends State<FormUpdateAuditScreen> {
  final _formKey = GlobalKey<FormState>();
  String id;
  String dropdownAuditor;
  String auditorName;
  String auditorLastname;
  String dropdownChecklist;
  String dropdownShip;
  TextEditingController dateCtrl = new TextEditingController();
  TextEditingController timeCtrl = new TextEditingController();
  List<User> _auditors;
  List<Checklist> _checklist;
  List<Ship> _ships;

  @override
  void initState() {
    super.initState();
    _auditors = [];
    _checklist = [];
    _ships = [];
    auditorName = null;
    auditorLastname = null;
    _getAuditors();
    _getChecklist();
    _getShips();
  }

  _getAuditors() {
    UserService.getAuditors().then((auditors) {
      setState(() {
        _auditors = auditors;
      });
    });
  }

  _getChecklist() {
    AuditService.getChecklist().then((checklist) {
      setState(() {
        _checklist = checklist;
      });
    });
  }

  _getShips() {
    ShipService.getAllShips().then((ships) {
      setState(() {
        _ships = ships;
      });
    });
  }

  String getValue(User user) {
    setData(user);
    return user.firstName + ' ' + user.lastName;
  }

  void setData(User user) {
    auditorName = user.firstName;
    auditorLastname = user.lastName;
  }

  @override
  Widget build(BuildContext context) {
    Audit audit = ModalRoute.of(context).settings.arguments;
    dropdownAuditor = audit.userName;
    dropdownChecklist = audit.checklist;
    dropdownShip = audit.shipName;
    dateCtrl = audit.dateStart as TextEditingController;
    timeCtrl = audit.time as TextEditingController;
    id = audit.getId;

    return SingleChildScrollView(
      child: new Container(
        margin: EdgeInsets.all(20.0),
        child: Form(key: _formKey, child: formUI()),
      ),
    );
  }

  formItemsDesign(item) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Card(child: ListTile(title: item)),
    );
  }

  Widget formUI() {
    return Column(
      children: <Widget>[
        DropdownButton<String>(
          value: dropdownAuditor,
          icon: const Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (String newValue) {
            setState(() {
              dropdownAuditor = newValue;
            });
          },
          items: _auditors.map<DropdownMenuItem<String>>((User value) {
            return DropdownMenuItem<String>(
              value: getValue(value),
              child: Text(value.firstName + ' ' + value.lastName),
            );
          }).toList(),
        ),
        DropdownButton<String>(
          value: dropdownChecklist,
          icon: const Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (String newValue) {
            setState(() {
              dropdownChecklist = newValue;
            });
          },
          items: _checklist.map<DropdownMenuItem<String>>((Checklist value) {
            return DropdownMenuItem<String>(
              value: value.name,
              child: Text(value.name),
            );
          }).toList(),
        ),
        DropdownButton<String>(
          value: dropdownShip,
          icon: const Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (String newValue) {
            setState(() {
              dropdownShip = newValue;
            });
          },
          items: _ships.map<DropdownMenuItem<String>>((Ship value) {
            return DropdownMenuItem<String>(
              value: value.shipName,
              child: Text(value.shipName),
            );
          }).toList(),
        ),
        formItemsDesign(TextFormField(
          controller: dateCtrl,
          decoration: new InputDecoration(
            labelText: 'Fecha (AAAA-MM-DD)',
          ),
          validator: validateDate,
        )),
        formItemsDesign(TextFormField(
          controller: timeCtrl,
          decoration: new InputDecoration(
            labelText: 'Hora',
          ),
          validator: validateTime,
        )),
        GestureDetector(
            onTap: () {
              save();
            },
            child: Container(
              margin: new EdgeInsets.all(30.0),
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                gradient: LinearGradient(colors: [
                  Color(0xFF0EDED2),
                  Color(0xFF03A0FE),
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              ),
              child: Text("Guardar",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
              padding: EdgeInsets.only(top: 16, bottom: 16),
            ))
      ],
    );
  }

  String validateDate(String value) {
    if (value.length == 0) {
      return "El campo es necesario";
    } else if (validator.date(value)) {
      return "El formato de fecha es AAAA-MM-DD";
    }
    return null;
  }

  String validateTime(String value) {
    if (value.length == 0) {
      return "El campo es necesario";
    } else if (validator.time(value)) {
      return "El formato de hora es 00:00";
    }
    return null;
  }

  save() {
    if (_formKey.currentState.validate() &&
        auditorName != null &&
        auditorLastname != null) {
      AuditService.updateAudit(
        id,
        dropdownShip,
        auditorName,
        auditorLastname,
        timeCtrl.text,
        dropdownChecklist,
        dateCtrl.text,
      ).then((result) {
        if ('success' == result) {
          print(result);
          _formKey.currentState.reset();
          Navigator.pushReplacementNamed(context, '/audits');
        }
      });
    }
  }
}
