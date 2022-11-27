import 'package:flutter/material.dart';
import 'package:katalog/menu.dart';
import 'package:katalog/search_page.dart';
import 'package:katalog/trolley_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter List View',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'Flutter List View'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedindex = 0;
  int _currentIndex = 0;
  final List<Widget> mainMenu = [const MenuPage(), TrolleyPage()];
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double windowWidth = size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        leading: const FlutterLogo(),
        actions: [
          TextButton.icon(
              onPressed: () {
                 Route route =
                        MaterialPageRoute(builder: (context) => TrolleyPage());
                    Navigator.push(context, route);
              },
              style: const ButtonStyle(foregroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 255, 255, 255)) ),
              icon: const Icon(Icons.shopping_cart),
              label: const Text('')),
        ],
      ),
      body: mainMenu[_currentIndex],
      
    );
  }
}
