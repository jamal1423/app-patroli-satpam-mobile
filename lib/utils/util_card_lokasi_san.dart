// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CardLokasiScan extends StatelessWidget {
  final IconData cardLokasiScan;
  final Color? iconCardColor;
  const CardLokasiScan({Key? key, required this.cardLokasiScan, this.iconCardColor}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color.fromARGB(255, 163, 161, 161))),
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Icon(
          cardLokasiScan,
          size: 45,
          color: iconCardColor,
        ),
      ),
    );
  }
}
