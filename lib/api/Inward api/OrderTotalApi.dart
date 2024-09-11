// ignore_for_file: file_names

import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;

import '../../open po/openpo model/OrderToatlModel.dart';

class GetDataTotalAPi {
  static Future<OrderTotalDeatils> getDataTotal() async {
    final AudioPlayer audioPlayer = AudioPlayer();

    try {
      // print("http://202.65.131.32:15674/api/Dashboard1");
      final response = await http.get(
        Uri.parse("http://202.65.131.32:15674/api/Dashboard1"),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        await audioPlayer
            .play(AssetSource('lib/Assets/simple-notification-152054.mp3'));
        // print(json.decode(response.body));
        return OrderTotalDeatils.fromJson(json.decode(response.body),
            response.statusCode); //as Map<String, dynamic>
      } else {
        // throw Exception("Error");
        return OrderTotalDeatils.issue(response.statusCode);
      }
    } catch (e) {
      //  throw Exception(e.toString());
      return OrderTotalDeatils.issue(500);
    }
  }
}
