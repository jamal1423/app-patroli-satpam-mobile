// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, prefer_collection_literals, sort_child_properties_last, sized_box_for_whitespace
import 'dart:convert';
// import 'dart:io';
import 'dart:math';
import 'package:app_patroli_satpam/models/data_user.dart';
import 'package:app_patroli_satpam/pages/page_home.dart';
import 'package:app_patroli_satpam/pages/page_login.dart';
import 'package:app_patroli_satpam/partials/partial_page_lokasi_scan.dart';
import 'package:app_patroli_satpam/utils/util_card_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:safe_device/safe_device.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;

class PartPageHome extends StatefulWidget {
  const PartPageHome({super.key});

  @override
  State<PartPageHome> createState() => _PartPageHomeState();
}

class _PartPageHomeState extends State<PartPageHome> {
  //japfa
  LatLng initialLocation = LatLng(-7.440232, 112.613748);

  //kosan
  // LatLng initialLocation = LatLng(-7.378822662421588, 112.646988897764);

  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  LatLng? _currentPosition;

  String employeeID = "";
  late Future<Datauser> futureDataUser;
  bool isLoading = true;

  // LatLng? _positionNow;
  // bool _isLoading = true;
  late GoogleMapController mapController;

  double? latt = 0;
  double? longg = 0;

  bool canMockLocation = false;

  String _address = ""; // create this variable

  Set<Circle> circles = Set.from([
    Circle(
      circleId: CircleId("Main Location"),
      //japfa
      center: LatLng(-7.440232, 112.613748),
      //kosan
      // center: LatLng(-7.378822662421588, 112.646988897764),
      radius: 100,
      strokeWidth: 3,
      strokeColor: Colors.blue,
      fillColor: const Color.fromARGB(75, 33, 149, 243),
    )
  ]);

  void getLocation() async {
    // ignore: unused_local_variable
    LocationPermission permission;
    permission = await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    double? lat = position.latitude;
    double? long = position.longitude;
    LatLng location = LatLng(lat, long);

    setState(() {
      _currentPosition = location;
      latt = _currentPosition!.latitude;
      longg = _currentPosition!.longitude;
      // _positionNow = LatLng(lat, long);
      // _isLoading = false;
      getPlace(latt, longg);
      initPlatformState();
    });
  }

  double calculateDistance(lat1, lon1, lat, long) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat - lat1) * p) / 2 +
        c(lat1 * p) * c(lat * p) * (1 - c((long - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a)); //dikalikan 1000 untuk meter
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    controller.showMarkerInfoWindow(MarkerId("KantorPusat"));
  }

  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(4, 4)), "assets/icon_marker.png")
        .then(
      (icon) {
        setState(() {
          markerIcon = icon;
        });
      },
    );
  }

  Future<void> initPlatformState() async {
    await Permission.location.request();
    if (await Permission.location.isPermanentlyDenied) {
      openAppSettings();
    }

    if (!mounted) return;
    try {
      canMockLocation = await SafeDevice.canMockLocation;
    } catch (error) {
      print(error);
    }

    setState(() {
      canMockLocation = canMockLocation;
    });
  }

  notifFakeGps() {
    Alert(
      context: context,
      style: const AlertStyle(
        isCloseButton: false,
        descStyle: TextStyle(fontSize: 14.0),
      ),
      type: AlertType.warning,
      title: "WARNING",
      desc: "Terdeteksi FAKE GPS, dimohon untuk mematikan aplikasi tersebut.",
      buttons: [
        DialogButton(
          child: Text(
            "Ok",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.orange,
        ),
      ],
    ).show();
  }

  notifOutArea() {
    Alert(
      context: context,
      style: const AlertStyle(
        isCloseButton: false,
        descStyle: TextStyle(fontSize: 14.0),
      ),
      type: AlertType.warning,
      title: "WARNING",
      desc: "Anda sedang berada diluar area absensi.",
      buttons: [
        DialogButton(
          child: Text(
            "Ok",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.orange,
        ),
      ],
    ).show();
  }

  getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var islogin = pref.getBool("is_login");
    if (islogin != null && islogin == true) {
      setState(() {
        employeeID = pref.getString("employeeID")!;
        // pref.setString('username', username);
      });
    } else {
      if (context.mounted) {
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const PageLogin(),
          ),
          (route) => false,
        );
      }
    }
  }

  logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.remove("is_login");
      preferences.remove("employeeID");
      preferences.remove("fullname");
    });

    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const PageLogin(),
        ),
        (route) => false,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
          "Berhasil logout",
          style: TextStyle(fontSize: 16),
        )),
      );
    }
  }

  // double? latAddr = -7.440232;
  // double? longAddr = 112.613748;

  // get place
  void getPlace(lat, long) async {
    List<Placemark> newPlace =
        // await placemarkFromCoordinates(-7.440232, 112.613748);
        await placemarkFromCoordinates(lat, long);
    Placemark placeMark = newPlace[0];
    String subAdministrativeArea = placeMark.subAdministrativeArea.toString();
    String subLocality = placeMark.subLocality.toString();
    String locality = placeMark.locality.toString();
    // String administrativeArea = placeMark.administrativeArea.toString();
    // String postalCode = placeMark.postalCode.toString();
    // String country = placeMark.country.toString();
    String address = "$subLocality, $locality, $subAdministrativeArea";

    setState(() {
      _address = address;
    });
  }

  @override
  void initState() {
    getPref();
    getLocation();
    futureDataUser = fetchDatauser();
    super.initState();
    // initPlatformState();
    //getPlace();
    addCustomIcon();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    var screenSize = MediaQuery.of(context).size;
    //japfa
    double? latit = -7.440232;
    double? longit = 112.613748;

    // LatLng _positionNow = LatLng(latt!, longg!);

    //kosan
    // double latit = -7.378822662421588;
    // double longit = 112.646988897764;

    // double? distance = calculateDistance(latit, longit, _currentPosition!.latitude, _currentPosition!.longitude);

    // double? distance = calculateDistance(latit, longit, latt, longg);

    // String distanceToString = distance.toStringAsFixed(0);

    double? distance = calculateDistance(latit, longit, latt, longg);
    double? distancemeter = distance * 1000;

    String distanceToStringMeter = distancemeter.toStringAsFixed(0);
    String distanceToStringKiloMeter = distance.toStringAsFixed(0);

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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(2),
                  child: FutureBuilder<Datauser>(
                    future: futureDataUser,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Selamat Datang",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 1),
                            Text(
                              "${snapshot.data!.fullname}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return const CircularProgressIndicator(
                        color: Color.fromARGB(255, 167, 168, 168),
                        strokeWidth: 2,
                      );
                    },
                  ),
                )
              ],
            ),
            // Container(
            //   child: Icon(
            //     Icons.person_outline_rounded,
            //     color: Colors.black,
            //     size: 25,
            //   ),
            // ),
          ],
        ),
        actionsIconTheme: IconThemeData(color: Colors.black),
        actions: [
          PopupMenuButton(itemBuilder: (context) {
            return [
              const PopupMenuItem<int>(
                value: 0,
                child: Text("Profile"),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text("Settings"),
              ),
              const PopupMenuItem<int>(
                value: 2,
                child: Text("Logout"),
              ),
            ];
          }, onSelected: (value) {
            if (value == 0) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Ke Menu Profile'),
              ));
            } else if (value == 1) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Ke Menu Setting'),
              ));
            } else if (value == 2) {
              logOut();
            }
          }),
        ],
      ),
      floatingActionButton: Align(
        alignment: Alignment.centerRight,
        child: Container(
          // width: 40,
          // height: 40,
          child: FloatingActionButton(
            mini: true,
            backgroundColor: Color.fromARGB(255, 3, 153, 3),
            tooltip: 'Refresh Page',
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => PageHome(),
                ),
                (route) => false,
              );
            },
            child: const Icon(Icons.refresh_outlined,
                color: Colors.white, size: 25),
          ),
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      body: Container(
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(0),
              height: screenSize.height / 1,
              child: GoogleMap(
                onTap: (initialLocation) async {
                  if (canMockLocation == true) {
                    notifFakeGps();
                  } else {
                    // if(distance<100){
                    // Navigator.pushAndRemoveUntil(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (BuildContext context) => PageHome(),
                    //   ),
                    //   (route) => false,
                    // );
                    // }else{
                    //   notifOutArea();
                    // }
                  }
                },
                onMapCreated: _onMapCreated,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: initialLocation,
                  zoom: 16,
                ),
                markers: {
                  Marker(
                    markerId: MarkerId("KantorPusat"),
                    // position: LatLng(latt!, longg!),
                    position: initialLocation,
                    draggable: true,
                    onDragEnd: (value) {
                      // value is the new position
                    },
                    infoWindow: const InfoWindow(
                      title: "SBU Plastic Bag - Wonoayu",
                    ),
                    // icon: markerIcon,
                    icon: markerIcon,
                  ),
                },
                circles: circles,
              ),
            ),
            // SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: screenSize.height / 4,
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(height: 25),

                    // 4 card
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            // Navigator.pushAndRemoveUntil(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (BuildContext context) => PageTopupPulsa(),
                            //   ),
                            //   (route) => false,
                            // );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text("Menu Master Shift")),
                            );
                          },
                          splashColor: Colors.transparent,
                          child: Column(
                            children: [
                              // Pulsa
                              CardHome(
                                cardHome: Icons.calendar_month,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Master Shift",
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    PartPageLokasiScan(),
                              ),
                              (route) => false,
                            );
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   SnackBar(
                            //     backgroundColor: Colors.red,
                            //     content: Text("Menu Lokasi Scan QR")
                            //   ),
                            // );
                          },
                          splashColor: Colors.transparent,
                          child: Column(
                            children: [
                              // Pulsa
                              CardHome(
                                cardHome: CupertinoIcons.qrcode_viewfinder,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Scan QR",
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // Navigator.pushAndRemoveUntil(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (BuildContext context) => PageTopupEmoney(),
                            //   ),
                            //   (route) => false,
                            // );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text("Menu Jadwal")),
                            );
                          },
                          splashColor: Colors.transparent,
                          child: Column(
                            children: [
                              // Pulsa
                              CardHome(
                                cardHome: CupertinoIcons.clock,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Jadwal",
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 8),

                    distancemeter >= 1000
                        ? Text(
                            "Lokasi Anda\n$_address\nJarak $distanceToStringKiloMeter KM dari SBU Plastic Bag",
                            textAlign: TextAlign.center,
                          )
                        : Text(
                            "Lokasi Anda\n$_address\nJarak $distanceToStringMeter Meter dari SBU Plastic Bag",
                            textAlign: TextAlign.center,
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Datauser> fetchDatauser() async {
    final prefs = await SharedPreferences.getInstance();
    var ss = prefs.getString('employeeID');
    final response = await http.get(
        Uri.parse(
            "https://patroli-satpam.startdev.my.id/api/v1/get-data-user/$ss"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      return Datauser.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load User.');
    }
  }
}
