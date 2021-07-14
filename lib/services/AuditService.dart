import 'package:revisiones_spm/models/audit.dart';
import 'package:revisiones_spm/common.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:revisiones_spm/models/checklist.dart';

class AuditService {
  //services db
  //All audits
  static Future<List<Audit>> getAllAudits() async {
    List<Audit> list = [];
    try {
      var map = Map<String, dynamic>();
      map['action'] = GET_ALL_AUDITS_ACTION;
      final response = await http.post(ROOT_AUDIT_ACTION, body: map);
      print('getAudits Response: ${response.body}');
      if (200 == response.statusCode) {
        final jsonresponse = json.decode(response.body);
        print(jsonresponse);
        List<Audit> auditList =
            List<Audit>.from(jsonresponse.map((j) => Audit.fromJson(j)));
        return auditList;
      } else {
        return list;
      }
    } catch (e) {
      print('error: $e');
      return list;
    }
  }

  //My audits
  static Future<List<Audit>> getUserAudits() async {
    List<Audit> list = [];
    try {
      var map = Map<String, dynamic>();
      map['action'] = GET_ALL_MYAUDITS_ACTION;
      map['user_id'] = currentUser.id;
      final response = await http.post(ROOT_AUDIT_ACTION, body: map);
      print('getAudits Response: ${response.body}');
      if (200 == response.statusCode) {
        final jsonresponse = json.decode(response.body);
        print(jsonresponse);
        List<Audit> auditList =
            List<Audit>.from(jsonresponse.map((j) => Audit.fromJson(j)));
        return auditList;
      } else {
        return list;
      }
    } catch (e) {
      print('error: $e');
      return list;
    }
  }

  //All checklist
  static Future<List<Checklist>> getChecklist() async {
    List<Checklist> list = [];
    try {
      var map = Map<String, dynamic>();
      map['action'] = GET_ALL_CHECKLIST_NAME_ACTION;
      final response = await http.post(ROOT_AUDIT_ACTION, body: map);
      print('getAudits Response: ${response.body}');
      if (200 == response.statusCode) {
        final jsonresponse = json.decode(response.body);
        print(jsonresponse);
        List<Checklist> checklist = List<Checklist>.from(
            jsonresponse.map((j) => Checklist.fromJson(j)));
        return checklist;
      } else {
        return list;
      }
    } catch (e) {
      print('error: $e');
      return list;
    }
  }

  // add Audit to the db
  static Future<String> addAudit(
      String shipName,
      String auditorName,
      String auditorLastname,
      String time,
      String checklist,
      String dateStart) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = ADD_AUDIT_ACTION;
      map['ship_name'] = shipName.toUpperCase();
      map['auditor_name'] = auditorName.toUpperCase();
      map['auditor_lastname'] = auditorLastname.toUpperCase();
      map['time'] = time;
      map['checklist'] = checklist.toUpperCase();
      map['date_start'] = dateStart;
      final response = await http.post(ROOT_AUDIT_ACTION, body: map);
      print('addAudit Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  // update an Audit in Db
  static Future<String> updateAudit(String auditId, String ownerDni,
      String identification, String name, String country) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = UPDATE_AUDIT_ACTION;
      map['id'] = auditId;
      map['owner_dni'] = ownerDni;
      map['identification'] = identification;
      map['name'] = name;
      map['country'] = country;
      final response = await http.post(ROOT_AUDIT_ACTION, body: map);
      print('updateAudit Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  // Delete an Audit from Db
  static Future<String> deleteAudit(String auditId) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = DELETE_AUDIT_ACTION;
      map['id'] = auditId;
      final response = await http.post(ROOT_AUDIT_ACTION, body: map);
      print('deleteAudit Response: ${response.body}');
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
