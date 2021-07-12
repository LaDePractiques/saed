import 'package:revisiones_spm/models/audit.dart';
import 'package:revisiones_spm/common.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuditService {
  //services db

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

  // add Audit to the db
  static Future<String> addAudit(String ownerDni, String identification,
      String name, String country) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = ADD_AUDIT_ACTION;
      map['owner_dni'] = ownerDni.toUpperCase();
      map['identification'] = identification.toUpperCase();
      map['name'] = name.toUpperCase();
      map['country'] = country.toUpperCase();
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
