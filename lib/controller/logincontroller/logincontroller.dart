// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:tvc_all/LoginApi/LoginApi.dart';
// import 'package:tvc_all/LoginApi/config.dart';

// class LoginController extends ChangeNotifier {
//   LoginController(BuildContext context) {
//     check(context);
//   }
//   LocationPermission? permission;
//   bool? locationbool = false;
//   bool? TCbool = false;

//   bool? camerabool = false;
//   bool? notificationbool = false;
//   check(BuildContext context) async {
//     // await checkLocation();

//     final permission = Permission.notification;
//     PermissionStatus status = await permission.status;

//     // var locationStatus = await Permission.location.status;
//     // // var cameraStatus = await Permission.camera.status;
//     // // var notifiStatus = await Permission.notification.status;

//     // print('location' + locationStatus.toString());
//     // // print('cameraStatus' + cameraStatus.toString());
//     // // print('notifiStatus2' + notifiStatus.toString());

//     // if (locationStatus.isGranted) {
//     //   locationbool = true;
//     //   notifyListeners();
//     // }
//     // // if (cameraStatus.isGranted) {
//     // //   camerabool = true;
//     // //   notifyListeners();
//     // // }
//     // // if (notifiStatus.isGranted) {
//     // //   notificationbool = true;
//     // //   notifyListeners();
//     // // }
//     // // if (Platform.isIOS) {
//     // if (locationbool == false
//     //     // ||
//     //     //     camerabool == false ||
//     //     //     notificationbool == false
//     //     ) {
//     //   LocationPermission permission;

//     //   await showDialog<dynamic>(
//     //       context: context,
//     //       builder: (_) {
//     //         return PermissionShowDialog(
//     //           locationbool: locationbool,
//     //           camerabool: camerabool,
//     //           notificationbool: notificationbool,
//     //         );
//     //       }).then((value) async {
//     //     await Geolocator.requestPermission().then((value) async {
//     //       // permission = await Geolocator.checkPermission();
//     //       // if (LocationPermission.always != value) {
//     //       //  await Geolocator.requestPermission();
//     //       // }
//     //     });
//     //   });
//     // }
//     // }
//   //   getHost();
//   //   notifyListeners();
//   // }

//   Config config = new Config();
//   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
//   List<TextEditingController> mycontroller =
//       List.generate(15, (i) => TextEditingController());
//   GlobalKey<FormState> formkey = GlobalKey<FormState>();
//   GlobalKey<FormState> formkey2 = GlobalKey<FormState>();
//   bool hidePassword = true;
//   bool isLoading = false;
//   bool erroMsgVisble = false;
//   bool settingError = false;

//   String errorMsh = '';
//   static bool loginPageScrn = false;

//   bool get getHidepassword => hidePassword;
//   bool get getIsLoading => isLoading;
//   bool get geterroMsgVisble => erroMsgVisble;
//   bool get getsettingError => settingError;

//   String get getErrorMshg => errorMsh;

//   void obsecure() {
//     hidePassword = !hidePassword;
//     notifyListeners();
//   }

//   showLoginDialog(BuildContext context) {
//     config.msgDialog(context, '', '');
//   }

//   Future<void> getUrlApi() async {
//     String? Url = "";
//     //Get Url Api
//     print("get Url Api call:" + mycontroller[3].text.toString());
//     await GetURLApi.getData(mycontroller[3].text.toString().trim())
//         .then((value) async {
//       if (value.stcode! >= 200 && value.stcode! <= 210) {
//         if (value.url != null) {
//           Url = value.url;
//           print("url method::" + Url.toString());
//           await HelperFunctions.saveHostSP(Url!.trim());
//           await HelperFunctions.saveTenetIDSharedPreference(
//               mycontroller[3].text.toString().trim());
//           setURL();
//           errorMsh = "";
//           erroMsgVisble = false;
//           settingError = false;
//           notifyListeners();
//         } else {
//           print("object1:" + value.exception.toString());
//           erroMsgVisble = true;
//           isLoading = false;
//           errorMsh = value.exception.toString();
//         }
//       } else {
//         print("object2:" + value.exception.toString());
//         erroMsgVisble = true;
//         isLoading = false;
//         errorMsh = value.exception.toString();
//       }
//     });
//     notifyListeners();
//   }

//   validateLogin(BuildContext context) async {
//     // PermissionStatus locationStatus;

//     //  locationStatus = await Permission.location.status;

//     // if (locationStatus.isGranted) {
//     // if(Platform.isIOS){
//     //   print('testLogin');
//     //   await checkLocation();
//     //   await Future.delayed(Duration(seconds: 3));
//     // }
//     if (mycontroller[3].text.toString().trim().isEmpty) {
//       errorMsh = "Complete the setup..!!";
//     } else {
//       if (formkey.currentState!.validate()) {
//         disableKeyBoard(context);
//         isLoading = true;
//         //**** */
//         //  await config.getSetup();

//         //Get URL APi

//         String? Url = "";
//         //Get Url Api
//         print("get Url Api call:" + mycontroller[3].text.toString());
//         await GetURLApi.getData(mycontroller[3].text.toString().trim())
//             .then((value) async {
//           if (value.stcode! >= 200 && value.stcode! <= 210) {
//             if (value.url != null) {
//               Url = value.url;
//               log("url method::" + Url.toString());
//               await HelperFunctions.saveHostSP(Url!.trim());
//               await HelperFunctions.saveTenetIDSharedPreference(
//                   mycontroller[3].text.toString().trim());
//               setURL();
//               errorMsh = "";
//               erroMsgVisble = false;
//               settingError = false;
//               notifyListeners();
//             } else {
//               log("object1:" + value.exception.toString());
//               erroMsgVisble = true;
//               isLoading = false;
//               errorMsh = value.exception.toString();
//             }
//           } else {
//             log("object2:" + value.exception.toString());
//             erroMsgVisble = true;
//             isLoading = false;
//             errorMsh = value.exception.toString();
//           }
//         });

//         //
//         await getUrlApi();
//         //**** */
//         log("is is is ");
//         notifyListeners();
//         PostLoginData postLoginData = new PostLoginData();
//         postLoginData.deviceCode =
//             await HelperFunctions.getDeviceIDSharedPreference();
//         postLoginData.licenseKey =
//             await HelperFunctions.getLicenseKeySharedPreference();
//         postLoginData.fcmToken =
//             await HelperFunctions.getFCMTokenSharedPreference();
//         // log("fcmmmm: "+postLoginData.fcmToken.toString());
//         postLoginData.username = mycontroller[0].text;
//         postLoginData.password = mycontroller[1].text;
//         ConstantValues.tenetID =
//             await HelperFunctions.getTenetIDSharedPreference();

//         await LoginAPi.getData(postLoginData).then((value) async {
//           if (value.resCode! >= 200 && value.resCode! <= 200) {
//             if (value.loginstatus!.toLowerCase().contains('success') &&
//                 value.data != null) {
//               DashBoardController.isLogout = false;
//               isLoading = false;
//               erroMsgVisble = false;
//               errorMsh = '';
//               ConstantValues.userNamePM = mycontroller[0].text;
//               await HelperFunctions.saveUserName(mycontroller[0].text);
//               await HelperFunctions.saveLicenseKeySharedPreference(
//                   value.data!.licenseKey);
//               await HelperFunctions.saveLogginUserCodeSharedPreference(
//                   mycontroller[0].text);
//               // await HelperFunctions.saveSapUrlSharedPreference(
//               //     value.data!.endPointUrl);
//               await HelperFunctions.saveTenetIDSharedPreference(
//                   value.data!.tenantId);
//               await HelperFunctions.saveUserIDSharedPreference(
//                   value.data!.UserID);
//               ConstantValues.UserId = value.data!.UserID;
//               ConstantValues.storeid =
//                   int.parse(value.data!.storeid.toString());
//               ConstantValues.Storecode = value.data!.storecode.toString();
//               await HelperFunctions.saveUserLoggedInSharedPreference(true);
//               await HelperFunctions.savePasswordSharedPreference(
//                   mycontroller[1].text);

//               log("message");
//               // await HelperFunctions.saveuserDB(value.data!.userDB);
//               await HelperFunctions.savedbUserName(value.data!.UserID);
//               // await HelperFunctions.savedbPassword(value.data!.dbPassword);

//               await HelperFunctions.saveUserType(value.data!.userType);
//               await HelperFunctions.saveSlpCode(value.data!.slpcode);

//               mycontroller[0].clear();
//               mycontroller[1].clear();
//               notifyListeners();
//               Get.offAllNamed(ConstantRoutes.download);
//             } else if (value.loginstatus!.toLowerCase().contains("failed") &&
//                 value.data == null) {
//               isLoading = false;
//               erroMsgVisble = true;
//               errorMsh = value.loginMsg!;
//               notifyListeners();
//             }
//           } else if (value.resCode! >= 400 && value.resCode! <= 410) {
//             erroMsgVisble = true;

//             isLoading = false;
//             errorMsh = value.excep!;
//             notifyListeners();
//           } else {
//             if (value.excep == 'No route to host') {
//               isLoading = false;
//               erroMsgVisble = true;
//               errorMsh = 'Check your internet Connection...!!';
//             } else {
//               isLoading = false;
//               erroMsgVisble = true;
//               errorMsh = '${value.excep!}--${value.resCode}...!!';
//             }
//             notifyListeners();
//           }
//         });
//         // Get.offAllNamed(ConstantRoutes.dashboard);
//       }
//     }
//     // } else {
//     //   await showDialog<dynamic>(
//     //         context: context,
//     //         builder: (_) {
//     //           return PermissionShowDialog(
//     //             locationbool: locationbool,
//     //             camerabool: camerabool,
//     //             notificationbool: notificationbool,
//     //           );
//     //         }).then((value) async {
//     //             permission = await Geolocator.checkPermission();

//     //     });
//     // }
//   }

//   // showShare(String deviceID) {
//   //   Share.share(
//   //     'Dear Sir/Madam,\n  Kindly Register My Mobile For Sellerkit App,\n My Device ID : \n $deviceID \n Thanks & Regards',
//   //   );
//   // }

//   disableKeyBoard(BuildContext context) {
//     FocusScopeNode focus = FocusScope.of(context);
//     if (!focus.hasPrimaryFocus) {
//       focus.unfocus();
//     }
//   }

//   // testApi()async{
//   //  await TestApi.getData();
//   // }
// }
