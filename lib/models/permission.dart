import 'dart:convert';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:revisiones_spm/services/PermissionService.dart';

class Role {
  Role({
    this.id,
    this.name,
    this.permissionsList,
    this.isExpanded = false,
  });

  String id;
  String name;
  List permissionsList;
  bool isExpanded;

  List genenrateList() {
    PermissionService.getAllPermissions(id).then((permissions) {
      if (permissions.length != null) {
        for (var i = 0; i < permissions.length; i++) {
          permissionsList.add(permissions[i].name);
        }
      }
    });
    return permissionsList;
  }

  factory Role.fromRawJson(String str) => Role.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Permission {
  Permission({
    this.id,
    this.name,
    this.isExpanded = false,
  });

  String id;
  String name;
  bool isExpanded;

  factory Permission.fromRawJson(String str) =>
      Permission.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Permission.fromJson(Map<String, dynamic> json) => Permission(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class PermissionList {
  final List<Permission> permissions;

  PermissionList({
    this.permissions,
  });

  factory PermissionList.fromJson(List<dynamic> parsedJson) {
    List<Permission> permissions =
        parsedJson.map((i) => Permission.fromJson(i)).toList();

    return new PermissionList(permissions: permissions);
  }
}
