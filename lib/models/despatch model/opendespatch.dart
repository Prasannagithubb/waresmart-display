import 'dart:convert';

class DespatchModelApi {
  int? stcode;
  int? statusCode;
  String? exception;
  DespatchDetails? saleorder1;
  // List<DespatchItem> data = [];
  DespatchModelApi(
      {required this.stcode,
      required this.statusCode,
      required this.exception,
      required this.saleorder1});
  factory DespatchModelApi.fromJson(Map<String, dynamic> jsons, int stcode) {
    return DespatchModelApi(
        stcode: stcode,
        statusCode: stcode,
        exception: "",
        saleorder1: DespatchDetails.fromJson(jsons, stcode));
  }
  factory DespatchModelApi.issues(Map<String, dynamic> jsons, int stcode) {
    return DespatchModelApi(
      saleorder1: null,
      stcode: stcode,
      exception: "error",
      statusCode: stcode,
    );
  }
  factory DespatchModelApi.error(String? exception, int stcode) {
    return DespatchModelApi(
      saleorder1: null,
      stcode: stcode,
      exception: exception,
      statusCode: stcode,
    );
  }
}

class DespatchDetails {
  List<DespatchItem>? itemdetails1;

  DespatchDetails({required this.itemdetails1, required int statusCode});
  factory DespatchDetails.fromJson(Map<String, dynamic> jsons, int statusCode) {
    // log("$jsons");
    var list1 = json.decode(jsons["data"]) as List;
    // var list2 = json["Line"] as List;
    List<DespatchItem> datalist =
        list1.map((data) => DespatchItem.fromJson(data)).toList();
    // List<LineDetails> datalist2 =
    //     list2.map((data) => LineDetails.fromJson(data)).toList();
    return DespatchDetails(itemdetails1: datalist, statusCode: statusCode);
  }
  factory DespatchDetails.issue(int statusCode) {
    return DespatchDetails(statusCode: statusCode, itemdetails1: []);
  }
}

class DespatchItem {
  String? Brand;
  String? SubCategory;
  String? Del_Pincode;
  String? Del_Area;
  int? Ready_To_Dispatch;

  DespatchItem({
    required this.Brand,
    required this.SubCategory,
    required this.Del_Pincode,
    required this.Del_Area,
    required this.Ready_To_Dispatch,
  });

  factory DespatchItem.fromJson(Map<String, dynamic> json) {
    return DespatchItem(
      Brand: json['Brand'] ?? "",
      SubCategory: json['SubCategory'] ?? "",
      Del_Pincode: json['Del_Pincode'] ?? '',
      Del_Area: json['Del_Area'] ?? '',
      Ready_To_Dispatch: json['Ready_To_Dispatch'] ?? 0,
    );
  }
}
