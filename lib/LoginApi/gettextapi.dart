import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:tvc_all/LoginApi/Url.dart';
import 'package:tvc_all/LoginApi/constantvalues.dart';
import 'package:tvc_all/LoginApi/textmodel.dart';

class GetTextfileApi {
  static Future<TextfileModel> getdata() async {
    int resCode = 500;
    try {
      log("ConstantValues.token::${ConstantValues.token}");
      final response = await http.get(
          Uri.parse("${Url.queryApi}WareSmart/v1/GetTvDisplayOpenInwads/W001"),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ${ConstantValues.token}',
          });
      resCode = response.statusCode;
      // log("rescode::"+response.statusCode.toString());
      log("Textresponse::${response.body}");

      if (response.statusCode == 200) {
        String csvData = response.body;

        // List<dynamic> responcedata = await jsonconvertexample(response.body);
        log("responcedata::$csvData");
        //     List<List<dynamic>> rowsAsListOfValues = const CsvToListConverter().convert(csvData, eol: '\n');
        //  log("rowsAsListOfValues::"+rowsAsListOfValues.toString());
        return TextfileModel.fromJson(jsonDecode(csvData), response.statusCode);
      } else {
        return TextfileModel.issues(
            json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      log("INWres::$e");
      return
//  "";
          TextfileModel.error(e.toString(), resCode);
    }
  }

  static List<Map<String, dynamic>> jsonconvertexample(String tabularData) {
    List<String> lines = tabularData.split('\n');
    List<String> headers = lines[0].split('\t');
    List<Map<String, dynamic>> jsonList = [];
    for (int i = 1; i < lines.length; i++) {
      List<String> values = lines[i].split('\t');
      if (values.length == headers.length) {
        Map<String, dynamic> jsonItem = {};
        for (int j = 0; j < headers.length; j++) {
          jsonItem[headers[j]] = values[j].contains('.')
              ? double.tryParse(values[j]) ?? values[j]
              : values[j];
        }
        jsonList.add(jsonItem);
      }
    }
    // log("jsonList::"+jsonList.toString());
    return jsonList;
  }
}
