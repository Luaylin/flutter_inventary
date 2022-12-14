import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_inventary/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map> sendPostHTTPRequest(String url, String token, Map data) async {
  await storage.ready;
  try {
    var response =
        await http.post(Uri.parse(dotenv.env['API_INVENTARY']! + url),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer ${storage.getItem("token")}'
            },
            body: json.encode(data));
    if (response.statusCode == 201 || response.statusCode == 200) {
      return {"status": true, "data": json.decode(response.body)};
    } else {
      return {"status": false, "data": json.decode(response.body)};
    }
  } catch (e) {
    return {"status": false, "data": {}};
  }
}

Future<Map> sendGetHTTPRequest(String url, String token) async {
  await storage.ready;
  try {
    var response = await http.get(Uri.parse(dotenv.env['API_INVENTARY']! + url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${storage.getItem("token")}'
        });
    if (response.statusCode == 201 || response.statusCode == 200) {
      return {"status": true, "data": json.decode(response.body)};
    } else {
      return {"status": false, "data": json.decode(response.body)};
    }
  } catch (e) {
    return {"status": false, "data": {}};
  }
}

Future<Map> sendPutHTTPRequest(String url, String token, Map data) async {
  await storage.ready;
  try {
    var response = await http.put(Uri.parse(dotenv.env['API_INVENTARY']! + url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${storage.getItem("token")}'
        },
        body: json.encode(data));
    if (response.statusCode == 201 || response.statusCode == 200) {
      return {"status": true, "data": response.body};
    } else {
      return {"status": false, "data": response.body};
    }
  } catch (e) {
    return {"status": false, "data": {}};
  }
}

Future<Map> sendDeleteHTTPRequest(String url, String token, Map data) async {
  await storage.ready;
  try {
    var response =
        await http.delete(Uri.parse(dotenv.env['API_INVENTARY']! + url),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer ${storage.getItem("token")}'
            },
            body: json.encode(data));
    if (response.statusCode == 201 || response.statusCode == 200) {
      return {"status": true, "data": response.body};
    } else {
      return {"status": false, "data": response.body};
    }
  } catch (e) {
    return {"status": false, "data": {}};
  }
}
