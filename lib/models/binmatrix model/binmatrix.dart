import 'dart:convert';
import 'dart:developer';

class BinMAtrixModel {
  int? stcode;
  String? exception;
  Header? itemdetails;
  BinMAtrixModel(
      {required this.exception,
      required this.stcode,
      required this.itemdetails});

  factory BinMAtrixModel.fromJson(dynamic jsons, int statusCode) {
    var list1 = json.decode(jsons["data"] as String) as Map<String, dynamic>;
    // List<Binmatrixdata> bindataList =
    // list1.map((data) => Binmatrixdata.fromJson(data)).toList();

    return BinMAtrixModel(
      itemdetails: Header.fromJson(list1),
      stcode: statusCode,
      exception: "",
    );
  }

  factory BinMAtrixModel.issue(Map<String, dynamic> jsons, int statusCode) {
    return BinMAtrixModel(
      itemdetails: null,
      stcode: statusCode,
      exception: "",
    );
  }

  factory BinMAtrixModel.error(String? exception, statusCode) {
    return BinMAtrixModel(
      itemdetails: null,
      stcode: statusCode,
      exception: "",
    );
  }
}

class Header {
  List<Binmatrixdata> table2 = [];
  Header({required this.table2});

  factory Header.fromJson(dynamic json) {
    var list2 = json["Table1"] as List;
    List<Binmatrixdata> bindataList =
        list2.map((data) => Binmatrixdata.fromJson(data)).toList();
    return Header(
      table2: bindataList,
    );
  }
}

class Binmatrixdata {
  String? AreaCode;
  String? ZoneCode;
  String? RackCode;
  String? BinCode;
  int? Status;
  double? Capacity;
  double? BinStk;
  double? Space_Available;

  Binmatrixdata({
    required this.AreaCode,
    required this.ZoneCode,
    required this.RackCode,
    required this.BinCode,
    required this.Status,
    required this.Capacity,
    required this.BinStk,
    required this.Space_Available,
  });
  factory Binmatrixdata.fromJson(Map<String, dynamic> json) {
    log(json.toString());
    return Binmatrixdata(
      AreaCode: json["AreaCode"] ?? "",
      ZoneCode: json["ZoneCode"] ?? "",
      RackCode: json["RackCode"] ?? "",
      BinCode: json["BinCode"] ?? "",
      Status: json["Status"] ?? 0,
      Capacity: json["Capacity"] ?? 0.0,
      BinStk: json["storecode"] ?? 0.0,
      Space_Available: json["Space_Available"] ?? 0.0,
    );
  }
}
