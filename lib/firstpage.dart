import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tvc_all/api/login%20api/login%20api.dart';
import 'package:tvc_all/models/login%20model/loginmodel.dart';
import 'package:tvc_all/pages/despatchmain/screens/despatch.dart';
import 'package:tvc_all/pages/inwards/screens/inward.dart';
import 'package:tvc_all/pages/outward/screens/outward.dart';

import 'pages/binmatrix/screens/binmatrix.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Inward and Outward Screen',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home:  NavigationPage(),
//     );
//   }
// }

class NavigationPage extends StatefulWidget {
  NavigationPage({super.key});
  @override

  // ignore: library_private_types_in_public_api
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  @override
  void initState() {
    super.initState();
    log("firstpage called");
    loginapicall();
  }

  List<LoginItems> Logindatalist = [];

  loginapicall() async {
    log("binmatrix::");
    await GetLoginApi.getdata().then((value) {
      if (value.stcode == 200) {
        if (value.loginorder!.logindetails != null) {
          setState(() {
            Logindatalist = value.loginorder!.logindetails!;
            log(Logindatalist[0].DisplayId.toString());
            _navigateToSelectedPage();
          });
        }
      }
    });
  }

  // var loginapi = Logindatalist[i].DeviceID;

  String? _selectedPage;

  void _navigateToSelectedPage() {
    if (Logindatalist[0].DisplayId == 1) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const Openpo(
                    title: "Inwards",
                  )));
    } else if (Logindatalist[0].DisplayId == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const WmsBin()),
      );
    } else if (Logindatalist[0].DisplayId == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const WmsTVApp(
                  title: '',
                  despatchItems: [],
                  DespatchItems: [],
                )),
      );
    } else if (Logindatalist[0].DisplayId == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const BinMatrix()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a page first'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Inward and Outward Screen'),
      ),
      body: Column(
        children: [
          RadioListTile<String>(
            title: const Text('Inward'),
            value: 'Openpo',
            groupValue: _selectedPage,
            onChanged: (value) {
              setState(() {
                _selectedPage = value;
                _navigateToSelectedPage();
              });
            },
          ),
          RadioListTile<String>(
            title: const Text('Outward'),
            value: 'WmsBin',
            groupValue: _selectedPage,
            onChanged: (value) {
              setState(() {
                _selectedPage = value;
                _navigateToSelectedPage();
              });
            },
          ),
          RadioListTile<String>(
            title: const Text('Despatch'),
            value: 'WmsTVApp',
            groupValue: _selectedPage,
            onChanged: (value) {
              setState(() {
                _selectedPage = value;
                _navigateToSelectedPage();
              });
            },
          ),
          RadioListTile<String>(
            title: const Text('Bin matrix'),
            value: 'WmsMain',
            groupValue: _selectedPage,
            onChanged: (value) {
              setState(() {
                _selectedPage = value;
                _navigateToSelectedPage();
              });
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _navigateToSelectedPage,
            child: const Text(
              'Navigate to Selected Page',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
