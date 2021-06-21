import 'dart:convert';
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';

List<User> modelUserFromJson(String str) =>
    List<User>.from(json.decode(json.encode(str)).map((x) => User.fromJson(x)));

//String modelUserToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  String firstName;
  String lastName;
  String email;
  String dni;
  String direction;
  String city;
  int id;
  String stripeId;
  DateTime birthdate;
  int roleId;
  Timestamp emailVerifiedAt;
  String password;
  Timestamp createdAt;
  Timestamp updateAt;
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
  String get getEmail {
    return this.email;
  }

  String get getDni => dni;
  String get getAddress => direction;
  String get getCountry => city;
  int get getId => id;
  String get getStripeId => stripeId;
  DateTime get getBirthdate => birthdate;
  int get getRoleId => roleId;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      emailVerifiedAt: json['email_verified_ad'] as Timestamp,
      dni: json['dni'] as String,
      direction: json['direction'] as String,
      city: json['city'] as String,
      birthdate: json['birthdate'] as DateTime,
      password: json['password'] as String,
      roleId: json['role_id'] as int,
      rememberToken: json['remember_token'] as String,
      createdAt: json['created_at'] as Timestamp,
      updateAt: json['update_at'] as Timestamp,
    );
  }
}
