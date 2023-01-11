import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/services.dart';
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

  Location location = Location();
  LocationData? myLocation;

  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();
  BitmapDescriptor? myMarkerIcon;

  bool isFollowingAround = true;

  @override
  void initState() {
    client = initWebSocketConnection();
    askForLocationPermessions();
    createCustomMarkerForCurrentLocation();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    client?.deactivate();
    super.dispose();
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
        children: [
          myLocation == null
              ? const Center(child: Text("Loading..."))
              : MapWidget(myLocation: myLocation, mapController: mapController, myMarkerIcon: myMarkerIcon),
          SafeArea(
              child: Align(
            alignment: Alignment.bottomRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: FloatingActionButton(
                    onPressed: stopFollowingCurrentLocation,
                    backgroundColor:
                        isFollowingAround == true ? Colors.blue : Colors.grey,
                    enableFeedback: true,
                    child: isFollowingAround == true
                        ? const Icon(Icons.my_location)
                        : const Icon(Icons.map),
                  ),
                ),
              ],
            ),
          ))
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
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: json.encode(locationObject),
    );
  }

  void askForLocationPermessions() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

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

    location.getLocation().then((initLocation) {
      setState(() {
        myLocation = initLocation;
      });
      followCurrentLocation();
    });
  }

  void followCurrentLocation() async {
    GoogleMapController initLocationMapController = await mapController.future;
    location.onLocationChanged.listen((LocationData myChangedLocation) {
      setState(() {
        myLocation = myChangedLocation;
        if (isFollowingAround) {
          initLocationMapController.animateCamera(
              CameraUpdate.newCameraPosition(CameraPosition(
                  zoom: 17,
                  target:
                      LatLng(myLocation!.latitude!, myLocation!.longitude!))));
        }
      });
      //onSendToDelivery(currentLocation);
    });
  }

  void stopFollowingCurrentLocation() async {
    setState(() {
      isFollowingAround = !isFollowingAround;
    });
  }

  void createCustomMarkerForCurrentLocation() async {
    //Dice Bear API
    String url = "https://api.dicebear.com/5.x/initials/png?seed=Rony%20Mawad&radius=50&size=85";
    Uint8List bytes = (await NetworkAssetBundle(Uri.parse(url)).load(url))
        .buffer
        .asUint8List();
    setState(() {
      myMarkerIcon = BitmapDescriptor.fromBytes(bytes);
    });
  }
}

class MapWidget extends StatelessWidget {
  const MapWidget(
      {Key? key,
      required this.myLocation,
      required this.mapController,
      required this.myMarkerIcon})
      : super(key: key);

  final LocationData? myLocation;
  final Completer<GoogleMapController> mapController;
  final BitmapDescriptor? myMarkerIcon;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: LatLng(myLocation!.latitude!, myLocation!.longitude!),
        zoom: 17,
      ),
      onMapCreated: (GoogleMapController controller) {
        mapController.complete(controller);
      },
      markers: {
        Marker(
          markerId: const MarkerId("myLocation"),
          position: LatLng(myLocation!.latitude!, myLocation!.longitude!),
          icon: myMarkerIcon ?? BitmapDescriptor.defaultMarker,
        )
      },
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      padding: const EdgeInsets.symmetric(vertical: 30),
    );
  }
}
