import 'dart:convert';

class Ship {
  Ship({
    this.id,
    this.ownerId,
    this.identification,
    this.name,
    this.countryId,
  });

  String id;
  String ownerId;
  String identification;
  String name;
  String countryId;

  factory Ship.fromRawJson(String str) => Ship.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Ship.fromJson(Map<String, dynamic> json) => Ship(
        id: json["id"],
        ownerId: json["owner_id"],
        identification: json["identification"],
        name: json["name"],
        countryId: json["country_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "owner_id": ownerId,
        "identification": identification,
        "name": name,
        "country_id": countryId,
      };
}
