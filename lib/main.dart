import 'package:flutter/material.dart';
import 'package:tvc_all/login.dart';

void main() {
  runApp((const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Big Display',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            primary: Colors.deepPurple,
            secondary: Colors.amber,
          ),
          useMaterial3: true,
          textTheme: Typography.englishLike2018
              .apply(bodyColor: Colors.black, displayColor: Colors.black),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.deepPurple,
          ),
        ),
        home: const LoginPage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.title, style: Theme.of(context).textTheme.titleLarge),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16.0),
              Text(
                '$_counter',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}


// WmsTVApp(
//         title: '',
//         DespatchItems: [
//           DespatchItem(
//               route: 'Forex',
//               area: 'Coimbatore',
//               pincode: "659038",
//               items: "1"),
//           DespatchItem(
//               route: 'cintex', area: 'Trichy', pincode: "659976", items: "2"),
//           DespatchItem(
//               route: 'todec', area: 'Madurai', pincode: "659273", items: "3"),
//           DespatchItem(
//               route: 'qurtex', area: 'Lavaram', pincode: "659646", items: "4"),
//         ],
//       ),