// ignore_for_file: file_names
//**13/09/2022 */
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tvc_all/models/outward%20model/outwardmodel.dart';

class GetSaleDataAPi {
  static Future<SaleOrderDeatils> getData() async {
    //print(deviceID);
    try {
      // print("http://202.65.131.32:15674/api/OpenOrder");
      final response = await http.get(
        Uri.parse("http://202.65.131.32:15674/api/OpenOrder"),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        // print(json.decode(response.body));
        return SaleOrderDeatils.fromJson(json.decode(response.body),
            response.statusCode); //as Map<String, dynamic>
      } else {
        // throw Exception("Error");
        return SaleOrderDeatils.issue(response.statusCode);
      }
    } catch (e) {
      // throw Exception(e.toString());
      return SaleOrderDeatils.issue(500);
    }
  }
}
