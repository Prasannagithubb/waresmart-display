// ignore_for_file: file_names
//**13/09/2022 */
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../open po/openpo model/OrderModel.dart';

class GetDataAPi {
  static Future<OrderDeatils> getData() async {
    //print(deviceID);
    try {
      // print("http://202.65.131.32:15674/api/OpenOrder");
      final response = await http.get(
        Uri.parse("http://202.65.131.32:15674/api/OpenOrder"),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        // print(json.decode(response.body));
        return OrderDeatils.fromJson(json.decode(response.body),
            response.statusCode); //as Map<String, dynamic>
      } else {
        // throw Exception("Error");
        return OrderDeatils.issue(response.statusCode);
      }
    } catch (e) {
      // throw Exception(e.toString());
      return OrderDeatils.issue(500);
    }
  }
}
