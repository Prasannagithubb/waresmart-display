import 'dart:convert';
import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;
import 'package:tvc_all/LoginApi/Url.dart';
import 'package:tvc_all/LoginApi/constantvalues.dart';
import 'package:tvc_all/models/binmatrix%20model/binmatrix.dart';

class GetBinmatrixApi {
  static Future<BinMAtrixModel> getdata() async {
    final AudioPlayer audioPlayer = AudioPlayer();
    int resCode = 500;
    try {
      log("ConstantValues.token::${ConstantValues.token}");
      final response = await http.get(
          Uri.parse("${Url.queryApi}WareSmart/v1/GetTvDisplayBinMatrix/W001"),
          headers: {
            "content-type": "application/json ",
            "Authorization": 'bearer ${ConstantValues.token}',
          });
      resCode = response.statusCode;
      // log("rescode::"+response.statusCode.toString());
      log("Textresponse::${response.body}");

      if (response.statusCode == 200) {
        await audioPlayer
            .play(AssetSource('lib/Assets/simple-notification-152054.mp3'));
        return BinMAtrixModel.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        return BinMAtrixModel.issue(
            json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      log("INWres::$e");
      return
//  "";
          BinMAtrixModel.error(e.toString(), resCode);
    }
  }

  // static List<Map<String, dynamic>> jsonconvertexample(String tabularData) {
  //   List<String> lines = tabularData.split('\n');
  //   List<String> headers = lines[0].split('\t');

  //   List<Map<String, dynamic>> jsonList = [];

  //   for (int i = 1; i < lines.length; i++) {
  //     List<String> values = lines[i].split('\t');
  //     if (values.length == headers.length) {
  //       Map<String, dynamic> jsonItem = {};
  //       for (int j = 0; j < headers.length; j++) {
  //         jsonItem[headers[j]] = values[j].contains('.')
  //             ? double.tryParse(values[j]) ?? values[j]
  //             : values[j];
  //       }
  //       jsonList.add(jsonItem);
  //     }
  //   }
  //   // log("jsonList::"+jsonList.toString());
  //   return jsonList;
  // }
}
