import 'dart:convert';

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
    */
    return Scaffold(
      body: Center(
        child: items.isNotEmpty
            ? ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(items[index]),
                  );
                },
              )
            : const Text("No items"),
      ),
    );
  }

  StompClient initWebSocketConnection() {
    StompClient client = StompClient(
      config: StompConfig.SockJS(
        url: Urls.websocketDeliveryConnectionURL,
        onConnect: onConnect,
        //Display error
        onStompError: (error) => print(error.toString()),
      ),
    );
    client.activate();
    return client;
  }

  void onConnect(StompFrame connectFrame) {
    client?.subscribe(
        destination: Urls.websocketDeliverySubscribtionURL,
        headers: {},
        callback: (frame) {
          setState(() {
            var locationObject = jsonDecode(frame.body!);
            items.add(locationObject);
          });
        });
  }

  void onSend(LocationData currentLocation) {
    client?.send(
        destination: Urls.websocketDeliverySendURL,
        body: json.encode({
          'name': 'tom',
          'latitude': currentLocation.latitude,
          'longitude': currentLocation.longitude
        }),
        headers: {});
    setState(() {
      items.add(currentLocation.toString());
    });
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

    locationData = await location.getLocation();

    onSend(locationData);

    location.enableBackgroundMode(enable: true);

    location.onLocationChanged.listen((LocationData currentLocation) {
      onSend(currentLocation);
    });
  }
}
