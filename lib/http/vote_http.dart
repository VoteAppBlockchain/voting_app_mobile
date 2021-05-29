import 'dart:convert';

import 'package:http/http.dart' as http;

class VoteHttp {

  /// Fetches candidates
  ///
  /// @returns Candidate list with hex values
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

  /// Returns voter information and hex value
  ///
  /// @param idNumber - String Identity number of the voter
  /// @param password - String Password of the voter
  /// @returns JSON object
  Future<List<dynamic>> login(String idNumber, String password) async {
    http.Response response = await http.post(
        Uri.http("10.0.2.2:8082", "/login"),
        headers: {"Content-type": "application/json"},
        body: jsonEncode(<String, String>{
          "id_number": idNumber,
          "password": password
        })
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw new Exception("Unsuccessful login");
    }
  }
}
