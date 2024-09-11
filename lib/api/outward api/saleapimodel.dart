// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';

class SaleModelApi {
  int? stcode;
  String? exception;
  SaleDetails? saleorder1;
  SaleModelApi(
      {required this.stcode,
      required this.exception,
      required this.saleorder1});
  factory SaleModelApi.fromJson(Map<String, dynamic> jsons, int stcode) {
    // var list1 = json.decode(jsons['data'] as String) as Map<String, dynamic>;
    // List<Textdetails> datalist =
    //     list1.map((data) => Textdetails.fromJson(data)).toList();
    return SaleModelApi(
        stcode: stcode, exception: "", saleorder1: SaleDetails.fromJson(jsons));
  }
  factory SaleModelApi.issues(Map<String, dynamic> jsons, int stcode) {
    return SaleModelApi(saleorder1: null, stcode: stcode, exception: "error");
  }
  factory SaleModelApi.error(String? exception, int stcode) {
    return SaleModelApi(saleorder1: null, stcode: stcode, exception: exception);
  }
}

class SaleDetails {
  List<SaleNewDetails>? itemdetails1;

  SaleDetails({required this.itemdetails1});
  factory SaleDetails.fromJson(Map<String, dynamic> jsons) {
    log("$json");
    var list1 = json.decode(jsons["data"]) as List;
    // var list2 = json["Line"] as List;
    List<SaleNewDetails> datalist =
        list1.map((data) => SaleNewDetails.fromJson(data)).toList();
    // List<LineDetails> datalist2 =
    //     list2.map((data) => LineDetails.fromJson(data)).toList();
    return SaleDetails(itemdetails1: datalist);
  }
}

class SaleNewDetails {
  int? DocNumber;
  String? CustomerName;
  String? Del_Area;
  String? Del_Pincode;

  String? Brand;
  String? SubCategory;
  int? Ordered;
  int? Allocated;
  int? Ready_To_Dispatch;

  SaleNewDetails({
    required this.DocNumber,
    required this.CustomerName,
    required this.Del_Area,
    required this.Del_Pincode,
    required this.Brand,
    required this.SubCategory,
    required this.Ordered,
    required this.Allocated,
    required this.Ready_To_Dispatch,
  });
  factory SaleNewDetails.fromJson(Map<String, dynamic> json) {
    return SaleNewDetails(
      DocNumber: json['DocNumber'] ?? 0,
      CustomerName: json['CustomerName'] ?? "",
      Del_Area: json['Del_Area'] ?? '',
      Del_Pincode: json['Del_Pincode'] ?? '',
      Brand: json['Brand'] ?? '',
      SubCategory: json['SubCategory'] ?? '',
      Ordered: json['Ordered'] ?? 0,
      Allocated: json['Allocated'] ?? 0,
      Ready_To_Dispatch: json['Ready_To_Dispatch'] ?? 0,
    );
  }
}
