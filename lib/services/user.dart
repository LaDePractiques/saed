import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:revisiones_spm/models/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  //script php
  static const ROOT = 'http://10.0.2.2/revisiones_spmaritim/user_actions.php';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _ADD_USER_ACTION = 'ADD_USER';
  static const _UPDATE_USER_ACTION = 'UPDATE_USER';
  static const _DELETE_USER_ACTION = 'DELETE_USER';

  //services db
  static Future<List<User>> getUsers() async {
    List<User> list = [];
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      final response = await http.post(ROOT, body: map);
      print('getUsers Response: ${response.body}');
      if (200 == response.statusCode) {
        final data = jsonDecode(response.body);
        for (Map item in data) {
          list.add(User.fromJson(item));
        }
        //list = parseResponse(response.body);
        return list;
      } else {
        return list;
      }
    } catch (e) {
      print('error: $e');
      return list;
    }
  }

  static List<User> parseResponse(String responseBody) {
    final parsed =
        jsonDecode(json.encode(responseBody)); //.cast<Map<String, dynamic>>();

    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

  // add User to the db
  static Future<String> addUser(String firstName, String lastName) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_USER_ACTION;
      map['first_name'] = firstName;
      map['last_name'] = lastName;
      final response = await http.post(ROOT, body: map);
      print('addUser Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  // update an User in Db
  static Future<String> updateUser(
      int userId, String firstName, String lastName) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_USER_ACTION;
      map['id'] = userId;
      map['first_name'] = firstName;
      map['last_name'] = lastName;
      final response = await http.post(ROOT, body: map);
      print('updateUser Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  // Delete an User from Db
  static Future<String> deleteUser(int userId) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_USER_ACTION;
      map['id'] = userId;
      final response = await http.post(ROOT, body: map);
      print('deleteUser Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }
}
