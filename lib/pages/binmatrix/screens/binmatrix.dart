import 'dart:async';
import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:tvc_all/api/binmatrix%20api/binapi.dart';
import 'package:tvc_all/open%20po/openpo%20constant/Screen.dart';

import '../../../models/binmatrix model/binmatrix.dart';

class BinMatrix extends StatefulWidget {
  const BinMatrix({super.key});

  @override
  State<BinMatrix> createState() => _BinMatrixState();
}

class _BinMatrixState extends State<BinMatrix> {
  AudioPlayer _audioPlayer = AudioPlayer();
  List<Binmatrixdata> binmatrixlist = [];
  Timer? timer;

  @override
  void initState() {
    log("hiiii");
    super.initState();
    timer =
        Timer.periodic(const Duration(seconds: 10), (Timer t) => apiRefersh());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  apiRefersh() {
    setState(() {
      print("refresh");
      // playSound("neworder");
      binmatrixlist.clear();
    });
    binmatrixapicall();
  }

  binmatrixapicall() async {
    playasset();
    log("binmatrix::");
    await GetBinmatrixApi.getdata().then((value) {
      if (value.stcode == 200) {
        if (value.itemdetails != null) {
          setState(() {
            binmatrixlist = value.itemdetails!.table2;
          });
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: binmatrixlist.isEmpty
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
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Container(
                          width: Screens.bodyheight(context) * 0.25,
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
                            "AreaCode",
                            style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          width: Screens.width(context) * 0.106,
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
                            "ZoneCode",
                            style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          width: Screens.width(context) * 0.15,
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
                            "RackCode",
                            style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          width: Screens.width(context) * 0.15,
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
                            "BinCode",
                            style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
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

                            // color: Colors.grey,

                            //     border: Border.all(
                            //   color: Colors.black,
                            //   width: 1,
                            // )
                          ),
                          child: Text(
                            "Status",
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
                            ]),
                          ),
                          child: Text(
                            "Capacity",
                            style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          width: Screens.width(context) * 0.15,
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
                            "BinStk",
                            style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          width: Screens.width(context) * 0.132,
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
                            "Space_Available",
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
                        itemCount: binmatrixlist.length,
                        itemBuilder: (context, int i) {
                          return SizedBox(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.036,
                            child: Row(
                              // width: Screens.width(context) * 0.06,
                              children: [
                                Container(
                                  width: Screens.bodyheight(context) * 0.24,
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
                                    " ${binmatrixlist[i].AreaCode}",
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
                                  width: Screens.width(context) * 0.106,

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
                                    "${binmatrixlist[i].ZoneCode}",
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
                                  width: Screens.width(context) * 0.15,
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
                                    "${binmatrixlist[i].RackCode}",
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
                                  width: Screens.width(context) * 0.15,

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
                                    "${binmatrixlist[i].BinCode}",
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
                                    "${binmatrixlist[i].Status}",
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
                                // height:
                                //       MediaQuery.of(context).size.height * 0.010,
                                //   width: Screens.width(context) * 0.08,
                                Container(
                                  // height:
                                  //     MediaQuery.of(context).size.height * 0.040,
                                  width: Screens.width(context) * 0.08,
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
                                    "${binmatrixlist[i].Capacity}",
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
                                  width: Screens.width(context) * 0.15,
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
                                    "${binmatrixlist[i].BinStk}",
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
                                  width: Screens.width(context) * 0.133,

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
                                    "${binmatrixlist[i].Space_Available}",
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
                            ),
                          );
                        },
                      ),
                    ),
                    const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // for (int i = 0; i < itemdet.length; i++)
                          // Container(
                          //   width: Screens.width(context) * 0.2,
                          //   height: Screens.bodyheight(context) * 0.05,
                          //   alignment: Alignment.centerLeft,
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
                          //     "  No.of Quantity : $totalQuantity",
                          //     style: theme.textTheme.titleMedium?.copyWith(
                          //         color: Colors.white, fontWeight: FontWeight.w500),
                          //   ),
                          // ),
                          // Container(
                          //   width: Screens.width(context) * 0.2,
                          //   height: Screens.bodyheight(context) * 0.05,
                          //   alignment: Alignment.centerLeft,
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
                          //     "  No.of count : ${itemdet.length}",
                          //     style: theme.textTheme.titleMedium?.copyWith(
                          //         color: Colors.white, fontWeight: FontWeight.w500),
                          //   ),
                          // ),
                        ]),
                  ],
                ),
              ),
      ),
    );
    ;
  }
}
