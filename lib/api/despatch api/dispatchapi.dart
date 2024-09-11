import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tvc_all/models/despatch%20model/opendespatch.dart';

class GetDespatchDataAPi {
  static Future<DespatchDetails> getData() async {
    //print(deviceID);
    try {
      // print("http://202.65.131.32:15674/api/OpenOrder");
      final response = await http.get(
        Uri.parse("http://91.203.133.224:92/api/WareSmart"),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        // print(json.decode(response.body));
        return DespatchDetails.fromJson(json.decode(response.body),
            response.statusCode); //as Map<String, dynamic>
      } else {
        // throw Exception("Error");
        return DespatchDetails.issue(response.statusCode);
      }
    } catch (e) {
      // throw Exception(e.toString());
      return DespatchDetails.issue(500);
    }
  }
}
