// ignore_for_file: file_names
//**13/09/2022 */
import 'dart:convert';
import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;
import 'package:tvc_all/LoginApi/Url.dart';
import 'package:tvc_all/LoginApi/constantvalues.dart';
import 'package:tvc_all/models/despatch%20model/opendespatch.dart';

class GetdespatchfileApi {
  static Future<DespatchModelApi> getdata() async {
    final AudioPlayer audioPlayer = AudioPlayer();
    int resCode = 500;

    try {
      log("ConstantValues.token::${Url.queryApi}${ConstantValues.token}");
      final response = await http.get(
          Uri.parse(
              "${Url.queryApi}WareSmart/v1/GetTvDisplayOpenDespatch/W001"),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ${ConstantValues.token}',
          });
      resCode = response.statusCode;
      log("rescode::${response.statusCode}");
      // log("Textresponse::" + response.body.toString());
      if (response.statusCode == 200) {
        await audioPlayer
            .play(AssetSource('lib/Assets/simple-notification-152054.mp3'));
        return DespatchModelApi.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        return DespatchModelApi.issues(
            json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      log("INWres::$e");
      return
//  "";
          DespatchModelApi.error(e.toString(), resCode);
    }
  }
}



//   static List<Map<String, dynamic>> jsonconvertexample(String tabularData) {
//     List<String> lines = tabularData.split('\n');
//     List<String> headers = lines[0].split('\t');

//     List<Map<String, dynamic>> jsonList = [];

//     for (int i = 1; i < lines.length; i++) {
//       List<String> values = lines[i].split('\t');
//       if (values.length == headers.length) {
//         Map<String, dynamic> jsonItem = {};
//         for (int j = 0; j < headers.length; j++) {
//           jsonItem[headers[j]] = values[j].contains('.')
//               ? double.tryParse(values[j]) ?? values[j]
//               : values[j];
//         }
//         jsonList.add(jsonItem);
//       }
//     }
//     // log("jsonList::"+jsonList.toString());
//     return jsonList;
//   }
// }