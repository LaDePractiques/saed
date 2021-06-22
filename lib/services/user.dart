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
      int userId, String firstName, String lastName) async {
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
  static Future<String> deleteUser(int userId) async {
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
