import 'dart:convert';

import 'package:http/http.dart' as http;

class VoteHttp {
  Future<Map<String, dynamic>> getCandidates() async {
    http.Response response = await http.get(
      Uri.http("10.0.2.2:8082", "/candidates")
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)["candidates"];
    } else {
      throw new Exception("Error in candidates");
    }
  }
}
