import 'package:flutter/material.dart';

import 'Screen.dart';

class Constant {
  static String appVersion = '1.0.0';

  void showDialogBox(String title, String msg, BuildContext context) {
    //print("object");
    showDialog<dynamic>(
      context: context,
      builder: (context) {
        // String contentText = "Content of Dialog";
        return StatefulBuilder(
          builder: (context, setState) {
            final theme = Theme.of(context);
            return AlertDialog(
              title: Center(
                  child: Text(
                "$title",
                style: theme.textTheme.headline6?.copyWith(
                    color: title.toLowerCase().contains('succes')
                        ? Colors.green
                        : title.toLowerCase().contains('warning')
                            ? Colors.yellow[700]
                            : Colors.red),
              )),
              content: Container(
                //  color: Colors.black12,
                // height: Screens.heigth(context) * 0.4,
                width: Screens.width(context) * 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "$msg",
                      style: theme.textTheme.bodyText1
                          ?.copyWith(), //color: Colors.grey
                    ),
                    SizedBox(
                      height: Screens.bodyheight(context) * 0.01,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
