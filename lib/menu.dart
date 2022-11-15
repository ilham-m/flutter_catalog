import 'package:flutter/material.dart';
import 'package:katalog/detail_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<StatefulWidget> createState() => _MenuPage();
}

class _MenuPage extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
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
                child: Text("Lotte Mart"),
              ),
              GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                shrinkWrap: true,
                children: [
                  for (var i = 0; i < 6; i++) ...[
                    GestureDetector(
                      onTap: (){
                         Route route = MaterialPageRoute(builder: (context)=>const DetailPage());
                         Navigator.push(context, route);
                      },
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Image.network(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSsq5s2BWt11d8ydxxXtEYP_SZgCmvwCwCigkDqanUwW8PqvIcHvOhiup4x2X3C8fAWQbk&usqp=CAU",
                              fit: BoxFit.cover,
                            )),
                            Padding(
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Burger",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10),
                                    ),
                                    Text(
                                      "Rp 2.000,-",
                                      style: TextStyle(fontSize: 8),
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
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 5, bottom: 10),
                child: Text("McD"),
              ),
              GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                shrinkWrap: true,
                children: [
                  for (var i = 0; i < 9; i++) ...[
                    GestureDetector(
                      onTap: (){
                         Route route = MaterialPageRoute(builder: (context)=>const DetailPage());
                         Navigator.push(context, route);
                      },
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Image.network(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSsq5s2BWt11d8ydxxXtEYP_SZgCmvwCwCigkDqanUwW8PqvIcHvOhiup4x2X3C8fAWQbk&usqp=CAU",
                              fit: BoxFit.cover,
                            )),
                            Padding(
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Burger",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10),
                                    ),
                                    Text(
                                      "Rp 2.000,-",
                                      style: TextStyle(fontSize: 8),
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
        )
      ],
    );
  }
}
