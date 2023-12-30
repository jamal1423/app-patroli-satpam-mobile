// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:app_patroli_satpam/pages/page_home.dart';
import 'package:app_patroli_satpam/utils/util_card_lokasi_san.dart';
import 'package:flutter/material.dart';

class PartPageLokasiScan extends StatefulWidget {
  const PartPageLokasiScan({super.key});

  @override
  State<PartPageLokasiScan> createState() => _PartPageLokasiScanState();
}

class _PartPageLokasiScanState extends State<PartPageLokasiScan> {
  _goBack(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const PageHome(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                _goBack(context);
              },
              icon: Icon(Icons.arrow_back, color: Colors.black)),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Lokasi Scan"),
              InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => PartPageLokasiScan(),
                    ),
                    (route) => false,
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.black),
                  padding: const EdgeInsets.all(2.5),
                  child: Icon(
                    Icons.refresh_rounded,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(2.0),
            child: Container(
              color: Colors.black,
              height: 0.5,
            ),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {},
                  splashColor: Colors.transparent,
                  child: Column(
                    children: [
                      CardLokasiScan(
                        cardLokasiScan: Icons.location_on_rounded,
                        iconCardColor: Colors.green,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Lokasi 1",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {},
                  splashColor: Colors.transparent,
                  child: Column(
                    children: [
                      CardLokasiScan(
                        cardLokasiScan: Icons.not_listed_location_rounded,
                        iconCardColor: Colors.red,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Lokasi 2",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {},
                  splashColor: Colors.transparent,
                  child: Column(
                    children: [
                      CardLokasiScan(
                        cardLokasiScan: Icons.not_listed_location_rounded,
                        iconCardColor: Colors.red,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Lokasi 3",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {},
                  splashColor: Colors.transparent,
                  child: Column(
                    children: [
                      CardLokasiScan(
                        cardLokasiScan: Icons.not_listed_location_rounded,
                        iconCardColor: Colors.red,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Lokasi 4",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {},
                  splashColor: Colors.transparent,
                  child: Column(
                    children: [
                      CardLokasiScan(
                        cardLokasiScan: Icons.not_listed_location_rounded,
                        iconCardColor: Colors.red,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Lokasi 5",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {},
                  splashColor: Colors.transparent,
                  child: Column(
                    children: [
                      CardLokasiScan(
                        cardLokasiScan: Icons.not_listed_location_rounded,
                        iconCardColor: Colors.red,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Lokasi 6",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {},
                  splashColor: Colors.transparent,
                  child: Column(
                    children: [
                      CardLokasiScan(
                        cardLokasiScan: Icons.not_listed_location_rounded,
                        iconCardColor: Colors.red,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Lokasi 7",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {},
                  splashColor: Colors.transparent,
                  child: Column(
                    children: [
                      CardLokasiScan(
                        cardLokasiScan: Icons.not_listed_location_rounded,
                        iconCardColor: Colors.red,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Lokasi 8",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {},
                  splashColor: Colors.transparent,
                  child: Column(
                    children: [
                      CardLokasiScan(
                        cardLokasiScan: Icons.not_listed_location_rounded,
                        iconCardColor: Colors.red,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Lokasi 9",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {},
                  splashColor: Colors.transparent,
                  child: Column(
                    children: [
                      CardLokasiScan(
                        cardLokasiScan: Icons.not_listed_location_rounded,
                        iconCardColor: Colors.red,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Lokasi 10",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {},
                  splashColor: Colors.transparent,
                  child: Column(
                    children: [
                      CardLokasiScan(
                        cardLokasiScan: Icons.not_listed_location_rounded,
                        iconCardColor: Colors.red,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Lokasi 11",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {},
                  splashColor: Colors.transparent,
                  child: Column(
                    children: [
                      CardLokasiScan(
                        cardLokasiScan: Icons.not_listed_location_rounded,
                        iconCardColor: Colors.red,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Lokasi 12",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {},
                  splashColor: Colors.transparent,
                  child: Column(
                    children: [
                      CardLokasiScan(
                        cardLokasiScan: Icons.not_listed_location_rounded,
                        iconCardColor: Colors.red,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Lokasi 13",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {},
                  splashColor: Colors.transparent,
                  child: Column(
                    children: [
                      CardLokasiScan(
                        cardLokasiScan: Icons.not_listed_location_rounded,
                        iconCardColor: Colors.red,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Lokasi 14",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
