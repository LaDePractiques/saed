import 'package:revisiones_spm/models/permission.dart';
import 'package:revisiones_spm/common.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PermissionService {
  //services db
  //Role: admin

  static Future<List<Role>> getAllRoles() async {
    List<Role> list = [];
    try {
      var map = Map<String, dynamic>();
      map['action'] = GET_ALL_ROLES_ACTION;
      final response = await http.post(ROOT_PERMISSION_ACTION, body: map);
      print('getRoles Response: ${response.body}');
      if (200 == response.statusCode) {
        final jsonresponse = json.decode(response.body);
        print(jsonresponse);
        List<Role> permissionsList =
            List<Role>.from(jsonresponse.map((j) => Role.fromJson(j)));
        return permissionsList;
      } else {
        return list;
      }
    } catch (e) {
      print('error: $e');
      return list;
    }
  }

  static Future<List> getAllPermissions(String role) async {
    List<String> list = [];
    try {
      var map = Map<String, dynamic>();
      map['action'] = GET_PERMISSIONS;
      map['id'] = role;
      final response = await http.post(ROOT_PERMISSION_ACTION, body: map);
      print('getPermissions Response: ${response.body}');
      if (200 == response.statusCode) {
        final jsonresponse = json.decode(response.body);
        print(jsonresponse);
        PermissionList permissionList = PermissionList.fromJson(jsonresponse);
        for (var item in permissionList.permissions) {
          list.add(item.name);
        }
        return list;
      } else {
        return list;
      }
    } catch (e) {
      print('error: $e');
      return list;
    }
  }
}
