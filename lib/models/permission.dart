import 'dart:convert';

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

class PermissionsList {
  PermissionsList({
    //this.id,
    this.name,
  });

  //String id;
  String name;

  factory PermissionsList.fromRawJson(String str) =>
      PermissionsList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PermissionsList.fromJson(Map<String, dynamic> json) =>
      PermissionsList(
        //id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        //"id": id,
        "name": name,
      };
}
