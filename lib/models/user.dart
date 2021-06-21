import 'dart:convert';
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';

List<User> modelUserFromJson(String str) =>
    List<User>.from(json.decode(json.encode(str)).map((x) => User.fromJson(x)));

//String modelUserToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  static const FIRST_NAME = 'FirstName';
  static const LAST_NAME = 'LastName';
  static const EMAIL = "email";
  static const DNI = 'dni';
  static const DIRECTION = 'direction';
  static const CITY = 'city';
  static const ID = 'id';
  static const STRIPE_ID = 'stripeId';

  String firstName;
  String lastName;
  String email;
  String dni;
  String direction;
  String city;
  String id;
  String stripeId;
  String birthdate;
  String roleId;
  String emailVerifiedAt;
  String password;
  String createdAt;
  String updateAt;
  String rememberToken;

  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.emailVerifiedAt,
      this.dni,
      this.direction,
      this.city,
      this.birthdate,
      this.password,
      this.roleId,
      this.rememberToken,
      this.createdAt,
      this.updateAt});

//  GETTERS
  String get getFirstName => firstName;
  String get getLastName => lastName;
  String get getEmail => email;
  String get getDni => dni;
  String get getAddress => direction;
  String get getCountry => city;
  String get getId => id;
  String get getStripeId => stripeId;
  String get getBirthdate => birthdate;
  String get getRoleId => roleId;

  User.fromSnapshot(DocumentSnapshot snap) {
    lastName = snap.data[LAST_NAME];
    firstName = snap.data[FIRST_NAME];
    email = snap.data[EMAIL];
    dni = snap.data[DNI];
    direction = snap.data[DIRECTION];
    city = snap.data[CITY];
    id = snap.data[ID];
    stripeId = snap[STRIPE_ID];
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      emailVerifiedAt: json['email_verified_ad'] as String,
      dni: json['dni'] as String,
      direction: json['direction'] as String,
      city: json['city'] as String,
      birthdate: json['birthdate'] as String,
      password: json['password'] as String,
      roleId: json['role_id'],
      rememberToken: json['remember_token'] as String,
      createdAt: json['created_at'] as String,
      updateAt: json['update_at'] as String,
    );
  }

  /*Map<String, dynamic> toJson() => {
        "id": id,
        "Records": List<dynamic>.from(records.map((x) => x.toJson())),
        "Result": result,
    };*/
}
