// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app_patroli_satpam/models/data_shift.dart';
import 'package:app_patroli_satpam/pages/page_home.dart';
import 'package:app_patroli_satpam/utils/util_card_master_shift.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PartPageMasterShift extends StatefulWidget {
  const PartPageMasterShift({super.key});

  @override
  State<PartPageMasterShift> createState() => _PartPageMasterShiftState();
}

class _PartPageMasterShiftState extends State<PartPageMasterShift> {
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
              Text("Master Shift"),
              InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => PartPageMasterShift(),
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
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                Center(
                    child: FutureBuilder<List<DataShift>>(
                      future: fetchShift(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CardMasterShift(
                                      kodeShift: snapshot.data![index].kode_shift.toString(),
                                      namaShift: snapshot.data![index].nama_shift.toString(),
                                      jamMasuk: snapshot.data![index].jam_masuk.toString(),
                                      jamPulang: snapshot.data![index].jam_pulang.toString(),
                                    ),
                                  ],
                                );
                              });
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        return const CircularProgressIndicator(
                            color: Colors.blue);
                      })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<List<DataShift>> fetchShift() async {
  // final prefs = await SharedPreferences.getInstance();
  // var ss = prefs.getString('username');
  final response = await http.get(Uri.parse(
      'https://patroli-satpam.startdev.my.id/api/v1/get-master-shift/'));
  if (response.statusCode == 200) {
    final List result = json.decode(response.body);
    return result.map((e) => DataShift.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load data');
  }
}
