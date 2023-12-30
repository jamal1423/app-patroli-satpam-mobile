// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PageListScan extends StatefulWidget {
  const PageListScan({super.key});

  @override
  State<PageListScan> createState() => _PageListScanState();
}

class _PageListScanState extends State<PageListScan> {
  //japfa
  LatLng initialLocation = LatLng(-7.440232, 112.613748);

  late BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  late GoogleMapController mapController;
  final Set<Marker> markers = new Set(); //markers for google map

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  // void addCustomIcon() {
  //   BitmapDescriptor.fromAssetImage(
  //           ImageConfiguration(size: Size(2, 2)), "assets/loc_multiple.png")
  //       .then(
  //     (icon) {
  //       setState(() {
  //         markerIcon = icon;
  //       });
  //     },
  //   );
  // }

  Set<Marker> getmarkers() {
    //markers to place on map
    setState(() {
      markers.add(Marker(
        //add first marker
        markerId: MarkerId(initialLocation.toString()),
        position: initialLocation, //position of marker
        infoWindow: InfoWindow(
          //popup info
          title: 'LK001',
          snippet: 'Lokasi Scan 1',
        ),
        icon: markerIcon, //Icon for Marker
      ));

      markers.add(Marker(
        //add second marker
        markerId: MarkerId(initialLocation.toString()),
        position:
            LatLng(-7.440704472544568, 112.61351706688613), //position of marker
        infoWindow: InfoWindow(
          //popup info
          title: 'LK002',
          snippet: 'Lokasi Scan 2',
        ),
        icon: markerIcon, //Icon for Marker
      ));

      markers.add(Marker(
        //add third marker
        markerId: MarkerId(initialLocation.toString()),
        position:
            LatLng(-7.440242775187393, 112.61143969054882), //position of marker
        infoWindow: InfoWindow(
          //popup info
          title: 'LK003',
          snippet: 'Lokasi Scan 3',
        ),
        icon: markerIcon,
        // icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));
      
      markers.add(Marker(
        //add third marker
        markerId: MarkerId(initialLocation.toString()),
        position:
            LatLng(-7.440153071771165, 112.61459084354145), //position of marker
        infoWindow: InfoWindow(
          //popup info
          title: 'LK004',
          snippet: 'Lokasi Scan 4',
        ),
        icon: markerIcon,
        // icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));
      
      markers.add(Marker(
        //add third marker
        markerId: MarkerId(initialLocation.toString()),
        position:
            LatLng(-7.4400043522551185, 112.61377139457716), //position of marker
        infoWindow: InfoWindow(
          //popup info
          title: 'LK005',
          snippet: 'Lokasi Scan 5',
        ),
        icon: markerIcon,
        // icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));
      
      markers.add(Marker(
        //add third marker
        markerId: MarkerId(initialLocation.toString()),
        position:
            LatLng(-7.439738254650834, 112.61233340710909), //position of marker
        infoWindow: InfoWindow(
          //popup info
          title: 'LK006',
          snippet: 'Lokasi Scan 6',
        ),
        icon: markerIcon,
        // icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));
      
      markers.add(Marker(
        //add third marker
        markerId: MarkerId(initialLocation.toString()),
        position:
            LatLng(-7.4399641865893456, 112.6118574535105), //position of marker
        infoWindow: InfoWindow(
          //popup info
          title: 'LK007',
          snippet: 'Lokasi Scan 7',
        ),
        icon: markerIcon,
        // icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));
      
      markers.add(Marker(
        //add third marker
        markerId: MarkerId(initialLocation.toString()),
        position:
            LatLng(-7.440305594631241, 112.61215619034365), //position of marker
        infoWindow: InfoWindow(
          //popup info
          title: 'LK008',
          snippet: 'Lokasi Scan 8',
        ),
        icon: markerIcon,
        // icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));
      
      markers.add(Marker(
        //add third marker
        markerId: MarkerId(initialLocation.toString()),
        position:
            LatLng(-7.440431112226922, 112.61286505740537), //position of marker
        infoWindow: InfoWindow(
          //popup info
          title: 'LK009',
          snippet: 'Lokasi Scan 9',
        ),
        icon: markerIcon,
        // icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));
      
      markers.add(Marker(
        //add third marker
        markerId: MarkerId(initialLocation.toString()),
        position:
            LatLng(-7.440551609084973, 112.6136751911902), //position of marker
        infoWindow: InfoWindow(
          //popup info
          title: 'LK010',
          snippet: 'Lokasi Scan 10',
        ),
        icon: markerIcon,
        // icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));
      
      markers.add(Marker(
        //add third marker
        markerId: MarkerId(initialLocation.toString()),
        position:
            LatLng(-7.440771605778231, 112.61398773598742), //position of marker
        infoWindow: InfoWindow(
          //popup info
          title: 'LK011',
          snippet: 'Lokasi Scan 11',
        ),
        icon: markerIcon,
        // icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));
      
      markers.add(Marker(
        //add third marker
        markerId: MarkerId(initialLocation.toString()),
        position:
            LatLng(-7.439920700504698, 112.61305323444883), //position of marker
        infoWindow: InfoWindow(
          //popup info
          title: 'LK012',
          snippet: 'Lokasi Scan 12',
        ),
        icon: markerIcon,
        // icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));
      
      markers.add(Marker(
        //add third marker
        markerId: MarkerId(initialLocation.toString()),
        position:
            LatLng(-7.439850076069161, 112.61147972632695), //position of marker
        infoWindow: InfoWindow(
          //popup info
          title: 'LK013',
          snippet: 'Lokasi Scan 13',
        ),
        icon: markerIcon,
        // icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));
      
      markers.add(Marker(
        //add third marker
        markerId: MarkerId(initialLocation.toString()),
        position:
            LatLng(-7.439676978264691, 112.61151591712735), //position of marker
        infoWindow: InfoWindow(
          //popup info
          title: 'LK014',
          snippet: 'Lokasi Scan 14',
        ),
        icon: markerIcon,
        // icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      //add more markers here
    });

    return markers;
  }

  @override
  void initState() {
    super.initState();
    // addCustomIcon();
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
        title: Text("List Lokasi Scan",
            style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
      ),
      body: Container(
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(0),
              height: screenSize.height / 1,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: initialLocation,
                  zoom: 18,
                ),
                markers: getmarkers(),
                // markers: {
                //   Marker(
                //     markerId: const MarkerId("Area Patroli"),
                //     // position: LatLng(latt!, longg!),
                //     position: initialLocation,
                //     draggable: true,
                //     onDragEnd: (value) {
                //       // value is the new position
                //     },
                //     infoWindow: const InfoWindow(
                //       title: "SBU Plastic Bag - Wonoayu",
                //     ),
                //     // icon: markerIcon,
                //     icon: markerIcon,
                //   ),
                // },
              ),
            )
          ],
        ),
      ),
    );
  }
}
