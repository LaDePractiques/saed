import 'dart:convert';

class Ship {
  Ship({
    this.id,
    this.ownerName,
    this.ownerLastName,
    this.identification,
    this.shipName,
    this.country,
  });

  String id;
  String ownerName;
  String ownerLastName;
  String identification;
  String shipName;
  String country;

  factory Ship.fromRawJson(String str) => Ship.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Ship.fromJson(Map<String, dynamic> json) => Ship(
        id: json["id"],
        ownerName: json["first_name"],
        ownerLastName: json["last_name"],
        identification: json["identification"],
        shipName: json["shipname"],
        country: json["countryname"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": ownerName,
        "last_name": ownerLastName,
        "identification": identification,
        "shipname": shipName,
        "countryname": country,
      };
}
