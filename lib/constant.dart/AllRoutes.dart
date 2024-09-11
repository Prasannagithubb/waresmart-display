// ignore_for_file: prefer_const_constructors
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:tvc_all/login.dart';

import 'ConstantRoutes.dart';

class Routes {
  static List<GetPage> allRoutes = [
    GetPage<dynamic>(
        name: ConstantRoutes.login,
        page: () => LoginPage(),
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),
  ];
}
