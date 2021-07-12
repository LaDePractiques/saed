import 'dart:convert';

class Audit {
  String id;
  String shipName;
  String userName;
  String dateStart;
  String time;
  String checklist;

  Audit(
      {this.id,
      this.shipName,
      this.userName,
      this.dateStart,
      this.time,
      this.checklist});

  get getId => id;
  get getShipId => shipName;
  get getUserId => userName;
  get getTime => time;
  get getDateStart => dateStart;
  get getChecklist => checklist;

  factory Audit.fromRawJson(String str) => Audit.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Audit.fromJson(Map<String, dynamic> json) => Audit(
        id: json["id"],
        shipName: json["ship_name"],
        userName: json["user_name"],
        dateStart: json["date_start"],
        time: json["time"],
        checklist: json["checklist"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ship_name": shipName,
        "user_name": userName,
        "date_start": dateStart,
        "time": time,
        "checklist": checklist,
      };
}
