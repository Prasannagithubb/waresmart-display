// ignore_for_file: unnecessary_new, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:tvc_all/LoginApi/GetUrlModel.dart';

class GetURLApi {
  static Future<GetUrlModel> getData(String? CustomerId) async {
// await config.getSetup();
    print("Api CustomerId::" + CustomerId.toString());
    int resCode = 500;
    try {
      print(
          'Get Url Api::http://164.52.217.188:81/api/PortalAuthenticate/RegisterUser?TenantId=$CustomerId');
      final response = await http.get(
        Uri.parse(
            'http://91.203.133.224:92/api/WareSmart/v1/GetCustomerUrl?TenantId=$CustomerId'),
        headers: {"Content-Type": "application/json"},
      );
      print("get url body::" + response.body.toString());
      print("Status Code::" + response.statusCode.toString());
      resCode = response.statusCode;

      if (response.statusCode == 200) {
        // print("Error: ${response.body}");
        return GetUrlModel.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        // print("Error: ${response.body}");
        return GetUrlModel.error('Error', response.statusCode);
      }
    } catch (e) {
      log("Exceptionhiiii: " + e.toString());
      return GetUrlModel.error(e.toString(), resCode);
    }
  }
}
