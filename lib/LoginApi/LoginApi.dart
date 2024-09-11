// ignore_for_file: prefer_interpolation_to_compose_strings, unnecessary_new, non_constant_identifier_names, unnecessary_string_interpolations, unused_local_variable, avoid_print

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:tvc_all/LoginApi/Url.dart';
import 'package:tvc_all/LoginApi/config.dart';
import 'package:tvc_all/LoginApi/constantvalues.dart';
import 'package:tvc_all/LoginApi/encriypted.dart';
import 'package:tvc_all/LoginApi/loginmodel.dart';
// import 'package:sellerkit/Constant/Encripted.dart';

// import '../URL/LocalUrl.dart';

class LoginAPi {
  static Future<LoginModel> getData(PostLoginData postLoginData) async {
    int resCode = 500;
    log('Uri.parse("${Url.queryApi}WareSmart/v1/MobileLogin"');
    try {
// curl --location '91.203.133.224:92/api/WareSmart/v1/MobileLogin' \
      final response = await http.post(
          Uri.parse("http://91.203.133.224:92/api/WareSmart/v1/MobileLogin"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "tenantId": "${ConstantValues.tenetID.toString().trim()}",
            "userCode": "${postLoginData.username.toString().trim()}",
            "password": "${postLoginData.password.toString().trim()}",
            "deviceCode": "${postLoginData.deviceCode}",
            "fcmToken": "${postLoginData.fcmToken}",
            "ip": ConstantValues.ipaddress,
            "ssid": ConstantValues.ipname,
            "lattitude": ConstantValues.latitude == 'null' ||
                    ConstantValues.latitude == ''
                ? 0.0
                : double.parse(ConstantValues.latitude.toString()),
            "longitude": ConstantValues.langtitude == 'null' ||
                    ConstantValues.langtitude == ''
                ? 0.0
                : double.parse(ConstantValues.langtitude.toString())
          }));
      print("Login Req Body::" +
          jsonEncode({
            "tenantId": "${ConstantValues.tenetID.toString().trim()}",
            "userCode": "${postLoginData.username.toString().trim()}",
            "password": "${postLoginData.password.toString().trim()}",
            "deviceCode": "${postLoginData.deviceCode}",
            "fcmToken": "${postLoginData.fcmToken}",
            "ip": ConstantValues.ipaddress,
            "ssid": ConstantValues.ipname,
            "lattitude": ConstantValues.latitude == 'null' ||
                    ConstantValues.latitude == ''
                ? 0.0
                : double.parse(ConstantValues.latitude.toString()),
            "longitude": ConstantValues.langtitude == 'null' ||
                    ConstantValues.langtitude == ''
                ? 0.0
                : double.parse(ConstantValues.langtitude.toString())
          }).toString());

      // log("ADADADDAD" + "${response.statusCode.toString()}");
      log("bodylogin::" + "${response.body}");

      resCode = response.statusCode;
      if (response.statusCode == 200) {
        //

        Config config = new Config();
        Map<String, dynamic> jres = config.parseJwt("${response.body}");
        log("ABCD7333:::" + jres.toString());
        Map<String, dynamic> jres22 = json.decode(response.body);
        ConstantValues.token = "${jres22['data']}";
        EncryptData Encrupt = new EncryptData();
        String? testData2 = Encrupt.decrypt(jres['encryptedClaims']);

        Map<String, dynamic> jres2 = jsonDecode("${testData2}");
        log("jres2:::" + jres2.toString());

        return LoginModel.fromJson(jres2, response.statusCode);
      } else if (response.statusCode >= 400 && response.statusCode <= 410) {
        print("Error: error");
        return LoginModel.issue(
            response.statusCode, json.decode(response.body));
      } else {
        log("APIERRor::" + json.decode(response.body).toString());
        return LoginModel.issue(resCode, json.decode(response.body));
      }
    } catch (e) {
      print("Catch:" + e.toString());
      return LoginModel.error(resCode, "${e}+${Url.queryApi}");
    }
  }
}

// body: jsonEncode({
//             "deviceCode": "${postLoginData.deviceCode}",
//             "userName":"${postLoginData.username}",
//             "password": postLoginData.password.toString().isEmpty || postLoginData.password == null?"null":"${postLoginData.password}",
//             "licenseKey":postLoginData.licenseKey.toString().isEmpty  || postLoginData.licenseKey == null?"null": "${postLoginData.licenseKey}",
//            "fcmToken":"${postLoginData.fcmToken}"
//           }));
