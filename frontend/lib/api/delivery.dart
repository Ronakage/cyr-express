import 'dart:convert';

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

  List<String> items = <String>[];
  String msg = "No items";

  @override
  void initState() {
    super.initState();
    client = initWebSocketConnection();
    initLocationTracking();
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
      body: SafeArea(
        child: Center(
          child: items.isNotEmpty
              ? ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(items[index]),
                    );
                  },
                )
              : Text(msg),
        ),
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
            String locationObject = json.encode(frame.body!);
            items.add(locationObject);
            print(locationObject);
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
      onSendToDelivery(currentLocation);
    });
  }
}
