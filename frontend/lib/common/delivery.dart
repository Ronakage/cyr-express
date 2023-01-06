import 'dart:async';
import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:frontend/api/urls.dart';
import 'package:location/location.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class DeliveryPage extends StatefulWidget {
  DeliveryPage({Key? key}) : super(key: key);

  @override
  State<DeliveryPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  StompClient? client;

  @override
  void initState() {
    super.initState();
    client = initWebSocketConnection();
    initLocationTracking();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    client?.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    /*
    TODO :
    1 - Have error pop-ups for the websocket connection
    2 - use hashmaps to track people
    3 - fix type conversion errors
    */
    return Scaffold(
      body: Stack(
        children: const [
          MapPage(),
          //SafeArea()
        ],
      ),
    );
  }


  StompClient initWebSocketConnection() {
    StompClient client = StompClient(
      config: StompConfig.SockJS(
        url: Urls.websocketDeliveryConnectionURL,
        onConnect: onConnectToDelivery,
        onWebSocketError: (error) => print(error.toString()),
        //Display error
        onStompError: (error) => print(error.toString()),
      ),
    );
    client.activate();
    return client;
  }

  void onConnectToDelivery(StompFrame connectFrame) {
    client?.subscribe(
        destination: Urls.websocketDeliverySubscribtionURL,
        headers: {},
        callback: (frame) {
          setState(() {
            print(frame.body!);
          });
        });
  }

  void onSendToDelivery(LocationData currentLocation) {
    var locationObject = {
      'name': 'johnson',
      'latitude': currentLocation.latitude,
      'longitude': currentLocation.longitude
    };
    http.post(
      Uri.parse(Urls.websocketDeliverySendURL),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: json.encode(locationObject),
    );
  }

  void initLocationTracking() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    location.enableBackgroundMode(enable: true);

    locationData = await location.getLocation();

    location.onLocationChanged.listen((LocationData currentLocation) {
      //onSendToDelivery(currentLocation);
    });
  }

}

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
