// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class PageRiwayatScan extends StatefulWidget {
  const PageRiwayatScan({super.key});

  @override
  State<PageRiwayatScan> createState() => _PageRiwayatScanState();
}

class _PageRiwayatScanState extends State<PageRiwayatScan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 250, 250, 252),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2.0),
          child: Container(
              color: Colors.black,
              height: 0.5,
          ),
        ),
        title: Text("Riwayat Scan", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }
}