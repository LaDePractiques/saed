import 'package:cloud_firestore/cloud_firestore.dart';

class Audit {
  int id;
  String shipId;
  int userId;
  DateTime date;
  Timestamp time;
  DateTime dateStop;
  String checklistId;
  DateTime dateStart;
  DateTime dateEnd;

  Audit(
      {this.id,
      this.shipId,
      this.userId,
      this.date,
      this.time,
      this.dateStop,
      this.checklistId,
      this.dateStart,
      this.dateEnd});

  get getId => id;
  get getShipId => shipId;
  get getUserId => userId;
  get getDate => date;
  get getTime => time;
  get getDateStop => dateStop;
  get getChecklistId => checklistId;
  get getDateStart => dateStart;
  get getDateEnd => dateEnd;
}
