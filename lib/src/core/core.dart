import 'dart:convert';

import 'package:assignment/src/config/constants.dart';
import 'package:http/http.dart' as http;

class Core {
  Future<dynamic> requestGET(
      {required String path, Map<String, Object> parameters = const {}}) async {
    final uri = Uri.https(Constants.host, "${Constants.api}/$path", parameters);

    final results = await http.get(uri, headers: _headers);
    return (results.statusCode == 200 || results.statusCode == 201)
        ? jsonDecode(results.body)
        : throw Exception();
  }

  Future<dynamic> requestPOST(
      {required String path, Map<String, Object> parameters = const {}}) async {
    final uri = Uri.https(Constants.host, "${Constants.api}/$path");

    final results = await http.post(uri, headers: _headers, body: parameters);
    return (results.statusCode == 200 || results.statusCode == 201)
        ? jsonDecode(results.body)
        : throw Exception();
  }

  Map<String, String> get _headers => {'Accept': 'application/json'};
}
