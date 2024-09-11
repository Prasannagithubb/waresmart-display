import 'package:flutter/material.dart';
import 'package:tvc_all/pages/despatchmain/screens/despatch.dart';
import 'package:tvc_all/pages/outward/screens/outward.dart';
import 'package:tvc_all/wms%20main/screens/wmsmain.dart';

class Configiration extends StatefulWidget {
  const Configiration({super.key});

  @override
  State<Configiration> createState() => _ConfigirationState();
}

class _ConfigirationState extends State<Configiration> {
  int _selectedRadio = 0;
  final TextEditingController _customerIDController = TextEditingController();
  final TextEditingController _whrCodeController = TextEditingController();

  void _handleRadioValueChange(int? value) {
    setState(() {
      _selectedRadio = value ?? 0;
    });

    switch (_selectedRadio) {
      case 0:
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => const Openpo(
        //             title: 'TVC',
        //             dataItems: [],
        //           )),
        // );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const WmsMain(
                    title: 'TVC',
                  )),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const WmsTVApp(
                    title: 'TVC',
                    DespatchItems: [],
                    despatchItems: [],
                  )),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const WmsBin()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuration Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Customer ID',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _customerIDController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16), // Add space between the fields
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'WHR Code',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _whrCodeController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 34),
            Center(
              child: SizedBox(
                height: 250,
                width: 350,
                child: Column(
                  children: [
                    RadioListTile<int>(
                      title: const Text(
                        'Open PO',
                        style: TextStyle(fontSize: 18),
                      ),
                      value: 0,
                      groupValue: _selectedRadio,
                      onChanged: _handleRadioValueChange,
                      activeColor: const Color.fromARGB(255, 173, 190, 203),
                    ),
                    const Divider(),
                    RadioListTile<int>(
                      title: const Text(
                        'Sales Order',
                        style: TextStyle(fontSize: 18),
                      ),
                      value: 1,
                      groupValue: _selectedRadio,
                      onChanged: _handleRadioValueChange,
                      activeColor: Colors.blue,
                    ),
                    const Divider(),
                    RadioListTile<int>(
                      title: const Text(
                        'Open Despatch',
                        style: TextStyle(fontSize: 18),
                      ),
                      value: 2,
                      groupValue: _selectedRadio,
                      onChanged: _handleRadioValueChange,
                      activeColor: Colors.blue,
                    ),
                    const Divider(),
                    RadioListTile<int>(
                      title: const Text(
                        'Bin Math',
                        style: TextStyle(fontSize: 18),
                      ),
                      value: 3,
                      groupValue: _selectedRadio,
                      onChanged: _handleRadioValueChange,
                      activeColor: Colors.blue,
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
