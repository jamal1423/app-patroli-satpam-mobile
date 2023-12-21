// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class PageListScan extends StatefulWidget {
  const PageListScan({super.key});

  @override
  State<PageListScan> createState() => _PageListScanState();
}

class _PageListScanState extends State<PageListScan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 250, 250, 252),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2.0),
          child: Row(
            children: [
              Container(
                color: Colors.grey,
                height: 0.5,
              ),
            ],
          ),
        ),
        title: Text("List Lokasi Scan", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      body: Container(),
    );
  }
}
