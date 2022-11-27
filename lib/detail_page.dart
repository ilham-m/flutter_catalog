import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:katalog/trolley_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.menuItem});
  final Map<String, dynamic> menuItem;
  @override
  State<StatefulWidget> createState() => _DetailPage();
}

class _DetailPage extends State<DetailPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  bool trolleyLoading = false;
  void _confirm(BuildContext context, dynamic value) {
    var msg = jsonDecode(value.body)["data"];
    showDialog(
        context: context,
        builder: (BuildContext contextTrolley) {
          return AlertDialog(
            title: Text(msg),
            titlePadding: const EdgeInsets.all(25),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(contextTrolley, '');
                    Route route =
                        MaterialPageRoute(builder: (context) => TrolleyPage());
                    Navigator.push(context, route);
                  },
                  child: const Text("Lihat Trolley")),
              TextButton(
                  onPressed: () => Navigator.pop(contextTrolley, ''),
                  child: const Text("Batal"))
            ],
          );
        });
  }

  void _onErrorPopup(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext contextTrolley) {
          return const SimpleDialog(
            title: Text("Gagal menambahkan ke trolley"),
            titlePadding: EdgeInsets.all(25),
          );
        });
  }

  Future<http.Response> addToTrolleyJson(BuildContext context) async {
    return http.post(Uri.parse("http://127.0.0.1:8000/api/post/trolley"),
        body: {"menu_id": widget.menuItem["id"].toString()});
    // .then((value) => {_confirm(context)})
    // .onError((e, _) {
    //   _onErrorPopup(context);
    //   throw '';
    // });
  }

  void _addToTrolley(BuildContext context) {
    Widget alertTitle = const Text("Tambah ke trolley");
    Widget? alertContent = const Text("Tambah kan produk ini ke keranjang");
    showDialog(
        context: context,
        builder: (BuildContext contextTrolley) {
          return AlertDialog(
            title: alertTitle,
            content: alertContent,
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(contextTrolley, '');
                    setState(() {
                      trolleyLoading = true;
                    });
                    addToTrolleyJson(context).then((value) {
                      setState(() {
                         trolleyLoading = false;
                      });
                      _confirm(context, value);
                    });
                  },
                  child: const Text("Tambah")),
              TextButton(
                  onPressed: () => Navigator.pop(contextTrolley, ''),
                  child: const Text("Batal"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double windowWidth = size.width;
    final double windowheight = size.height;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Detail Product'),
        centerTitle: true,
        leading: const BackButton(),
        actions: [
          TextButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              style: const ButtonStyle(
                  foregroundColor: MaterialStatePropertyAll(
                      Color.fromARGB(255, 255, 255, 255))),
              icon: const Icon(Icons.search),
              label: const Text('')),
        ],
      ),
      body: trolleyLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network(
                    widget.menuItem["image_path"],
                    fit: BoxFit.cover,
                    height: windowheight * 2 / 5,
                    width: windowWidth,
                    alignment: Alignment.center,
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    title: Text(widget.menuItem["name"]),
                    subtitle: Text("Rp ${widget.menuItem["price"]},-"),
                    minLeadingWidth: 10,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: windowWidth,
                    child: Text(
                      widget.menuItem["description"],
                    ),
                  )
                ],
              ),
            )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addToTrolley(context);
        },
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
