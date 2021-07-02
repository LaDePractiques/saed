import 'package:flutter/src/widgets/editable_text.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:revisiones_spm/models/ship.dart';
import 'package:revisiones_spm/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ShipService {
  //services db
  //Role: admin
  static Future<List<Ship>> getAllShips() async {
    List<Ship> list = [];
    try {
      var map = Map<String, dynamic>();
      map['action'] = GET_ALL_SHIPS_ACTION;
      final response = await http.post(ROOT_SHIP_ACTION, body: map);
      print('getShips Response: ${response.body}');
      if (200 == response.statusCode) {
        final jsonresponse = json.decode(response.body);
        print(jsonresponse);
        List<Ship> shipsList =
            List<Ship>.from(jsonresponse.map((j) => Ship.fromJson(j)));
        return shipsList;
      } else {
        return list;
      }
    } catch (e) {
      print('error: $e');
      return list;
    }
  }

  //Role: client
  static Future<List<Ship>> getUserShips() async {
    List<Ship> list = [];
    try {
      var map = Map<String, dynamic>();
      map['action'] = GET_ALL_SHIPS_OF_USER_ACTION;
      map['user_id'] = currentUser.id;
      final response = await http.post(ROOT_SHIP_ACTION, body: map);
      print('getShips Response: ${response.body}');
      if (200 == response.statusCode) {
        final jsonresponse = json.decode(response.body);
        print(jsonresponse);
        List<Ship> shipsList =
            List<Ship>.from(jsonresponse.map((j) => Ship.fromJson(j)));
        return shipsList;
      } else {
        return list;
      }
    } catch (e) {
      print('error: $e');
      return list;
    }
  }

  // add Ship to the db
  static Future<String> addShip(String ownerDni, String identification,
      String name, String country) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = ADD_SHIP_ACTION;
      map['owner_dni'] = ownerDni.toUpperCase();
      map['identification'] = identification.toUpperCase();
      map['name'] = name.toUpperCase();
      map['country'] = country.toUpperCase();
      final response = await http.post(ROOT_SHIP_ACTION, body: map);
      print('addShip Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  // update an Ship in Db
  static Future<String> updateShip(String shipId, String ownerDni,
      String identification, String name, String country) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = UPDATE_SHIP_ACTION;
      map['id'] = shipId;
      map['owner_dni'] = ownerDni;
      map['identification'] = identification;
      map['name'] = name;
      map['country'] = country;
      final response = await http.post(ROOT_SHIP_ACTION, body: map);
      print('updateShip Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  // Delete an Ship from Db
  static Future<String> deleteShip(String shipId) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = DELETE_SHIP_ACTION;
      map['id'] = shipId;
      final response = await http.post(ROOT_SHIP_ACTION, body: map);
      print('deleteShip Response: ${response.body}');
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
