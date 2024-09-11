import 'dart:convert';

class LoginModelApi {
  int? stcode;
  int? statusCode;
  String? exception;
  Logindetails1? loginorder;
  // List<DespatchItem> data = [];
  LoginModelApi(
      {required this.stcode,
      required this.statusCode,
      required this.exception,
      required this.loginorder});
  factory LoginModelApi.fromJson(Map<String, dynamic> jsons, int stcode) {
    return LoginModelApi(
        stcode: stcode,
        statusCode: stcode,
        exception: "",
        loginorder: Logindetails1.fromJson(jsons, stcode));
  }
  factory LoginModelApi.issues(Map<String, dynamic> jsons, int stcode) {
    return LoginModelApi(
      loginorder: null,
      stcode: stcode,
      exception: "error",
      statusCode: stcode,
    );
  }
  factory LoginModelApi.error(String? exception, int stcode) {
    return LoginModelApi(
      loginorder: null,
      stcode: stcode,
      exception: exception,
      statusCode: stcode,
    );
  }
}

class Logindetails1 {
  List<LoginItems>? logindetails;

  Logindetails1({required this.logindetails, required int statusCode});
  factory Logindetails1.fromJson(Map<String, dynamic> jsons, int statusCode) {
    // log("$jsons");
    var list1 = json.decode(jsons["data"]) as List;
    // var list2 = json["Line"] as List;
    List<LoginItems> datalist =
        list1.map((data) => LoginItems.fromJson(data)).toList();
    // List<LineDetails> datalist2 =
    //     list2.map((data) => LineDetails.fromJson(data)).toList();
    return Logindetails1(logindetails: datalist, statusCode: statusCode);
  }
  factory Logindetails1.issue(int statusCode) {
    return Logindetails1(statusCode: statusCode, logindetails: []);
  }
}

class LoginItems {
  String? DeviceCode;
  String? DeviceName;
  String? DeviceID;
  String? FCM_Token;
  String? WhsCode;
  String? DefaultUser;
  bool? Status;
  int? CreatedBy;
  String? CreatedDateTime;
  int? UpdatedBy;
  String? UpdatedDatetime;
  String? traceid;
  int? DisplayId;

  LoginItems({
    required this.DeviceCode,
    required this.DeviceName,
    required this.DeviceID,
    required this.FCM_Token,
    required this.WhsCode,
    required this.DefaultUser,
    required this.Status,
    required this.CreatedBy,
    required this.CreatedDateTime,
    required this.UpdatedBy,
    required this.UpdatedDatetime,
    required this.traceid,
    required this.DisplayId,
  });

  factory LoginItems.fromJson(Map<String, dynamic> json) {
    return LoginItems(
      DeviceCode: json['DeviceCode'] ?? "",
      DeviceName: json['DeviceName'] ?? "",
      DeviceID: json['DeviceID'] ?? '',
      FCM_Token: json['FCM_Token'] ?? '',
      WhsCode: json['WhsCode'] ?? "",
      DefaultUser: json['DefaultUser'] ?? "",
      Status: json['Status'] ?? true,
      CreatedBy: json['CreatedBy'] ?? 0,
      CreatedDateTime: json['CreatedDateTime'] ?? '',
      UpdatedBy: json['UpdatedBy'] ?? 0,
      UpdatedDatetime: json['UpdatedDatetime'] ?? '',
      traceid: json['traceid'] ?? '',
      DisplayId: json['DisplayId'] ?? 0,
    );
  }
}
