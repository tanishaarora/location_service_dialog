import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var location = Location();
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";
  late StreamSubscription<Position> positionStream;

  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('LAT: ${lat ?? ""}'),
          Text('LNG: ${long ?? ""}'),
          //Text('ADDRESS: ${_currentAddress ?? "Not found"}'),
        ],
      ),
    );
  }

  getLocation() async {

    position = await Geolocator.getCurrentPosition();
    print(position.longitude); //Output: 80.24599079
    print(position.latitude); //Output: 29.6593457

    long = position.longitude.toString();
    lat = position.latitude.toString();

    setState(() {});

    LocationSettings locationSettings = LocationSettings(
      distanceFilter: 100,
    );

    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      print(position.longitude); //Output: 80.24599079
      print(position.latitude); //Output: 29.6593457
      long = position.longitude.toString();
      lat = position.latitude.toString();
      setState(() {});
    });
  }

  getCurrentLocation() async {
    try {
      await location.getLocation().then((locationData) {
        showDialogLoader(context);
        if (locationData != null) {
          getLocation();

          // moveHomeWithLatLon(context,false,locationData.latitude.toString(),locationData.longitude.toString());
        } else {
          Navigator.of(context).pop;
          //   dialogInternetCheck(context, alert, "Please check location services on device");
        }
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {

      }
    }
  }

  // Position position = await Geolocator.getCurrentPosition();

  Future<void> _getCurrentPosition() async {
    final hasPermission = await getCurrentLocation();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition().then((Position position) {
      setState(() => position = position);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  void showDialogLoader(BuildContext context) async {
    showDialog(
      barrierDismissible: false,
      builder: (ctx) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },

      context: context,
    );
    await Future.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;
    Navigator.of(context).pop();
  }

}
