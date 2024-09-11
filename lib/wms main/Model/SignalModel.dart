import 'dart:convert';

class Responce {
  String command;
  String tv;
  String remarks;

  Responce({required this.command, required this.remarks, required this.tv});

  factory Responce.fromJson(Map<String, dynamic> json) {
    return Responce(
      command: json["command"],
      remarks: json["remarks"],
      tv: json["tv"],
    );
  }

  static Future<Responce> getData(String responce) async {
    return Responce.fromJson(json.decode(responce));
  }
}