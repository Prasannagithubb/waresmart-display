import 'dart:convert';

class TextfileModel {
  int? stcode;
  String? exception;
  List<Textdetails>? itemdetails;

  TextfileModel(
      {required this.stcode,
      required this.exception,
      required this.itemdetails});
  factory TextfileModel.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (jsons != null) {
      var list1 = json.decode(jsons["data"]) as List;
      List<Textdetails> datalist =
          list1.map((data) => Textdetails.fromJson(data)).toList();
      return TextfileModel(
          stcode: stcode, exception: "", itemdetails: datalist);
    } else {
      return TextfileModel(stcode: stcode, exception: "", itemdetails: null);
    }
  }
  factory TextfileModel.issues(Map<String, dynamic> jsons, int stcode) {
    return TextfileModel(itemdetails: null, stcode: stcode, exception: "error");
  }
  factory TextfileModel.error(String? exception, int stcode) {
    return TextfileModel(
        itemdetails: null, stcode: stcode, exception: exception);
  }
}

// class textdetails {
//   String? DocEntry;
//   String? DocNumber;
//   String? LineNum;
//   String? ItemCode;
//   String? ItemName;

//   String? Brand;
//   String? Category;
//   String? SubCategory;
//   double? Total_Line_Order_Qty;
//   textdetails({
//     required this.ItemName,
//     required this.Brand,
//     required this.Category,
//     required this.DocEntry,
//     required this.DocNumber,
//     required this.ItemCode,
//     required this.LineNum,
//     required this.SubCategory,
//     required this.Total_Line_Order_Qty,
//   });
//   factory textdetails.fromJson(Map<String, dynamic> json) {
//     return textdetails(
//         ItemName: json['ItemName'] ?? "dummybrand",
//         Brand: json['Brand'] ?? "dummybrand",
//         Category: json['Category'] ?? "dummyCategory",
//         DocEntry: json['DocEntry'] ?? '',
//         DocNumber: json['DocNumber'] ?? '',
//         ItemCode: json['ItemCode'] ?? "dummyItemCode",
//         LineNum: json['LineNum'] ?? '',
//         SubCategory: json['SubCategory'] ?? "dummySubCategory",
//         Total_Line_Order_Qty:
//             json['Total_Line_Order_Qty'] ?? "dummyTotal_Line_Order_Qty");
//   }
// }

class Textdetails {
  String? Brand;
  String? Category;
  String? SubCategory;
  int? Qty;

  Textdetails({
    required this.Brand,
    required this.Category,
    required this.Qty,
    required this.SubCategory,
  });
  factory Textdetails.fromJson(Map<String, dynamic> json) {
    return Textdetails(
      Brand: json["Brand"] ?? "",
      Category: json["Category"] ?? "",
      SubCategory: json["SubCategory"] ?? "",
      Qty: json["Qty"] ?? 0,
    );
  }
}
