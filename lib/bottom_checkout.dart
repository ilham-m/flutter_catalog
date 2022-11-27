import 'dart:developer';

import 'package:flutter/material.dart';

class BottomCheckout extends StatefulWidget {
  const BottomCheckout({super.key, required this.priceList});

  final Map<String, int> priceList;

  @override
  State<StatefulWidget> createState() => _BottomCheckoutState();
}

class _BottomCheckoutState extends State<BottomCheckout> {
  int _totalPrice = 0;
  @override
  void initState() {
    super.initState();
    int tempPrice = 0;
    if (widget.priceList.isNotEmpty) {
      for (var v in widget.priceList.values) {
        tempPrice += v;
      }
      setState(() {
        print(tempPrice);
        _totalPrice = tempPrice;
      });
    }
    print(widget.priceList);
  }

  @override
  Widget build(BuildContext context) {
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
                    "Rp. $_totalPrice,-",
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  )
                ],
              )),
              Expanded(
                  child: ElevatedButton(
                onPressed: () {},
                child: const Text("Bayar"),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
