class OrderDeatils {
  List<orderData>? data;
  int? statusCode;
  OrderDeatils({required this.data, required this.statusCode});

  factory OrderDeatils.fromJson(dynamic jsons, int statusCode) {
    var list = jsons as List;

    List<orderData> dataList =
        list.map((data) => orderData.fromJson(data)).toList();

    return OrderDeatils(data: dataList, statusCode: statusCode);
  }

  factory OrderDeatils.issue(int statusCode) {
    return OrderDeatils(data: null, statusCode: statusCode);
  }
}

class orderData {
  String? Brand;
  String? Category;
  String? SubCategory;
  int? Qty;

  orderData({
    required this.Brand,
    required this.Category,
    required this.Qty,
    required this.SubCategory,
  });
  factory orderData.fromJson(dynamic json) {
    return orderData(
      Brand: json["Brand"] ?? "",
      Category: json["Category"] ?? "",
      SubCategory: json["SubCategory"] ?? "",
      Qty: json["Qty"] ?? 0,
    );
  }
}
