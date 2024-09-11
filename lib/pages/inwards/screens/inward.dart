// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tvc_all/LoginApi/gettextapi.dart';
import 'package:tvc_all/LoginApi/textmodel.dart';
import 'package:tvc_all/constant.dart/ConstantRoutes.dart';
import 'package:tvc_all/open%20po/openpo%20constant/Screen.dart';

class Openpo extends StatefulWidget {
  const Openpo({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<Openpo> createState() => _OpenpoState();
}

class _OpenpoState extends State<Openpo> {
  AudioPlayer _audioPlayer = AudioPlayer();
  // static List<orderData>? dataItems = [];
  // List<ordertotal>? totalItems = [];
  // List<ordertotal>? totaldata = [];
  // final AudioPlayer _audioPlayer = AudioPlayer();
  int count = 0;
  StreamSubscription? subscription;
  bool nointernet = false;
  bool apierror = false;
  Timer? timer;
  // List<itemdet> itemdett = [];

  @override
  void initState() {
    log("hiiii");
    log("openpo");
    timer =
        Timer.periodic(const Duration(seconds: 10), (Timer t) => apiRefersh());
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      connectivityAlert();
      apicalltext();
    });
  }

  apiRefersh() {
    setState(() {
      print("refresh");
      // playSound("neworder");
      itemdet.clear();
    });
    apicalltext();
  }

  List<Textdetails> itemdet = [];
  apicalltext() async {
    playasset();
    log("hi::");
    await GetTextfileApi.getdata().then((value) {
      if (value.stcode == 200) {
        if (value.itemdetails != null) {
          setState(() {
            itemdet = value.itemdetails!;
          });
        }
      }
    });
  }

  Future<bool> onbackpress() {
    DateTime now = DateTime.now();
    DateTime? currentBackPressTime;
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Get.offAllNamed(ConstantRoutes.login);
      return Future.value(true);
    } else {
      return Future.value(true);
    }
  }
  // apicall() {
  //   GetDataAPi.getData().then((value) {
  //     if (value.statusCode == 200) {
  //       if (value.data != null) {
  //         setState(() {
  //           apierror = false;

  //           count++;
  //         });
  //       } else if (value.data == null) {
  //         setState(() {
  //           apierror = true;
  //           playSound("busonservernotconnecting");
  //         });
  //         //playSound("nointernet");
  //       }
  //     } else {
  //       setState(() {
  //         apierror = true;
  //         playSound("busonservernotconnecting");
  //       });
  //     }
  //   });

  //   GetDataTotalAPi.getDataTotal().then((value) {
  //     if (value.StatusCode == 200) {
  //       if (value.items != null) {
  //         setState(() {
  //           apierror = false;
  //           totalItems = value.items;
  //           totaldata = totalItems;
  //           count++;
  //         });
  //       } else if (value.items == null) {
  //         // playSound("nointernet");
  //         setState(() {
  //           apierror = true;
  //           playSound("busonservernotconnecting");
  //         });
  //       }
  //     } else {
  //       // playSound("nointernet");
  //       setState(() {
  //         apierror = true;
  //         playSound("busonservernotconnecting");
  //       });
  //     }
  //   });
  // }

  void showConnection() async {
    final result = await Connectivity().checkConnectivity();
    final hasInternet = result != ConnectivityResult.none;
    if (hasInternet == false) {
      setState(() {
        nointernet = true;
      });
    } else {
      setState(() {
        nointernet = false;
      });
    }
  }

  connectivityAlert() {
    // apicall();
    // subscription = Connectivity().  onConnectivityChanged.listen((event) {
    //   final hasInternet = event != ConnectivityResult.none;
    //   print(hasInternet);
    //   if (hasInternet == true) {
    //     setState(() {
    //       nointernet = false;
    //       connections();
    //     });
    //   } else {
    //     print("else part");
    //     setState(() {
    //       nointernet = true;
    //       playSound("nointernet");
    //     });
    //   }
    // });
  }

  Future<void> playasset() async {
    // setState(() {

    await _audioPlayer.play(AssetSource('hiiiii.mp3'));
    _audioPlayer.resume();
    // });
  }

  // playSound(String sound) {
  //   audio.setAsset("Assets/$sound.mp3");
  //   audio.play();
  // }

  // void _handleAClientProvidedFunction(List<Object>? parameters) async {
  //   String msg = parameters.toString();
  //   // showSnackbar(msg);
  //   String removedBrackets1 = msg.substring(1, msg.length - 1);
  //   String removedBrackets2 =
  //       removedBrackets1.substring(1, removedBrackets1.length - 1);
  //   Responce.getData(removedBrackets2).then((value) {
  //     if (value.remarks == "tv1") {
  //       //print("Remarks: " + value.remarks);
  //       setState(() {
  //         playSound("neworder");
  //         count = 0;
  //         // dataItems!.clear();
  //         // data!.clear();
  //         // totalItems!.clear();
  //         // totaldata!.clear();
  //       });
  //       // apicall();
  //     }
  //   });
  // }

  // showSnackbar(String msg) {
  //   final sn = SnackBar(
  //     content: Text(msg),
  //     duration: const Duration(seconds: 5),
  //   );
  //   ScaffoldMessenger.of(context).showSnackBar(sn);
  // }

  // int getTotalQuantity() {
  //   int totalQuantity = 0;
  //   // Iterate through the list and sum the values of Total_Line_Order_Qty
  //   for (var item in itemdet) {
  //     totalQuantity += item.Total_Line_Order_Qty?.toInt() ?? 0;
  //   }
  //   print(totalQuantity);
  //   return totalQuantity;
  // }

  @override
  Widget build(BuildContext context) {
    // int totalQuantity = getTotalQuantity();
    // double? width1 = Screens.width(context) * 0.15;
    // double? width2 = Screens.width(context) * 0.191;
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: onbackpress,
      child: Scaffold(
        body: itemdet.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            // count != 2 && apierror == false && nointernet == false
            //     ? const Center(
            //         child: CircularProgressIndicator(),
            //       )
            //     : count != 2 && apierror == true && nointernet == false
            //         ? const Center(
            //             child: Text("Some thing went wrong try agin..!!"),
            //           )
            //         : count != 2 && apierror == false && nointernet == true
            //             ? const Center(
            //                 child: Text("No internet connection check it..!!"),
            //               )
            //             :
            : Container(
                // color: Colors.blue,
                height: Screens.fullHeight(context),
                width: Screens.width(context),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Container(
                          width: Screens.width(context) * 0.20,
                          height: Screens.bodyheight(context) * 0.05,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[100]!,
                                blurRadius: 15.0, // soften the shadow
                                spreadRadius: 5.0, //extend the shadow
                                offset: const Offset(
                                  5.0, // Move to right 5  horizontally
                                  5.0, // Move to bottom 5 Vertically
                                ),
                              )
                            ],
                            // color: Colors.white
                            gradient: const LinearGradient(colors: [
                              Color.fromARGB(255, 61, 122, 228),
                              Color.fromARGB(255, 44, 96, 187)
                            ]),
                          ),
                          child: Text(
                            "Brand",
                            style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          width: Screens.width(context) * 0.20,
                          height: Screens.bodyheight(context) * 0.05,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[100]!,
                                blurRadius: 15.0, // soften the shadow
                                spreadRadius: 5.0, //extend the shadow
                                offset: const Offset(
                                  5.0, // Move to right 5  horizontally
                                  5.0, // Move to bottom 5 Vertically
                                ),
                              )
                            ],
                            // color: Colors.white
                            gradient: const LinearGradient(colors: [
                              Color.fromARGB(255, 61, 122, 228),
                              Color.fromARGB(255, 44, 96, 187)
                            ]),
                          ),
                          child: Text(
                            "Category",
                            style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          width: Screens.width(context) * 0.40,
                          height: Screens.bodyheight(context) * 0.05,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[100]!,
                                blurRadius: 15.0, // soften the shadow
                                spreadRadius: 5.0, //extend the shadow
                                offset: const Offset(
                                  5.0, // Move to right 5  horizontally
                                  5.0, // Move to bottom 5 Vertically
                                ),
                              )
                            ],
                            // color: Colors.white
                            gradient: const LinearGradient(colors: [
                              Color.fromARGB(255, 61, 122, 228),
                              Color.fromARGB(255, 44, 96, 187)
                            ]),
                          ),
                          child: Text(
                            "SubCategory",
                            style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          width: Screens.width(context) * 0.20,
                          height: Screens.bodyheight(context) * 0.05,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[100]!,
                                blurRadius: 15.0, // soften the shadow
                                spreadRadius: 5.0, //extend the shadow
                                offset: const Offset(
                                  5.0, // Move to right 5  horizontally
                                  5.0, // Move to bottom 5 Vertically
                                ),
                              )
                            ],
                            // color: Colors.white
                            gradient: const LinearGradient(colors: [
                              Color.fromARGB(255, 61, 122, 228),
                              Color.fromARGB(255, 44, 96, 187)
                            ]),
                          ),
                          child: Text(
                            "Quantity",
                            style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        //itemExtent: 30,
                        itemCount: itemdet.length,
                        itemBuilder: (context, int i) {
                          return SizedBox(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.030,
                            child: Row(
                              // width: Screens.width(context) * 0.06,
                              children: [
                                Container(
                                  width: Screens.width(context) * 0.20,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${itemdet[i].Brand}",
                                    // ${dataItem[i].pincode}  // Update field as needed
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 5.0,
                                        spreadRadius: 0.5,
                                      ),
                                    ],
                                    color: Colors.white,
                                  ),
                                ),
                                Container(
                                  // height:
                                  //     MediaQuery.of(context).size.height * 0.040,
                                  width: Screens.width(context) * 0.20,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${itemdet[i].Category}",
                                    // ${dataItem[i].pincode}  // Update field as needed
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 5.0,
                                        spreadRadius: 0.5,
                                      ),
                                    ],
                                    color: Colors.white,
                                  ),
                                ),
                                Container(
                                  // height:
                                  //     MediaQuery.of(context).size.height * 0.040,
                                  width: Screens.width(context) * 0.40,
                                  alignment: Alignment.center,
                                  // margin: EdgeInsets.symmetric(
                                  //   vertical: 3.0,
                                  // ),
                                  child: Text(
                                    "${itemdet[i].SubCategory}",
                                    // ${dataItem[i].pincode}  // Update field as needed
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 5.0,
                                        spreadRadius: 0.5,
                                      ),
                                    ],
                                    color: Colors.white,
                                  ),
                                ),
                                Container(
                                  // height:
                                  //     MediaQuery.of(context).size.height * 0.040,
                                  width: Screens.width(context) * 0.20,
                                  alignment: Alignment.center,
                                  // margin: EdgeInsets.symmetric(
                                  //   vertical: 3.0,
                                  // ),
                                  child: Text(
                                    "${itemdet[i].Qty}",
                                    // ${dataItem[i].pincode}  // Update field as needed
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 5.0,
                                        spreadRadius: 0.5,
                                      ),
                                    ],
                                    color: Colors.white,
                                  ),
                                ),
                                // Container(
                                //   // height:
                                //   //     MediaQuery.of(context).size.height * 0.040,
                                //   width: Screens.width(context) * 0.10,

                                //   alignment: Alignment.centerLeft,
                                //   // margin: EdgeInsets.symmetric(
                                //   //   vertical: 3.0,
                                //   // ),
                                //   child: Text(
                                //     "${itemdet[i].Brand}",
                                //     // ${dataItem[i].pincode}  // Update field as needed
                                //     style: Theme.of(context)
                                //         .textTheme
                                //         .titleMedium
                                //         ?.copyWith(
                                //           color: Colors.black,
                                //           fontWeight: FontWeight.w500,
                                //         ),
                                //   ),
                                //   decoration: BoxDecoration(
                                //     boxShadow: [
                                //       BoxShadow(
                                //         color: Colors.grey,
                                //         blurRadius: 5.0,
                                //         spreadRadius: 0.5,
                                //       ),
                                //     ],
                                //     color: Colors.white,
                                //   ),
                                // ),
                                // // height:
                                // //       MediaQuery.of(context).size.height * 0.010,
                                // //   width: Screens.width(context) * 0.08,
                                // Container(
                                //   // height:
                                //   //     MediaQuery.of(context).size.height * 0.040,
                                //   width: Screens.width(context) * 0.08,
                                //   alignment: Alignment.centerLeft,
                                //   // margin: EdgeInsets.symmetric(
                                //   //   vertical: 3.0,
                                //   // ),
                                //   child: Text(
                                //     "${itemdet[i].Category}",
                                //     // ${dataItem[i].pincode}  // Update field as needed
                                //     style: Theme.of(context)
                                //         .textTheme
                                //         .titleMedium
                                //         ?.copyWith(
                                //           color: Colors.black,
                                //           fontWeight: FontWeight.w500,
                                //         ),
                                //   ),
                                //   decoration: BoxDecoration(
                                //     boxShadow: [
                                //       BoxShadow(
                                //         color: Colors.grey,
                                //         blurRadius: 5.0,
                                //         spreadRadius: 0.5,
                                //       ),
                                //     ],
                                //     color: Colors.white,
                                //   ),
                                // ),
                                // Container(
                                //   // height:
                                //   //     MediaQuery.of(context).size.height * 0.040,
                                //   width: Screens.width(context) * 0.15,

                                //   alignment: Alignment.centerLeft,
                                //   // margin: EdgeInsets.symmetric(
                                //   //   vertical: 3.0,
                                //   // ),
                                //   child: Text(
                                //     "${itemdet[i].SubCategory}",
                                //     // ${dataItem[i].pincode}  // Update field as needed
                                //     style: Theme.of(context)
                                //         .textTheme
                                //         .titleMedium
                                //         ?.copyWith(
                                //           color: Colors.black,
                                //           fontWeight: FontWeight.w500,
                                //         ),
                                //   ),
                                //   decoration: BoxDecoration(
                                //     boxShadow: [
                                //       BoxShadow(
                                //         color: Colors.grey,
                                //         blurRadius: 5.0,
                                //         spreadRadius: 0.5,
                                //       ),
                                //     ],
                                //     color: Colors.white,
                                //   ),
                                // ),
                                // Container(
                                //   // height:
                                //   //     MediaQuery.of(context).size.height * 0.040,
                                //   width: Screens.width(context) * 0.04,
                                //   alignment: Alignment.centerLeft,
                                //   // margin: EdgeInsets.symmetric(
                                //   //   vertical: 3.0,
                                //   // ),
                                //   child: Text(
                                //     "${itemdet[i].Total_Line_Order_Qty?.toInt()}",
                                //     // ${dataItem[i].pincode}  // Update field as needed
                                //     style: Theme.of(context)
                                //         .textTheme
                                //         .titleMedium
                                //         ?.copyWith(
                                //           color: Colors.black,
                                //           fontWeight: FontWeight.w500,
                                //         ),
                                //   ),
                                //   decoration: BoxDecoration(
                                //     boxShadow: [
                                //       BoxShadow(
                                //         color: Colors.grey,
                                //         blurRadius: 5.0,
                                //         spreadRadius: 0.5,
                                //       ),
                                //     ],
                                //     color: Colors.white,
                                //   ),
                                // ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    // Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    //   // for (int i = 0; i < itemdet.length; i++)
                    //   Container(
                    //     width: Screens.width(context) * 0.2,
                    //     height: Screens.bodyheight(context) * 0.05,
                    //     alignment: Alignment.centerLeft,
                    //     decoration: BoxDecoration(
                    //       boxShadow: [
                    //         BoxShadow(
                    //           color: Colors.grey[100]!,
                    //           blurRadius: 15.0, // soften the shadow
                    //           spreadRadius: 5.0, //extend the shadow
                    //           offset: const Offset(
                    //             5.0, // Move to right 5  horizontally
                    //             5.0, // Move to bottom 5 Vertically
                    //           ),
                    //         )
                    //       ],
                    //       // color: Colors.white
                    //       gradient: const LinearGradient(colors: [
                    //         Color.fromARGB(255, 61, 122, 228),
                    //         Color.fromARGB(255, 44, 96, 187)
                    //       ]),

                    //       // color: Colors.grey,

                    //       //     border: Border.all(
                    //       //   color: Colors.black,
                    //       //   width: 1,
                    //       // )
                    //     ),
                    //     child: Text(
                    //       "  No.of Quantity : $totalQuantity",
                    //       style: theme.textTheme.titleMedium?.copyWith(
                    //           color: Colors.white, fontWeight: FontWeight.w500),
                    //     ),
                    //   ),
                    //   Container(
                    //     width: Screens.width(context) * 0.2,
                    //     height: Screens.bodyheight(context) * 0.05,
                    //     alignment: Alignment.centerLeft,
                    //     decoration: BoxDecoration(
                    //       boxShadow: [
                    //         BoxShadow(
                    //           color: Colors.grey[100]!,
                    //           blurRadius: 15.0, // soften the shadow
                    //           spreadRadius: 5.0, //extend the shadow
                    //           offset: const Offset(
                    //             5.0, // Move to right 5  horizontally
                    //             5.0, // Move to bottom 5 Vertically
                    //           ),
                    //         )
                    //       ],
                    //       // color: Colors.white
                    //       gradient: const LinearGradient(colors: [
                    //         Color.fromARGB(255, 61, 122, 228),
                    //         Color.fromARGB(255, 44, 96, 187)
                    //       ]),

                    //       // color: Colors.grey,

                    //       //     border: Border.all(
                    //       //   color: Colors.black,
                    //       //   width: 1,
                    //       // )
                    //     ),
                    //     child: Text(
                    //       "  No.of count : ${itemdet.length}",
                    //       style: theme.textTheme.titleMedium?.copyWith(
                    //           color: Colors.white, fontWeight: FontWeight.w500),
                    //     ),
                    //   ),
                    // ]),
                  ],
                ),
              ),
      ),
    );
  }
}
