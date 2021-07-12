import 'package:flutter/material.dart';
import 'package:revisiones_spm/models/user.dart';
import 'package:revisiones_spm/services/UserService.dart';

class FormUpdateUserScreen extends StatefulWidget {
  @override
  _FormUpdateUserScreenState createState() => _FormUpdateUserScreenState();
}

class _FormUpdateUserScreenState extends State<FormUpdateUserScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameCtrl = new TextEditingController();
  TextEditingController lastnameCtrl = new TextEditingController();
  TextEditingController dniCtrl = new TextEditingController();
  TextEditingController emailCtrl = new TextEditingController();
  TextEditingController psw1Ctrl = new TextEditingController();
  TextEditingController psw2Ctrl = new TextEditingController();
  TextEditingController directionCtrl = new TextEditingController();
  TextEditingController roleCtrl = new TextEditingController();
  TextEditingController countryCtrl = new TextEditingController();
  TextEditingController birthdateCtrl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    User user = ModalRoute.of(context).settings.arguments;
    nameCtrl = user.firstName as TextEditingController;
    lastnameCtrl = user.lastName as TextEditingController;
    dniCtrl = user.dni as TextEditingController;
    emailCtrl = user.email as TextEditingController;
    directionCtrl = user.direction as TextEditingController;
    roleCtrl = user.roleName as TextEditingController;
    countryCtrl = user.city as TextEditingController;
    birthdateCtrl = user.birthdate as TextEditingController;

    return SingleChildScrollView(
      child: new Container(
        margin: EdgeInsets.all(20.0),
        child: Form(key: _formKey, child: formUI(user)),
      ),
    );
  }

  formItemsDesign(
    icon,
    item,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Card(child: ListTile(leading: Icon(icon), title: item)),
    );
  }

  Widget formUI(User user) {
    return Column(
      children: <Widget>[
        formItemsDesign(
            Icons.person,
            TextFormField(
              controller: nameCtrl,
              decoration: new InputDecoration(
                labelText: 'Nombre',
              ),
              validator: validateName,
            )),
        formItemsDesign(
            Icons.person,
            TextFormField(
              controller: lastnameCtrl,
              decoration: new InputDecoration(
                labelText: 'Apellido',
              ),
              validator: validateName,
            )),
        formItemsDesign(
            Icons.card_giftcard,
            TextFormField(
              controller: dniCtrl,
              decoration: new InputDecoration(
                labelText: 'DNI',
              ),
              maxLength: 9,
              validator: validateDni,
            )),
        formItemsDesign(
            Icons.email,
            TextFormField(
              controller: emailCtrl,
              decoration: new InputDecoration(
                labelText: 'Email',
              ),
              keyboardType: TextInputType.emailAddress,
              maxLength: 32,
              validator: validateEmail,
            )),
        formItemsDesign(
            Icons.streetview,
            TextFormField(
              controller: directionCtrl,
              decoration: new InputDecoration(
                labelText: 'Dirección',
              ),
              validator: validateName,
            )),
        formItemsDesign(
            Icons.location_city,
            TextFormField(
              controller: countryCtrl,
              decoration: new InputDecoration(
                labelText: 'País',
              ),
              validator: validateName,
            )),
        formItemsDesign(
            Icons.calendar_today,
            TextFormField(
              controller: birthdateCtrl,
              decoration: new InputDecoration(
                labelText: 'Fecha de nacimiento (AAAA-MM-DD)',
              ),
              validator: validateBirthdate,
            )),
        formItemsDesign(
            Icons.build_circle,
            TextFormField(
              controller: roleCtrl,
              decoration: new InputDecoration(
                labelText: 'Rol',
              ),
            )),
        formItemsDesign(
            Icons.remove_red_eye,
            TextFormField(
              controller: psw1Ctrl,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña',
              ),
            )),
        formItemsDesign(
            Icons.remove_red_eye,
            TextFormField(
              controller: psw2Ctrl,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Repetir la Contraseña',
              ),
              validator: validatePassword,
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

  String validatePassword(String value) {
    print("valor $value passsword ${psw1Ctrl.text}");
    if (value != psw1Ctrl.text) {
      return "Las contraseñas no coinciden";
    }
    return null;
  }

  String validateName(String value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "El campo es necesario";
    } else if (!regExp.hasMatch(value)) {
      return "El nombre debe de ser a-z y A-Z";
    }
    return null;
  }

  String validateDni(String value) {
    RegExp nifRexp = new RegExp(r'^[0-9]{8}[TRWAGMYFPDXBNJZSQVHLCKET]$');
    var validChars = 'TRWAGMYFPDXBNJZSQVHLCKET';
    RegExp nieRexp = new RegExp(r'/^[XYZ][0-9]{7}[TRWAGMYFPDXBNJZSQVHLCKET]$');
    var str = value.toString().toUpperCase();

    if (!nifRexp.hasMatch(str) && !nieRexp.hasMatch(str))
      return 'Por favor, introduce un documento vàlido';

    String nie = str
        .replaceAll(new RegExp(r"/^[X]/"), '0')
        .replaceAll(new RegExp(r"/^[Y]/"), '1')
        .replaceAll(new RegExp(r"/^[Z]/"), '2');

    var letter = str.substring(str.length - 1);
    var charIndex = int.parse(nie.substring(0, 8)) % 23;
    if (validChars[charIndex] != letter) return 'No válido';
    return null;
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "El correo es necesario";
    } else if (!regExp.hasMatch(value)) {
      return "Correo invalido";
    } else {
      return null;
    }
  }

  String validateBirthdate(String value) {
    String pattern = r'(^\d{4}\-(0[1-9]|1[012])\-(0[1-9]|[12][0-9]|3[01])$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "El campo es necesario";
    } else if (!regExp.hasMatch(value)) {
      return "El formato de fecha es AAAA-MM-DD";
    }
    return null;
  }

  save() {
    if (_formKey.currentState.validate()) {
      //-------falta encriptar contrasenya!!!!------
      UserService.updateUser(
              nameCtrl.text,
              lastnameCtrl.text,
              dniCtrl.text,
              emailCtrl.text,
              psw1Ctrl.text,
              directionCtrl.text,
              roleCtrl.text,
              countryCtrl.text,
              birthdateCtrl.text)
          .then((result) {
        if ('success' == result) {
          _formKey.currentState.reset();
          Navigator.pushReplacementNamed(context, '/users');
        }
      });
    }
  }
}
