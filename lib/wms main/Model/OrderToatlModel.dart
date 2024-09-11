
import 'package:flutter/material.dart';

class OrderTotalDeatils {
  List<ordertotal>? items;
  int StatusCode;

  OrderTotalDeatils({required this.items, required this.StatusCode});
  factory OrderTotalDeatils.fromJson( dynamic jsons,int statuscode) {
    var list = jsons as List;

    List<ordertotal> dataList =
        list.map((data) => ordertotal.fromJson(data)).toList();

    return OrderTotalDeatils(
      items: dataList,
      StatusCode: statuscode
    );
  }

     factory OrderTotalDeatils.issue(int statusCode) {
    return OrderTotalDeatils(
      items: null,
      StatusCode: statusCode
    );
  }
}
class ordertotal {
  int? totalOrder;
  int? outOfstock;
  int? pendingAllo;
  int? pendingDis;
  String? lastSync;

  ordertotal(
      {required this.totalOrder,
      required this.outOfstock,
      required this.pendingAllo,
      required this.pendingDis,
      required this.lastSync,
      });
      factory ordertotal.fromJson(dynamic json) {
    return ordertotal(
      totalOrder: json["Total Order"],
      outOfstock: json["Out of Stock"],
      pendingAllo: json["Pending Allocation"],
      pendingDis: json["Pending Despatch"],
      lastSync: json["LastSync"],
     );
  }
    
  }

