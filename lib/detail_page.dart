import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<StatefulWidget> createState() => _DetailPage();
}

class _DetailPage extends State<DetailPage> {
  void _confirm(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext contextTrolley) {
          return const SimpleDialog(
            title: Text("Berhasil Ditambahkan"),
            titlePadding: EdgeInsets.all(25),
          );
        });
  }

  void _addToTrolley(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext contextTrolley) {
          return AlertDialog(
            title: const Text("Tambah Kekeranjang?"),
            content: const Text("Tambah kan produk ini ke kerenjang mu"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(contextTrolley, '');
                    _confirm(context);
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
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSsq5s2BWt11d8ydxxXtEYP_SZgCmvwCwCigkDqanUwW8PqvIcHvOhiup4x2X3C8fAWQbk&usqp=CAU",
              fit: BoxFit.cover,
              height: windowheight * 2 / 5,
              width: windowWidth,
              alignment: Alignment.center,
            ),
            const SizedBox(height: 20),
            const ListTile(
              title: Text("Burger"),
              subtitle: Text("Rp 3000,-"),
              minLeadingWidth: 10,
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: windowWidth,
              child: const Text(
                "This text is very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very long",
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
