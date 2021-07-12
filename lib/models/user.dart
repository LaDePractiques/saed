import 'dart:convert';
import 'dart:core';

class User {
  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      //this.emailVerifiedAt,
      this.dni,
      this.direction,
      this.city,
      this.birthdate,
      this.password,
      this.roleId,
      //this.rememberToken,
      this.roleName,
      this.isExpanded = false});

  String id;
  String firstName;
  String lastName;
  String email;
  dynamic emailVerifiedAt;
  String dni;
  String direction;
  String city;
  DateTime birthdate;
  String password;
  String roleId;
  dynamic rememberToken;
  bool isExpanded;
  String roleName;

  //  GETTERS
  String get getFirstName => firstName;
  String get getLastName => lastName;
  String get getEmail => email;
  String get getDni => dni;
  String get getAddress => direction;
  String get getCountry => city;
  String get getId => id;
  DateTime get getBirthdate => birthdate;
  String get getRoleId => roleId;
  String get getRoleName => roleName;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        //emailVerifiedAt: json["email_verified_at"],
        dni: json["dni"],
        direction: json["direction"],
        city: json["city"],
        birthdate: DateTime.parse(json["birthdate"]),
        password: json["password"],
        roleId: json["role_id"],
        //rememberToken: json["remember_token"],
        roleName: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        //"email_verified_at": emailVerifiedAt,
        "dni": dni,
        "direction": direction,
        "city": city,
        "birthdate":
            "${birthdate.year.toString().padLeft(4, '0')}-${birthdate.month.toString().padLeft(2, '0')}-${birthdate.day.toString().padLeft(2, '0')}",
        "password": password,
        "role_id": roleId,
        //"remember_token": rememberToken,
        "name": roleName,
      };
}
