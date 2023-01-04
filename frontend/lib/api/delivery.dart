import 'package:flutter/material.dart';
import 'package:frontend/api/urls.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

import '../utils/CustomColors.dart';

class DeliveryPage extends StatefulWidget {
  DeliveryPage({Key? key}) : super(key: key);

  @override
  State<DeliveryPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  StompClient? client;

  @override
  void initState() {
    client = StompClient(
        config: StompConfig.SockJS(
            url: Urls.websocketDeliveryConnectionURL,
            onConnect: onConnectCallback,
            //Display error
            onStompError: (error) => print(error.toString()),

          ),
    );
    client?.activate();
  }

  void onConnectCallback(StompFrame connectFrame) {
    client?.subscribe(
        destination: Urls.websocketDeliverySubscribtionURL,
        headers: {},
        callback: (frame) {
          print(frame.body);
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    /*
    TODO :
    1 - Have error pop-ups for the websocket connection
    */
    return Scaffold(
      body: Center(
        child: Column(
          children: const [
            
          ],
        )
      ),
    );
  }
}
