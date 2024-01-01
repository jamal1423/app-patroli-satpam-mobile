// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class CardMasterShift extends StatelessWidget {
  final String kodeShift, namaShift, jamMasuk, jamPulang;
  const CardMasterShift({Key? key, required this.kodeShift, required this.namaShift, required this.jamMasuk, required this.jamPulang}) : super(key: key) ;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Container(
        width: screenSize.width / 1.2,
        height: screenSize.height / 7,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color.fromARGB(255, 163, 161, 161))),
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
               children: [
                  Text("Kode Shift", style: TextStyle(fontSize: 10)),
                  Text(kodeShift, style: TextStyle(fontSize: 16)),
                  SizedBox(height: 10),
                  Text("Nama Shift", style: TextStyle(fontSize: 10)),
                  Text(namaShift, style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Column(
                children: [
                  Text("Jam Masuk", style: TextStyle(fontSize: 10)),
                  Text(jamMasuk, style: TextStyle(fontSize: 16)),
                  SizedBox(height: 10),
                  Text("Jam Pulang", style: TextStyle(fontSize: 10)),
                  Text(jamPulang, style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ],        
        ),
      ),
    );
  }
}