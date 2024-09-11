import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:tvc_all/api/Inward%20api/OrderApi.dart';
import 'package:tvc_all/open%20po/openpo%20constant/Screen.dart';
import 'package:tvc_all/open%20po/openpo%20model/OrderModel.dart';
import 'package:tvc_all/open%20po/openpo%20model/OrderToatlModel.dart';

import '../../api/Inward api/OrderTotalApi.dart';

class WmsMain extends StatefulWidget {
  const WmsMain({super.key, required this.title});

  final String title;

  @override
  State<WmsMain> createState() => _WmsMainState();
}

final hubConnection =
    HubConnectionBuilder().withUrl("http://202.65.131.32:15674/send").build();

class _WmsMainState extends State<WmsMain> {
  static List<orderData>? dataItems = [];
  static List<orderData>? data = [];
  List<ordertotal>? totalItems = [];
  List<ordertotal>? totaldata = [];
  AudioPlayer audio = AudioPlayer();
  int count = 0;
  StreamSubscription? subscription;
  bool nointernet = false;
  bool apierror = false;

  @override
  void initState() {
    // connections();
    // apicall();

    connectivityAlert();
    apicall();
    // showConnection();
    super.initState();
  }

  apicall() {
    GetDataAPi.getData().then((value) {
      if (value.statusCode == 200) {
        if (value.data != null) {
          setState(() {
            apierror = false;
            dataItems = value.data;
            data = dataItems;
            count++;
          });
        } else if (value.data == null) {
          setState(() {
            apierror = true;
            playSound("busonservernotconnecting");
          });
          //playSound("nointernet");
        }
      } else {
        setState(() {
          apierror = true;
          playSound("busonservernotconnecting");
        });
      }
    });

    GetDataTotalAPi.getDataTotal().then((value) {
      if (value.StatusCode == 200) {
        if (value.items != null) {
          setState(() {
            apierror = false;
            totalItems = value.items;
            totaldata = totalItems;
            count++;
          });
        } else if (value.items == null) {
          // playSound("nointernet");
          setState(() {
            apierror = true;
            playSound("busonservernotconnecting");
          });
        }
      } else {
        // playSound("nointernet");
        setState(() {
          apierror = true;
          playSound("busonservernotconnecting");
        });
      }
    });
  }

  // void showConnection() async {
  //   final result = await Connectivity().checkConnectivity();
  //   final hasInternet = result != ConnectivityResult.none;
  //   if (hasInternet == false) {
  //     setState(() {
  //       nointernet = true;
  //       playSound("nointernet");
  //     });
  //   } else {
  //     setState(() {
  //       nointernet = false;
  //     });
  //   }
  // }

  connectivityAlert() {
    subscription = Connectivity().onConnectivityChanged.listen((event) {
      final hasInternet = event != ConnectivityResult.none;
      print(hasInternet);
      if (hasInternet == true) {
        setState(() {
          nointernet = false;
          connections();
          apicall();
        });
      } else {
        print("else part");
        setState(() {
          nointernet = true;
          playSound("nointernet");
        });
      }
    });
  }

  ///signalr
  ///
  void connections() async {
    try {
      if (hubConnection.state == HubConnectionState.disconnected) {
        // print("Not connected");
        // startConnections();
      } else {
        //print("connected");
        showSnackbar("connected");
      }
    } catch (e) {
      //print(" exception: $e");
      showSnackbar(e.toString());
    }
  }

  // void startConnections() {
  //   try {
  //     hubConnection.start();
  //     hubConnection.on("ReceiveLength", _handleAClientProvidedFunction);
  //     Future.delayed(Duration(seconds: 2), () {
  //       connections();
  //     });
  //   } catch (e) {
  //     print(e);
  //     showSnackbar(e.toString());
  //   }
  // }

  playSound(String sound) {
    audio.setAsset("Assets/$sound.mp3");
    audio.play();
  }

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
  //         dataItems!.clear();
  //         data!.clear();
  //         totalItems!.clear();
  //         totaldata!.clear();
  //       });
  //       apicall();
  //     }
  //   });
  // }

  showSnackbar(String msg) {
    final sn = SnackBar(
      content: Text("$msg"),
      duration: const Duration(seconds: 5),
    );
    ScaffoldMessenger.of(context).showSnackBar(sn);
  }

  @override
  Widget build(BuildContext context) {
    double? width1 = Screens.width(context) * 0.10;
    double? width2 = Screens.width(context) * 0.191;
    final theme = Theme.of(context);
    return Scaffold(
      body: count != 2 && apierror == false && nointernet == false
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : count != 2 && apierror == true && nointernet == false
              ? const Center(
                  child: Text("Some thing went wrong try agin..!!"),
                )
              : count != 2 && apierror == false && nointernet == true
                  ? const Center(
                      child: Text("No internet connection check it..!!"),
                    )
                  : SizedBox(
                      height: Screens.padingHeight(context),
                      width: Screens.width(context),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    // playSound("neworder");
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: Screens.width(context) * 0.06,
                                    height: Screens.bodyheight(context) * 0.05,
                                    decoration: BoxDecoration(
                                        // color: Colors.grey,
                                        border: Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    )),
                                    child: Text(
                                      "Order",
                                      style: theme.textTheme.titleMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: width1,
                                  height: Screens.bodyheight(context) * 0.05,
                                  decoration: BoxDecoration(
                                      // color: Colors.grey,
                                      border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  )),
                                  child: Text(
                                    "Date",
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: Screens.width(context) * 0.07,
                                  height: Screens.bodyheight(context) * 0.05,
                                  decoration: BoxDecoration(
                                      // color: Colors.grey,
                                      border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  )),
                                  child: Text(
                                    "Store",
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: width1,
                                  height: Screens.bodyheight(context) * 0.05,
                                  decoration: BoxDecoration(
                                      // color: Colors.grey,
                                      border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  )),
                                  child: Text(
                                    "Brand",
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: Screens.width(context) * 0.104,
                                  height: Screens.bodyheight(context) * 0.05,
                                  decoration: BoxDecoration(
                                      // color: Colors.grey,
                                      border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  )),
                                  child: Text(
                                    "Seg.",
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: Screens.width(context) * 0.17,
                                  height: Screens.bodyheight(context) * 0.05,
                                  decoration: BoxDecoration(
                                      // color: Colors.grey,
                                      border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  )),
                                  child: Text(
                                    "Model",
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: Screens.width(context) * 0.045,
                                  height: Screens.bodyheight(context) * 0.05,
                                  decoration: BoxDecoration(
                                      // color: Colors.grey,
                                      border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  )),
                                  child: Text(
                                    "Qty",
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: Screens.width(context) * 0.15,
                                  height: Screens.bodyheight(context) * 0.05,
                                  decoration: BoxDecoration(
                                      // color: Colors.grey,
                                      border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  )),
                                  child: Text(
                                    "Area",
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: width1,
                                  height: Screens.bodyheight(context) * 0.05,
                                  decoration: BoxDecoration(
                                      // color: Colors.grey,
                                      border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  )),
                                  child: Text(
                                    "SAP",
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: width1,
                                  height: Screens.bodyheight(context) * 0.05,
                                  decoration: BoxDecoration(
                                      // color: Colors.grey,
                                      border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  )),
                                  child: Text(
                                    "Status",
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: Screens.bodyheight(context) * 0.88,
                            width: Screens.width(context),
                            // color: Colors.blue,
                            child: data!.isEmpty
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : ListView.builder(
                                    // reverse: true,
                                    // padding:
                                    //     EdgeInsets.only(top: Screens.bodyheight(context) * 0.00),
                                    physics: const BouncingScrollPhysics(
                                        parent:
                                            AlwaysScrollableScrollPhysics()),
                                    //itemExtent: 30,
                                    itemCount: data!.length,
                                    itemBuilder: (context, int i) {
                                      return Container(
                                        child: Row(
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              width:
                                                  Screens.width(context) * 0.06,
                                              height:
                                                  Screens.bodyheight(context) *
                                                      0.05,
                                              decoration: BoxDecoration(
                                                  gradient:
                                                      const LinearGradient(
                                                          colors: [
                                                        Color.fromARGB(
                                                            255, 61, 122, 228),
                                                        const Color.fromARGB(
                                                            255, 44, 96, 187)
                                                      ]),
                                                  border: Border.all(
                                                    color: Colors.grey[100]!,
                                                    width: 0.5,
                                                  )),
                                              child: Text(
                                                "${data![i].Brand}",
                                                overflow: TextOverflow.ellipsis,
                                                style: theme
                                                    .textTheme.titleMedium
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              width: width1,
                                              height:
                                                  Screens.bodyheight(context) *
                                                      0.05,
                                              decoration: BoxDecoration(
                                                  gradient: new LinearGradient(
                                                      colors: [
                                                        const Color.fromARGB(
                                                            255, 61, 122, 228),
                                                        const Color.fromARGB(
                                                            255, 44, 96, 187)
                                                      ]),
                                                  border: Border.all(
                                                    color: Colors.grey[100]!,
                                                    width: 0.5,
                                                  )),
                                              child: Text(
                                                "${data![i].Brand}",
                                                overflow: TextOverflow.ellipsis,
                                                style: theme
                                                    .textTheme.titleMedium
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              width:
                                                  Screens.width(context) * 0.07,
                                              height:
                                                  Screens.bodyheight(context) *
                                                      0.05,
                                              decoration: BoxDecoration(
                                                  gradient:
                                                      const LinearGradient(
                                                          colors: [
                                                        Color.fromARGB(
                                                            255, 61, 122, 228),
                                                        Color.fromARGB(
                                                            255, 44, 96, 187)
                                                      ]),
                                                  border: Border.all(
                                                    color: Colors.grey[100]!,
                                                    width: 0.5,
                                                  )),
                                              child: Text(
                                                "${data![i].Brand}",
                                                overflow: TextOverflow.ellipsis,
                                                style: theme
                                                    .textTheme.titleMedium
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white),
                                              ),
                                            ),
                                            Container(
                                              // alignment: Alignment.center,
                                              width: width1,
                                              height:
                                                  Screens.bodyheight(context) *
                                                      0.05,
                                              decoration: BoxDecoration(
                                                  gradient:
                                                      const LinearGradient(
                                                          colors: [
                                                        Color.fromARGB(
                                                            255, 61, 122, 228),
                                                        Color.fromARGB(
                                                            255, 44, 96, 187)
                                                      ]),
                                                  border: Border.all(
                                                    color: Colors.grey[100]!,
                                                    width: 0.5,
                                                  )),
                                              child: Text(
                                                " ${data![i].Brand}",
                                                overflow: TextOverflow.ellipsis,
                                                style: theme
                                                    .textTheme.titleMedium
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white),
                                              ),
                                            ),
                                            Container(
                                              // alignment: Alignment.center,
                                              width: Screens.width(context) *
                                                  0.104,
                                              height:
                                                  Screens.bodyheight(context) *
                                                      0.05,
                                              decoration: BoxDecoration(
                                                  gradient:
                                                      const LinearGradient(
                                                          colors: [
                                                        Color.fromARGB(
                                                            255, 61, 122, 228),
                                                        Color.fromARGB(
                                                            255, 44, 96, 187)
                                                      ]),
                                                  border: Border.all(
                                                    color: Colors.grey[100]!,
                                                    width: 0.5,
                                                  )),
                                              child: Text(
                                                " ${data![i].Brand}",
                                                overflow: TextOverflow.ellipsis,
                                                style: theme
                                                    .textTheme.titleMedium
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white),
                                              ),
                                            ),
                                            Container(
                                              // alignment: Alignment.center,
                                              width:
                                                  Screens.width(context) * 0.17,
                                              height:
                                                  Screens.bodyheight(context) *
                                                      0.05,
                                              decoration: BoxDecoration(
                                                  gradient:
                                                      const LinearGradient(
                                                          colors: [
                                                        const Color.fromARGB(
                                                            255, 61, 122, 228),
                                                        const Color.fromARGB(
                                                            255, 44, 96, 187)
                                                      ]),
                                                  border: Border.all(
                                                    color: Colors.grey[100]!,
                                                    width: 0.5,
                                                  )),
                                              child: Text(
                                                " ${data![i].Brand}",
                                                overflow: TextOverflow.ellipsis,
                                                style: theme
                                                    .textTheme.titleMedium
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              width: Screens.width(context) *
                                                  0.045,
                                              height:
                                                  Screens.bodyheight(context) *
                                                      0.05,
                                              decoration: BoxDecoration(
                                                  gradient:
                                                      const LinearGradient(
                                                          colors: [
                                                        const Color.fromARGB(
                                                            255, 61, 122, 228),
                                                        const Color.fromARGB(
                                                            255, 44, 96, 187)
                                                      ]),
                                                  border: Border.all(
                                                    color: Colors.grey[100]!,
                                                    width: 0.5,
                                                  )),
                                              child: Text(
                                                "${data![i].Category}",
                                                style: theme
                                                    .textTheme.titleMedium
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white),
                                              ),
                                            ),
                                            Container(
                                              // alignment: Alignment.center,
                                              width:
                                                  Screens.width(context) * 0.15,
                                              height:
                                                  Screens.bodyheight(context) *
                                                      0.05,
                                              decoration: BoxDecoration(
                                                  gradient:
                                                      const LinearGradient(
                                                          colors: [
                                                        const Color.fromARGB(
                                                            255, 61, 122, 228),
                                                        const Color.fromARGB(
                                                            255, 44, 96, 187)
                                                      ]),
                                                  border: Border.all(
                                                    color: Colors.grey[100]!,
                                                    width: 0.5,
                                                  )),
                                              child: Text(
                                                " ${data![i].SubCategory}",
                                                overflow: TextOverflow.ellipsis,
                                                style: theme
                                                    .textTheme.titleMedium
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              width: width1,
                                              height:
                                                  Screens.bodyheight(context) *
                                                      0.05,
                                              decoration: BoxDecoration(
                                                  gradient:
                                                      const LinearGradient(
                                                          colors: [
                                                        const Color.fromARGB(
                                                            255, 61, 122, 228),
                                                        const Color.fromARGB(
                                                            255, 44, 96, 187)
                                                      ]),
                                                  border: Border.all(
                                                    color: Colors.grey[100]!,
                                                    width: 0.5,
                                                  )),
                                              child: Text(
                                                "${data![i]..Category}",
                                                style: theme
                                                    .textTheme.titleMedium
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              width: width1,
                                              height:
                                                  Screens.bodyheight(context) *
                                                      0.05,
                                              decoration: BoxDecoration(
                                                  gradient:
                                                      const LinearGradient(
                                                          colors: [
                                                        const Color.fromARGB(
                                                            255, 61, 122, 228),
                                                        const Color.fromARGB(
                                                            255, 44, 96, 187)
                                                      ]),
                                                  border: Border.all(
                                                    color: Colors.grey[100]!,
                                                    width: 0.5,
                                                  )),
                                              child: Text(
                                                "${data![i].SubCategory}",
                                                overflow: TextOverflow.ellipsis,
                                                style: theme
                                                    .textTheme.titleMedium
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        height:
                                            Screens.bodyheight(context) * 0.08,
                                        width: width2,
                                        // color: Colors.grey[200],
                                        decoration: BoxDecoration(
                                            // color: Colors.grey,
                                            border: Border.all(
                                          color: Colors.black,
                                          width: 1,
                                        )),
                                        child: Text(
                                          "${totaldata![0].totalOrder}",
                                          style: theme.textTheme.titleMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      SizedBox(
                                        width: Screens.width(context) * 0.01,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        height:
                                            Screens.bodyheight(context) * 0.08,
                                        width: width2,
                                        // color: Colors.grey[200],
                                        decoration: BoxDecoration(
                                            // color: Colors.grey,
                                            border: Border.all(
                                          color: Colors.black,
                                          width: 1,
                                        )),
                                        child: Text(
                                          "${totaldata![0].outOfstock}",
                                          style: theme.textTheme.titleMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      SizedBox(
                                        width: Screens.width(context) * 0.01,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        height:
                                            Screens.bodyheight(context) * 0.08,
                                        width: width2,
                                        // color: Colors.grey[200],
                                        decoration: BoxDecoration(
                                            // color: Colors.grey,
                                            border: Border.all(
                                          color: Colors.black,
                                          width: 1,
                                        )),
                                        child: Text(
                                          "${totaldata![0].pendingAllo}",
                                          style: theme.textTheme.titleMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      SizedBox(
                                        width: Screens.width(context) * 0.01,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        height:
                                            Screens.bodyheight(context) * 0.08,
                                        width: width2,
                                        // color: Colors.grey[200],
                                        decoration: BoxDecoration(
                                            // color: Colors.grey,
                                            border: Border.all(
                                          color: Colors.black,
                                          width: 1,
                                        )),
                                        child: Text(
                                          "${totaldata![0].pendingDis}",
                                          style: theme.textTheme.titleMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      SizedBox(
                                        width: Screens.width(context) * 0.01,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        height:
                                            Screens.bodyheight(context) * 0.08,
                                        width: width2,
                                        // color: Colors.grey[200],
                                        decoration: BoxDecoration(
                                            // color: Colors.grey,
                                            border: Border.all(
                                          color: Colors.black,
                                          width: 1,
                                        )),
                                        child: Text(
                                          "${totaldata![0].lastSync}",
                                          style: theme.textTheme.titleMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Screens.bodyheight(context) * 0.01,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        height:
                                            Screens.bodyheight(context) * 0.06,
                                        width: width2,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            border: Border.all(
                                              color: Colors.black,
                                              width: 1,
                                            )),
                                        // color: Colors.grey[200],
                                        child: Text(
                                          "Total Order",
                                          style: theme.textTheme.titleMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      SizedBox(
                                        width: Screens.width(context) * 0.01,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        height:
                                            Screens.bodyheight(context) * 0.06,
                                        width: width2,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            border: Border.all(
                                              color: Colors.black,
                                              width: 1,
                                            )),
                                        // color: Colors.grey[200],
                                        child: Text(
                                          "Out of Stock Items",
                                          style: theme.textTheme.titleMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      SizedBox(
                                        width: Screens.width(context) * 0.01,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        height:
                                            Screens.bodyheight(context) * 0.06,
                                        width: width2,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            border: Border.all(
                                              color: Colors.black,
                                              width: 1,
                                            )),
                                        // color: Colors.grey[200],
                                        child: Text(
                                          "Pending Pickup",
                                          style: theme.textTheme.titleMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      SizedBox(
                                        width: Screens.width(context) * 0.01,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        height:
                                            Screens.bodyheight(context) * 0.06,
                                        width: width2,
                                        // color: Colors.grey[200],
                                        decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            border: Border.all(
                                              color: Colors.black,
                                              width: 1,
                                            )),
                                        child: Text(
                                          "Pending Dispatch",
                                          style: theme.textTheme.titleMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      SizedBox(
                                        width: Screens.width(context) * 0.01,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        height:
                                            Screens.bodyheight(context) * 0.06,
                                        width: width2,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            border: Border.all(
                                              color: Colors.black,
                                              width: 1,
                                            )),
                                        // color: Colors.grey[200],
                                        child: Text(
                                          "Last Sync",
                                          overflow: TextOverflow.ellipsis,
                                          style: theme.textTheme.titleMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
    );
  }
}
