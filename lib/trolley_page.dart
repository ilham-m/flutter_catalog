import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:katalog/bottom_checkout.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:counter_button/counter_button.dart';
import 'package:katalog/counter_button.dart';

class TrolleyPage extends StatefulWidget {
  const TrolleyPage({super.key});

  @override
  State<StatefulWidget> createState() => _TrolleyState();
}

class _TrolleyState extends State<TrolleyPage> {
  List<dynamic>? _listTrolley;
  bool loading = true;
  Future<List<dynamic>> loadData() async {
    var result = await http.get(Uri.parse('http://127.0.0.1:8000/api/trolley'));
    // inspect(result);
    if (result.statusCode >= 400) {
      return List<dynamic>.empty();
    }
    return jsonDecode(result.body)["data"]["trolley"];
  }

  void _confirmTrolleyClear(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext contextTrolley) {
          return const SimpleDialog(
            title: Text("trolley berhasil di kosongkan"),
            titlePadding: EdgeInsets.all(25),
          );
        });
    getData();
  }

  void _confirmTrolleyPay(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext contextTrolley) {
          return const SimpleDialog(
            title: Text("pembayaran berhasil"),
            titlePadding: EdgeInsets.all(25),
          );
        });
    getData();
  }

  @override
  void initState() {
    super.initState();

    // initial load
    getData();
  }

  void getData() async {
    setState(() {
      loading = true;
    });
    var result = await loadData();
    setState(() {
      _listTrolley = result;
      loading = false;
    });
  }

  Future<http.Response> clearTrolley() {
    return http.get(Uri.parse("http://127.0.0.1:8000/api/clear/trolley"));
  }

  int priceCount(int price, Map<String, int> qtyList, int productId) {
    if (!qtyList.containsKey(productId.toString())) return price;
    if (qtyList[productId.toString()]! <= 0) return price;
    return (price * qtyList[productId.toString()]!);
  }

  Map<String, int> _productCounter = {};
  Map<String, int> _finalPrice = {};
  var _finalPrice2 = ValueNotifier<Map<String, int>>({});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Keranjang Mu"),
        leading: const BackButton(),
        actions: [
          TextButton.icon(
              onPressed: () {
                setState(() {
                  loading = true;
                });
                clearTrolley().then((value) => _confirmTrolleyClear(context));
              },
              style: const ButtonStyle(
                  foregroundColor: MaterialStatePropertyAll(
                      Color.fromARGB(255, 255, 255, 255))),
              icon: const Icon(Icons.delete_outline),
              label: const Text('')),
        ],
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _listTrolley == null || _listTrolley!.isEmpty
              ? const Center(child: Text("Trolley kosong"))
              : Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListView(
                    children: [
                      for (var item in _listTrolley!) ...[
                        Card(
                          child: ListTile(
                              leading: Image.network(item["image_path"],
                                  width: 50, fit: BoxFit.cover),
                              title: Text(item["name"]),
                              subtitle: Text(
                                  "Rp. ${_finalPrice.containsKey(item["id"].toString()) ? _finalPrice[item["id"].toString()] : item["price"]},-"),
                              trailing: SizedBox(
                                height: double.infinity,
                                width: 70,
                                child: ButtonCounterCustom(
                                  currentCounter: (int val) {
                                    setState(() {
                                      _productCounter[item["id"].toString()] =
                                          val;
                                      _finalPrice[item["id"].toString()] =
                                          priceCount(item["price"],
                                              _productCounter, item["id"]);
                                      _finalPrice2.value = _finalPrice;
                                    });
                                  },
                                  startCounter: _productCounter[
                                              item["id"].toString()] !=
                                          null
                                      ? _productCounter[item["id"].toString()]!
                                      : 0,
                                ),
                              )),
                        ),
                      ]
                    ],
                  ),
                ),
      bottomNavigationBar: ValueListenableBuilder(
          valueListenable: _finalPrice2,
          builder: (context, value, child) {
            int tempPrice = 0;
            int totalPrice = 0;
            for (var v in value.values) {
              tempPrice += v;
            }
            totalPrice = tempPrice;
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Total Harga"),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Rp. $totalPrice,-",
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          )
                        ],
                      )),
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          clearTrolley().then((value) {
                            setState(() {
                              _finalPrice = {};
                              _productCounter = {};
                              _finalPrice2.value = {};
                            });
                            _confirmTrolleyPay(context);
                          });
                        },
                        child: const Text("Bayar"),
                      ))
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
