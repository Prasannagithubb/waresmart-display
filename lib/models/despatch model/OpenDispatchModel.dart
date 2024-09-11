class DispatchDetails {
  List<DispatchData>? items;
  DispatchDetails({required this.items, required this.stcode});
  int? stcode;
  factory DispatchDetails.fromJson(dynamic jsons, int statusCode) {
    var list = jsons as List;
    List<DispatchData> dataList =
        list.map((data) => DispatchData.fromJson(data)).toList();
    return DispatchDetails(items: dataList, stcode: statusCode);
  }

  factory DispatchDetails.issue(int statusCode) {
    return DispatchDetails(items: null, stcode: statusCode);
  }
}

class DispatchData {
  int? delpincode;
  int? quantity;
  String? delArea;
  String? routeId;

  DispatchData({
    required this.routeId,
    required this.delArea,
    required this.delpincode,
    required this.quantity,
  });
  factory DispatchData.fromJson(dynamic json) {
    return DispatchData(
      routeId: json["RouteId"],
      delArea: json["delarea"],
      delpincode: json["delpincode"],
      quantity: json["Quantity"],
    );
  }
}
