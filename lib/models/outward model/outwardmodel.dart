class SaleOrderDeatils {
  List<orderData>? data;
  int? statusCode;
  SaleOrderDeatils({required this.data, required this.statusCode});

  factory SaleOrderDeatils.fromJson(dynamic jsons, int statusCode) {
    var list = jsons as List;

    List<orderData> dataList =
        list.map((data) => orderData.fromJson(data)).toList();

    return SaleOrderDeatils(data: dataList, statusCode: statusCode);
  }
  factory SaleOrderDeatils.issue(int statusCode) {
    return SaleOrderDeatils(data: null, statusCode: statusCode);
  }
}

class orderData {
  int? audoId;
  String? orderId;
  String? orderSubId;
  String? orderKey;
  String? orderShortId;
  String? orderdate;
  String? storeCode;
  String? brand;
  String? segment;
  String? itemcode;
  String? itemname;
  int? qty;
  String? delarea;
  String? sap;
  String? orderStatus;

  orderData({
    required this.audoId,
    required this.orderId,
    required this.orderSubId,
    required this.orderKey,
    required this.orderShortId,
    required this.orderdate,
    required this.storeCode,
    required this.brand,
    required this.segment,
    required this.itemcode,
    required this.itemname,
    required this.qty,
    required this.delarea,
    required this.sap,
    required this.orderStatus,
  });
  factory orderData.fromJson(dynamic json) {
    return orderData(
      audoId: json["AutoID"],
      orderId: json["orderid"],
      orderSubId: json["ordersubid"],
      orderKey: json["orderkey"],
      orderShortId: json["ordershortid"],
      orderdate: json["orderdate"],
      storeCode: json["storecode"],
      brand: json["brand"],
      segment: json["segment"],
      itemcode: json["itemcode"],
      itemname: json["itemname"],
      qty: json["quantity"],
      delarea: json["delarea"],
      sap: json["SAP"],
      orderStatus: json["orderstatus"],
    );
  }
}
