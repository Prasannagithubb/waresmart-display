import 'package:intl/intl.dart';

class Config {
  static aligndatefollow(String date) {
    final inputDate = "$date";
    final outputFormat = DateFormat("yyyy-MM-dd");
    final parsedDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(inputDate);
    final formattedDate = outputFormat.format(parsedDate);
    return formattedDate;
  }
}
