import 'dart:async';
import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:tvc_all/api/despatch%20api/OpenDispatchApi.dart';
import 'package:tvc_all/open%20po/openpo%20constant/Screen.dart';

import '../../../models/despatch model/opendespatch.dart';

class WmsTVApp extends StatefulWidget {
  const WmsTVApp(
      {super.key,
      required this.title,
      required this.despatchItems,
      required List DespatchItems});

  final String title;
  final List<DespatchItem> despatchItems;

  @override
  State<WmsTVApp> createState() => _WmsTVAppState();
}

class _WmsTVAppState extends State<WmsTVApp> {
  List<DespatchItem> datas = [];

  // List<DispatchData>? DespatchItem = [];
  AudioPlayer audio = AudioPlayer(); //c
  bool apierror = false;
  bool nointernet = false;
  int count = 0;
  StreamSubscription? subscription;
  Timer? timer;
  @override
  void initState() {
    log("hiiii");
    super.initState();
    timer =
        Timer.periodic(const Duration(seconds: 10), (Timer t) => apiRefersh());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      datas.clear();
      connectivityAlert();
      apicall();
    });
  }

  apiRefersh() {
    setState(() {
      print("refresh");
      // playSound("neworder");
      datas.clear();
    });
    apicall();
  }

  apicall() async {
    GetdespatchfileApi.getdata().then((value) {
      if (value.statusCode == 200) {
        setState(() {
          apierror = false;
          datas = value.saleorder1!.itemdetails1!;
          print("datas ::::::::${datas.length}");
          count++;
        });
        // ignore: unnecessary_null_comparison
      } else {
        setState(() {
          apierror = true;
          // playSound("busonservernotconnecting");
        });
      }
    });
    // audio and signalr
    // playSound(String sound) {
    //   //c
    //   // audio.setAsset("Assets/$sound.mp3");
    //   // audio.play();
    // }
  }

  connectivityAlert() {
    apicall();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // double? width1 = Screens.width(context) * 0.25;
    return SafeArea(
      child: Scaffold(
        body: datas.isEmpty
            ? const Center(
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
                height: Screens.fullHeight(context),
                width: Screens.width(context),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: [
                        Container(
                          width: Screens.width(context) * 0.14,
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

                            // color: Colors.grey,

                            //     border: Border.all(
                            //   color: Colors.black,
                            //   width: 1,
                            // )
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
                            "Del.Pincode",
                            style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          width: Screens.width(context) * 0.24,
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
                            "Del.Area",
                            style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          width: Screens.width(context) * 0.22,
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
                            "Ready to Dispatch",
                            style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        // reverse: true,
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        //itemExtent: 30,
                        itemCount: datas.length,
                        itemBuilder: (context, int i) {
                          return Row(
                            children: [
                              Container(
                                // height:
                                //     MediaQuery.of(context).size.height * 0.040,
                                width: Screens.width(context) * 0.14,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 5.0,
                                      spreadRadius: 0.5,
                                      // offset: Offset(5.0, 5.0),
                                    ),
                                  ],
                                  color: Colors.white,
                                ),
                                child: Text(
                                  " ${datas[i].Brand}",
                                  // ${dataItem[i].pincode}  // Update field as needed
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                              Container(
                                width: Screens.width(context) * 0.20,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 5.0,
                                      spreadRadius: 0.5,
                                    ),
                                  ],
                                  color: Colors.white,
                                ),
                                child: Text(
                                  "${datas[i].SubCategory}",
                                  // ${dataItem[i].pincode}  // Update field as needed
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                              Container(
                                // height:
                                //     MediaQuery.of(context).size.height * 0.040,
                                width: Screens.width(context) * 0.20,
                                alignment: Alignment.center,
                                // margin: const EdgeInsets.symmetric(
                                //   vertical: 3.0,
                                // ),
                                decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 5.0,
                                      spreadRadius: 0.5,
                                    ),
                                  ],
                                  color: Colors.white,
                                ),
                                child: Text(
                                  "${datas[i].Del_Pincode}",
                                  // ${dataItem[i].pincode}  // Update field as needed
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                              Container(
                                width: Screens.width(context) * 0.24,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 5.0,
                                      spreadRadius: 0.5,
                                    ),
                                  ],
                                  color: Colors.white,
                                ),
                                child: Text(
                                  "${datas[i].Del_Area}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                              Container(
                                width: Screens.width(context) * 0.22,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 5.0,
                                      spreadRadius: 0.5,
                                      // offset: Offset(5.0, 5.0),
                                    ),
                                  ],
                                  color: Colors.white,
                                ),
                                child: Text(
                                  "${datas[i].Ready_To_Dispatch}",
                                  // ${dataItem[i].pincode}  // Update field as needed
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
