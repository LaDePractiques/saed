import 'package:revisiones_spm/models/permission.dart';
import 'package:revisiones_spm/common.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PermissionService {
  //services db
  //Role: admin
  static Future<List<Permission>> getAllRoles() async {
    List<Permission> list = [];
    try {
      var map = Map<String, dynamic>();
      map['action'] = GET_ALL_ROLES_ACTION;
      final response = await http.post(ROOT_PERMISSION_ACTION, body: map);
      print('getRoles Response: ${response.body}');
      if (200 == response.statusCode) {
        final jsonresponse = json.decode(response.body);
        print(jsonresponse);
        List<Permission> permissionsList = List<Permission>.from(
            jsonresponse.map((j) => Permission.fromJson(j)));
        return permissionsList;
      } else {
        return list;
      }
    } catch (e) {
      print('error: $e');
      return list;
    }
  }

  static Future<List<PermissionsList>> getAllPermissions(String role) async {
    List<PermissionsList> list = [];
    try {
      var map = Map<String, dynamic>();
      map['action'] = GET_ALL_PERMISSIONS_OF_ROLES;
      map['id'] = role;
      final response = await http.post(ROOT_PERMISSION_ACTION, body: map);
      print('getPermissions Response: ${response.body}');
      if (200 == response.statusCode) {
        final jsonresponse = json.decode(response.body);
        print(jsonresponse);
        List<PermissionsList> permissionsList = List<PermissionsList>.from(
            jsonresponse.map((j) => PermissionsList.fromJson(j)));
        return permissionsList;
      } else {
        return list;
      }
    } catch (e) {
      print('error: $e');
      return list;
    }
  }

  //Role: client
  static Future<List<Permission>> getUserPermissions() async {
    List<Permission> list = [];
    try {
      var map = Map<String, dynamic>();
      map['action'] = GET_ALL_PERMISSIONS_OF_USER_ACTION;
      map['user_id'] = currentUser.id;
      final response = await http.post(ROOT_PERMISSION_ACTION, body: map);
      print('getPermissions Response: ${response.body}');
      if (200 == response.statusCode) {
        final jsonresponse = json.decode(response.body);
        print(jsonresponse);
        List<Permission> permissionsList = List<Permission>.from(
            jsonresponse.map((j) => Permission.fromJson(j)));
        return permissionsList;
      } else {
        return list;
      }
    } catch (e) {
      print('error: $e');
      return list;
    }
  }

  // add Permission to the db
  static Future<String> addPermission(String ownerDni, String identification,
      String name, String country) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = ADD_PERMISSION_ACTION;
      map['owner_dni'] = ownerDni.toUpperCase();
      map['identification'] = identification.toUpperCase();
      map['name'] = name.toUpperCase();
      map['country'] = country.toUpperCase();
      final response = await http.post(ROOT_PERMISSION_ACTION, body: map);
      print('addPermission Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  // update an Permission in Db
  static Future<String> updatePermission(String permissionId, String ownerDni,
      String identification, String name, String country) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = UPDATE_PERMISSION_ACTION;
      map['id'] = permissionId;
      map['owner_dni'] = ownerDni;
      map['identification'] = identification;
      map['name'] = name;
      map['country'] = country;
      final response = await http.post(ROOT_PERMISSION_ACTION, body: map);
      print('updatePermission Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  // Delete an Permission from Db
  static Future<String> deletePermission(String permissionId) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = DELETE_PERMISSION_ACTION;
      map['id'] = permissionId;
      final response = await http.post(ROOT_PERMISSION_ACTION, body: map);
      print('deletePermission Response: ${response.body}');
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
