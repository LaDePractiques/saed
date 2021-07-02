// To parse this JSON data, do
//
//     final permission = permissionFromJson(jsonString);

import 'dart:convert';

class Permission {
  Permission({
    this.id,
    this.name,
    this.permissionsList,
  });

  String id;
  String name;
  List<PermissionsList> permissionsList;

  factory Permission.fromRawJson(String str) =>
      Permission.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Permission.fromJson(Map<String, dynamic> json) => Permission(
        id: json["id"],
        name: json["name"],
        permissionsList: List<PermissionsList>.from(
            json["permissions_list"].map((x) => PermissionsList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "permissions_list":
            List<dynamic>.from(permissionsList.map((x) => x.toJson())),
      };
}

class PermissionsList {
  PermissionsList({
    this.id,
    this.name,
  });

  String id;
  String name;

  factory PermissionsList.fromRawJson(String str) =>
      PermissionsList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PermissionsList.fromJson(Map<String, dynamic> json) =>
      PermissionsList(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
