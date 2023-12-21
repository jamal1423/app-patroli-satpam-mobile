// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app_patroli_satpam/partials/partial_page_home.dart';
import 'package:app_patroli_satpam/partials/partial_page_list_scan_lokasi.dart';
import 'package:app_patroli_satpam/partials/partial_page_riwayat_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/services.dart';

class PageHome extends StatefulWidget {
  const PageHome({super.key});

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  int _pageIndex = 1;
  final pages = [
    PageListScan(),
    PartPageHome(),
    PageRiwayatScan(),
  ];

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(255, 250, 250, 252),
    ));
    
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: _pageIndex,
        items: const <Widget>[
          Icon(CupertinoIcons.map_pin_ellipse, size: 30, color: Color.fromARGB(255, 250, 250, 252)),
          Icon(CupertinoIcons.home,size: 30,color: Color.fromARGB(255, 250, 250, 252)),
          Icon(CupertinoIcons.calendar,size: 30,color: Color.fromARGB(255, 250, 250, 252)),
        ],
        color: Color.fromARGB(255, 92, 92, 92),
        buttonBackgroundColor: Color.fromARGB(255, 92, 92, 92),
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 400),
        onTap: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
        letIndexChange: (index) => true,
      ),
      body: pages[_pageIndex],
    );
  }
}