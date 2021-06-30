import 'package:revisiones_spm/models/user.dart';
import 'package:revisiones_spm/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  //services db
  static Future<List<User>> getUsers() async {
    List<User> list = [];
    try {
      var map = Map<String, dynamic>();
      map['action'] = GET_ALL_USERS_ACTION;
      final response = await http.post(ROOT_USER_ACTION, body: map);
      //print('getUsers Response: ${response.body}');
      if (200 == response.statusCode) {
        final jsonresponse = json.decode(response.body);
        print(jsonresponse);
        List<User> usersList =
            List<User>.from(jsonresponse.map((j) => User.fromJson(j)));
        return usersList;
      } else {
        return list;
      }
    } catch (e) {
      print('error: $e');
      return list;
    }
  }

  // add User to the db
  static Future<String> addUser(String firstName, String lastName) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = ADD_USER_ACTION;
      map['first_name'] = firstName;
      map['last_name'] = lastName;
      final response = await http.post(ROOT_USER_ACTION, body: map);
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
      String userId, String firstName, String lastName) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = UPDATE_USER_ACTION;
      map['id'] = userId;
      map['first_name'] = firstName;
      map['last_name'] = lastName;
      final response = await http.post(ROOT_USER_ACTION, body: map);
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
  static Future<String> deleteUser(String userId) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = DELETE_USER_ACTION;
      map['id'] = userId;
      final response = await http.post(ROOT_USER_ACTION, body: map);
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
