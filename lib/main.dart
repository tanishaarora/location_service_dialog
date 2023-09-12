import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    //serviceStatusResult;
    //_checkGps();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }


  getCurrentLocation() async {
    try {
      await location.getLocation().then((locationData) {
        if (locationData != null) {
          // moveHomeWithLatLon(context,false,locationData.latitude.toString(),locationData.longitude.toString());
        } else {
          //   dialogInternetCheck(context, alert, "Please check location services on device");
        }
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        //  error = 'Permission denied';
        // dialogInternetCheck(context, alert, "Location services "+error);
      }
    }
    /*bool serviceStatusResult = await location.requestService();
  print("Service status activated after request: $serviceStatusResult");
  if (serviceStatusResult) {
  await _getCurrentLocation();
  }

  Future<bool> _getCurrentLocation() async {
  try {
  Location location = Location();
  LocationData userLocation = await location.getLocation();
  } on PlatformException catch (e) {
 // Log.info("Location fetch failed : ${e.toString()}");
  }
  return Future.value(true);
  }*/
    /*Future _checkGps() async {
    if(!await location.serviceEnabled()){
      location.requestService();
    }
  }*/
  }
}
