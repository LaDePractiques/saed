import 'dart:convert';

class Checklist {
  String id;
  String name;

  Checklist({
    this.id,
    this.name,
  });

  get getId => id;
  get getName => name;

  factory Checklist.fromRawJson(String str) =>
      Checklist.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Checklist.fromJson(Map<String, dynamic> json) => Checklist(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
