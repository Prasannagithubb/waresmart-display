import 'dart:async';
import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:tvc_all/api/outward%20api/gettextapi.dart';
import 'package:tvc_all/api/outward%20api/saleapimodel.dart';
import 'package:tvc_all/api/outward%20api/saleorderapi.dart';
import 'package:tvc_all/open%20po/openpo%20constant/Screen.dart';
import 'package:tvc_all/open%20po/openpo%20model/OrderModel.dart';

class WmsBin extends StatefulWidget {
  const WmsBin({super.key});

  @override
  State<WmsBin> createState() => _WmsBinState();
}

class _WmsBinState extends State<WmsBin> {
  AudioPlayer _audioPlayer = AudioPlayer();
  bool apierror = false;
  int count = 0;
  Timer? timer;

  @override
  void initState() {
    // log("hiiii");
    super.initState();
    timer =
        Timer.periodic(const Duration(seconds: 10), (Timer t) => apiRefersh());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // itemdet.clear();
      connectivityAlert();
    });
  }

  apiRefersh() {
    setState(() {
      print("refresh");
      // playSound("neworder");
      headdetails.clear();
    });
    apisaleorder();
  }

  List<SaleNewDetails> headdetails = [];

  apisaleorder() async {
    playasset();
    log("");
    await GetSalefileApi.getdata().then((value) {
      if (value.stcode == 200) {
        if (value.saleorder1!.itemdetails1 != null &&
            value.saleorder1!.itemdetails1!.isNotEmpty) {
          setState(() {
            headdetails = value.saleorder1!.itemdetails1!;
          });
        } else {
          log("not loaded,,,,,,");
        }
      }
    });
  }

  Future<void> playasset() async {
    // setState(() {

    await _audioPlayer.play(AssetSource('hiiiii.mp3'));
    _audioPlayer.resume();
    // });
  }

  connectivityAlert() {
    apicall();
  }

  apicall() {
    GetSaleDataAPi.getData().then((value) {
      if (value.statusCode == 200) {
        if (value.data != null) {
          setState(() {
            apierror = false;
            // dataItems = value.data;
            // data = dataItems;
            count++;
          });
        } else if (value.data == null) {
          setState(() {
            apierror = true;
            // playSound("busonservernotconnecting");
          });
          //playSound("nointernet");
        }
      } else {
        setState(() {
          apierror = true;
          // playSound("busonservernotconnecting");
        });
      }
    });

    // GetDataTotalAPi.getDataTotal().then((value) {
    //   if (value.StatusCode == 200) {
    //     if (value.items != null) {
    //       setState(() {
    //         apierror = false;
    //         totalItems = value.items;
    //         totaldata = totalItems;
    //         count++;
    //       });
    //     } else if (value.items == null) {
    //       // playSound("nointernet");
    //       setState(() {
    //         apierror = true;
    //         playSound("busonservernotconnecting");
    //       });
    //     }
    //   } else {
    //     // playSound("nointernet");
    //     setState(() {
    //       apierror = true;
    //       playSound("busonservernotconnecting");
    //     });
    //   }
    // }
  }

  List<orderData> saledetails = [];
  @override
  Widget build(BuildContext context) {
    // final finalist = headdetails.toList();
    headdetails.sort((a, b) => a.DocNumber!.compareTo(b.DocNumber!));
    int totalOrdered =
        headdetails.fold(0, (sum, item) => sum + item.Ordered!.toInt());
    int totalAllocated =
        headdetails.fold(0, (sum, item) => sum + item.Allocated!.toInt());
    int readytodespatch = headdetails.fold(
        0, (sum, item) => sum + item.Ready_To_Dispatch!.toInt());
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: headdetails.isEmpty
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
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
            : SizedBox(
                height: double.infinity,
                width: Screens.width(context),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Container(
                          width: Screens.width(context) * 0.08,
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
                            "Doc.No",
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

                            // color: Colors.grey,

                            //     border: Border.all(
                            //   color: Colors.black,
                            //   width: 1,
                            // )
                          ),
                          child: Text(
                            "Customer Name",
                            style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),

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
                          ),
                          child: Text(
                            "Del.Area",
                            style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        // Container(
                        //   alignment: Alignment.center,
                        //   width: width1,
                        //   height: Screens.bodyheight(context) * 0.05,
                        //   decoration: BoxDecoration(
                        //       // color: Colors.grey,
                        //       border: Border.all(
                        //     color: Colors.black,
                        //     width: 1,
                        //   )),
                        //   child: Text(
                        //     "Brand",
                        //     style: theme.textTheme.subtitle1
                        //         ?.copyWith(fontWeight: FontWeight.w500),
                        //   ),
                        // ),

                        Container(
                          width: Screens.width(context) * 0.10,
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
                          width: Screens.width(context) * 0.06,
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
                          width: Screens.width(context) * 0.12,
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
                          width: Screens.width(context) * 0.07,
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
                            "Ordered",
                            style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),

                        Container(
                          width: Screens.width(context) * 0.08,
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
                              ])),
                          child: Text(
                            "Allocated",
                            style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),

                        Container(
                          width: Screens.width(context) * 0.13,
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
                            "Rdy to Despatch",
                            style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        // Container(
                        //   width: Screens.width(context) * 0.08,
                        //   height: Screens.bodyheight(context) * 0.05,
                        //   alignment: Alignment.center,
                        //   decoration: BoxDecoration(
                        //     boxShadow: [
                        //       BoxShadow(
                        //         color: Colors.grey[100]!,
                        //         blurRadius: 15.0, // soften the shadow
                        //         spreadRadius: 5.0, //extend the shadow
                        //         offset: const Offset(
                        //           5.0, // Move to right 5  horizontally
                        //           5.0, // Move to bottom 5 Vertically
                        //         ),
                        //       )
                        //     ],
                        //     // color: Colors.white
                        //     gradient: const LinearGradient(colors: [
                        //       Color.fromARGB(255, 61, 122, 228),
                        //       Color.fromARGB(255, 44, 96, 187)
                        //     ]),
                        //   ),
                        //   child: Text(
                        //     "Ord.St",
                        //     style: theme.textTheme.titleMedium?.copyWith(
                        //         color: Colors.white,
                        //         fontWeight: FontWeight.w500),
                        //   ),
                        // ),

                        //   alignment: Alignment.center,
                        //   width: Screens.width(context) * 0.17,
                        //   height: Screens.bodyheight(context) * 0.05,
                        //   decoration: BoxDecoration(
                        //       // color: Colors.grey,
                        //       border: Border.all(
                        //     color: Colors.black,
                        //     width: 1,
                        //   )),
                        //   child: Text(
                        //     "Model",
                        //     style: theme.textTheme.subtitle1
                        //         ?.copyWith(fontWeight: FontWeight.w500),
                        //   ),
                        // ),

                        //   width: Screens.width(context) * 0.045,
                        //   height: Screens.bodyheight(context) * 0.05,
                        //   alignment: Alignment.center,
                        //   decoration: BoxDecoration(
                        //     boxShadow: [
                        //       BoxShadow(
                        //         color: Colors.grey[100]!,
                        //         blurRadius: 15.0, // soften the shadow
                        //         spreadRadius: 5.0, //extend the shadow
                        //         offset: const Offset(
                        //           5.0, // Move to right 5  horizontally
                        //           5.0, // Move to bottom 5 Vertically
                        //         ),
                        //       )
                        //     ],
                        //     // color: Colors.white
                        //     gradient: const LinearGradient(colors: [
                        //       Color.fromARGB(255, 61, 122, 228),
                        //       Color.fromARGB(255, 44, 96, 187)
                        //     ]),

                        //     // color: Colors.grey,

                        //     //     border: Border.all(
                        //     //   color: Colors.black,
                        //     //   width: 1,
                        //     // )
                        //   ),
                        //   child: Text(
                        //     "Area",
                        //     style: theme.textTheme.subtitle1?.copyWith(
                        //         color: Colors.white, fontWeight: FontWeight.w500),
                        //   ),
                        // ),
                        // Container(
                        //   alignment: Alignment.center,
                        // width: Screens.width(context) * 0.15,
                        // height: Screens.bodyheight(context) * 0.05,
                        //   decoration: BoxDecoration(
                        //       // color: Colors.grey,
                        //       border: Border.all(
                        //     color: Colors.black,
                        //     width: 1,
                        //   )),
                        //   child: Text(
                        //     "Area",
                        //     style: theme.textTheme.subtitle1
                        //         ?.copyWith(fontWeight: FontWeight.w500),
                        //   ),
                        // ),

                        // Container(
                        //   width: width1,
                        //   height: Screens.bodyheight(context) * 0.05,
                        //   alignment: Alignment.center,
                        //   decoration: BoxDecoration(
                        //     boxShadow: [
                        //       BoxShadow(
                        //         color: Colors.grey[100]!,
                        //         blurRadius: 15.0, // soften the shadow
                        //         spreadRadius: 5.0, //extend the shadow
                        //         offset: const Offset(
                        //           5.0, // Move to right 5  horizontally
                        //           5.0, // Move to bottom 5 Vertically
                        //         ),
                        //       )
                        //     ],
                        //     // color: Colors.white
                        //     gradient: const LinearGradient(colors: [
                        //       Color.fromARGB(255, 61, 122, 228),
                        //       Color.fromARGB(255, 44, 96, 187)
                        //     ]),

                        //     // color: Colors.grey,
                      ],
                    ),
                    Container(
                      height: (Screens.bodyheight(context) -
                          Screens.bodyheight(context) * 0.04),
                      width: Screens.width(context),
                      // color: Colors.blue,
                      child: ListView.builder(
                        reverse: true,
                        // shrinkWrap: true,
                        // reverse: true,
                        // padding:
                        //     EdgeInsets.only(top: Screens.bodyheight(context) * 0.00),
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        //itemExtent: 30,
                        itemCount: headdetails.length,
                        itemBuilder: (context, int i) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                // color: Colors.amber,
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * 0.030,
                                child: Row(
                                  // width: Screens.width(context) * 0.06,
                                  children: [
                                    Container(
                                      // height:
                                      //     MediaQuery.of(context).size.height * 0.040,
                                      width: Screens.width(context) * 0.080,

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
                                      // margin: EdgeInsets.symmetric(
                                      //   vertical: 3.0,
                                      // ),
                                      child: Text(
                                        "${headdetails[i].DocNumber}",
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
                                      width: Screens.width(context) * 0.22,
                                      alignment: Alignment.centerLeft,
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
                                      // margin: EdgeInsets.symmetric(
                                      //   vertical: 3.0,
                                      // ),
                                      child: Text(
                                        " ${headdetails[i].CustomerName}",
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
                                      width: Screens.width(context) * 0.14,

                                      alignment: Alignment.centerLeft,
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
                                      // margin: EdgeInsets.symmetric(
                                      //   vertical: 3.0,
                                      // ),
                                      child: Text(
                                        "${headdetails[i].Del_Area}",
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
                                      width: Screens.width(context) * 0.10,
                                      alignment: Alignment.centerLeft,
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
                                        "${headdetails[i].Del_Pincode}",
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
                                      width: Screens.width(context) * 0.06,

                                      alignment: Alignment.centerLeft,
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
                                      // margin: EdgeInsets.symmetric(
                                      //   vertical: 3.0,
                                      // ),
                                      child: Text(
                                        "${headdetails[i].Brand}",
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
                                      width: Screens.width(context) * 0.12,

                                      alignment: Alignment.centerLeft,
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
                                      // margin: EdgeInsets.symmetric(
                                      //   vertical: 3.0,
                                      // ),
                                      child: Text(
                                        " ${headdetails[i].SubCategory}",
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
                                      width: Screens.width(context) * 0.07,
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
                                      // margin: EdgeInsets.symmetric(
                                      //   vertical: 3.0,
                                      // ),
                                      child: Text(
                                        "${headdetails[i].Ordered}",
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
                                      width: Screens.width(context) * 0.08,

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
                                      // margin: EdgeInsets.symmetric(
                                      //   vertical: 3.0,
                                      // ),
                                      child: Text(
                                        "${headdetails[i].Allocated}",
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
                                      width: Screens.width(context) * 0.13,
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
                                      // margin: EdgeInsets.symmetric(
                                      //   vertical: 3.0,
                                      // ),
                                      child: Text(
                                        "${headdetails[i].Ready_To_Dispatch}",
                                        // ${dataItem[i].pincode}  // Update field as needed
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1
                                            ?.copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                    // Container(
                                    //   // height:
                                    //   //     MediaQuery.of(context).size.height * 0.040,
                                    //   width: Screens.width(context) * 0.07,
                                    //   alignment: Alignment.centerLeft,
                                    //   decoration: const BoxDecoration(
                                    //     boxShadow: [
                                    //       BoxShadow(
                                    //         color: Colors.grey,
                                    //         blurRadius: 5.0,
                                    //         spreadRadius: 0.5,
                                    //       ),
                                    //     ],
                                    //     color: Colors.white,
                                    //   ),
                                    //   // margin: EdgeInsets.symmetric(
                                    //   //   vertical: 3.0,
                                    //   // ),
                                    //   child: Text(
                                    //     "${headdetails[i].CustomerName}",
                                    //     // ${dataItem[i].pincode}  // Update field as needed
                                    //     style: Theme.of(context)
                                    //         .textTheme
                                    //         .titleMedium
                                    //         ?.copyWith(
                                    //           color: Colors.black,
                                    //           fontWeight: FontWeight.w500,
                                    //         ),
                                    //   ),
                                    // ),
                                    // Container(
                                    //   // height:
                                    //   //     MediaQuery.of(context).size.height * 0.040,
                                    //   width: Screens.width(context) * 0.08,
                                    //   alignment: Alignment.centerLeft,
                                    //   decoration: const BoxDecoration(
                                    //     boxShadow: [
                                    //       BoxShadow(
                                    //         color: Colors.grey,
                                    //         blurRadius: 5.0,
                                    //         spreadRadius: 0.5,
                                    //       ),
                                    //     ],
                                    //     color: Colors.white,
                                    //   ),
                                    //   // margin: EdgeInsets.symmetric(
                                    //   //   vertical: 3.0,
                                    //   // ),
                                    //   child: Text(
                                    //     "${headdetails[i].CustomerName}",
                                    //     // ${dataItem[i].pincode}  // Update field as needed
                                    //     style: Theme.of(context)
                                    //         .textTheme
                                    //         .titleMedium
                                    //         ?.copyWith(
                                    //           color: Colors.black,
                                    //           fontWeight: FontWeight.w500,
                                    //         ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                              // Row(
                              //   children: [
                              //     Container(
                              //       width: Screens.width(context) * 0.68,
                              //       height: Screens.bodyheight(context) * 0.03,
                              //       alignment: Alignment.centerLeft,
                              //       decoration: const BoxDecoration(
                              //         boxShadow: [
                              //           // BoxShadow(
                              //           //   color: Colors.grey[100]!,
                              //           //   blurRadius: 15.0, // soften the shadow
                              //           //   spreadRadius: 5.0, //extend the shadow
                              //           //   offset: const Offset(
                              //           //     5.0, // Move to right 5  horizontally
                              //           //     5.0, // Move to bottom 5 Vertically
                              //           //   ),
                              //           // )
                              //         ],
                              //         // color: Colors.white
                              //         // gradient: LinearGradient(colors: [
                              //         //   Color.fromARGB(255, 61, 122, 228),
                              //         //   Color.fromARGB(255, 44, 96, 187)
                              //         // ]),

                              //         color: Colors.white,

                              //         //     border: Border.all(
                              //         //   color: Colors.black,
                              //         //   width: 1,
                              //         // )
                              //       ),
                              //       child: Row(
                              //         children: [
                              //           Text(
                              //             " Item name : ",
                              //             style: theme.textTheme.titleMedium
                              //                 ?.copyWith(
                              //                     color: Colors.black,
                              //                     fontWeight: FontWeight.w500),
                              //           ),
                              //           Text(
                              //             " JMS-RMD-COT-WOODEN JWC-K-SQR-01-MAHAGONY 6 1 /2X5",
                              //             style: theme.textTheme.titleMedium
                              //                 ?.copyWith(
                              //                     color: Colors.grey.shade500,
                              //                     fontWeight: FontWeight.w500),
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //     Container(
                              //       width: Screens.width(context) * 0.32,
                              //       height: Screens.bodyheight(context) * 0.03,
                              //       alignment: Alignment.centerLeft,
                              //       decoration: const BoxDecoration(
                              //         // boxShadow: [
                              //         //   // BoxShadow(
                              //         //   //   color: Colors.grey[100]!,
                              //         //   //   blurRadius: 15.0, // soften the shadow
                              //         //   //   spreadRadius: 5.0, //extend the shadow
                              //         //   //   offset: const Offset(
                              //         //   //     5.0, // Move to right 5  horizontally
                              //         //   //     5.0, // Move to bottom 5 Vertically
                              //         //   //   ),
                              //         //   // )
                              //         // ],

                              //         // gradient: LinearGradient(colors: [
                              //         //   Color.fromARGB(255, 85, 143, 244),
                              //         //   Color.fromARGB(255, 92, 147, 241)
                              //         // ]),

                              //         color: Colors.white,

                              //         //     border: Border.all(
                              //         //   color: Colors.black,
                              //         //   width: 1,
                              //         // )
                              //       ),
                              //       child: Row(
                              //         children: [
                              //           Text(
                              //             "Qty :",
                              //             style: theme.textTheme.titleMedium
                              //                 ?.copyWith(
                              //                     color: Colors.black,
                              //                     fontWeight: FontWeight.w500),
                              //           ),
                              //           Text(
                              //             "22",
                              //             style: theme.textTheme.titleMedium
                              //                 ?.copyWith(
                              //                     color: Colors.grey.shade500,
                              //                     // fontSize: 14,
                              //                     fontWeight: FontWeight.w500),
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // const SizedBox(
                              //   height: 10,
                              // ),
                              // const Divider(
                              //   height: 1.0,
                              //   color: Colors.black26,
                              // ),
                            ],
                          );
                        },
                      ),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      Container(
                        width: Screens.width(context) * 0.12,
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
                          "Total",
                          style: theme.textTheme.titleMedium?.copyWith(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        width: Screens.width(context) * 0.07,
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
                          "$totalOrdered",
                          style: theme.textTheme.titleMedium?.copyWith(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        width: Screens.width(context) * 0.08,
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
                          "$totalAllocated",
                          style: theme.textTheme.titleMedium?.copyWith(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        width: Screens.width(context) * 0.13,
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
                          "$readytodespatch",
                          style: theme.textTheme.titleMedium?.copyWith(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
      ),
    );
  }
}
