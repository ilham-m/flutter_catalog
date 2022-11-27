import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:katalog/detail_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<StatefulWidget> createState() => _MenuPage();
}

class _MenuPage extends State<MenuPage> {
  late List<dynamic> catalogList;

  Future<List<dynamic>> loadData() async {
    var result = await http.get(Uri.parse('http://127.0.0.1:8000/api/menu'));
    // inspect(result);
    if (result.statusCode >= 400) {
      return List<dynamic>.empty();
    }
    return jsonDecode(result.body)["data"]["menu"];
  }

  void onError(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext contextTrolley) {
          return const SimpleDialog(
            title: Text("gagal mendapatkan data"),
            titlePadding: EdgeInsets.all(25),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const SnackBar(
                content: Text('Gagal mendapat data'),
              );
            }
            if (snapshot.data == null || snapshot.data.isEmpty) {
              return const SnackBar(
                content: Text('Gagal mendapat data'),
              );
            }
            // inspect(snapshot.data!);
            //setState(() {
            catalogList = snapshot.data!;
            //});
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 5, bottom: 10),
                        child: Text("our menu"),
                      ),
                      GridView.count(
                        crossAxisCount: 3,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        shrinkWrap: true,
                        children: [
                          for (Map<String, dynamic> item in catalogList) ...[
                            GestureDetector(
                              onTap: () {
                                Route route = MaterialPageRoute(
                                    builder: (context) =>
                                        DetailPage(menuItem: item));
                                Navigator.push(context, route);
                              },
                              child: Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        child: Image.network(
                                      item["image_path"],
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    )),
                                    Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item["name"],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10),
                                            ),
                                            Text(
                                              "Rp ${item["price"]},-",
                                              style:
                                                  const TextStyle(fontSize: 8),
                                            )
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                            )
                          ]
                        ],
                      )
                    ],
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
