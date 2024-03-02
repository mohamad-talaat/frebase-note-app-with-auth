import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttercourse/homepage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<NotificationScreen> {
  getToken() async {
    // to get Token and put it in firebase Messaging //but the method in initState(){}
    String? myToken = await FirebaseMessaging.instance.getToken();

    print("////-----------//////////---------/////////---------${myToken}");
  }

  permissions() async {
    // to alert about message that reach
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }

    print('User granted permission: ${settings.authorizationStatus}');
  }

  localMassege() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('----------------------=========--------------');
        print(
            'Message also contained a notification: ${message.notification!.title}');
        print(
            'Message also contained a notification: ${message.notification!.body}');
        AwesomeDialog(
            context: context,
            title: "${message.notification!.title}",
            body: Text("${message.notification!.body}"))
          ..show();
      }
    });
  }

  void _handleMessage(RemoteMessage message) {
    //background notify Method
    if (message.data['type'] != null) {}
    {
      if (message.data['type'] == 'normal') {
        Get.off(Homepage());
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    permissions();
    getToken();
    localMassege();
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
    intialMessageMethod();
    super.initState();
  }

  intialMessageMethod() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage?.data != null) {
      print(initialMessage!.data["name"]);

      if (initialMessage.data["type"] == "normal") {
        Get.off(Homepage());
      }
    }
    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notification")),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () async {
// subscribe to topic on each app start-up
                  await FirebaseMessaging.instance
                      .subscribeToTopic('mohammadTalaat');
                },
                child: Text("Subiscribe")),
            MaterialButton(
                onPressed: () async {
                  await FirebaseMessaging.instance
                      .unsubscribeFromTopic('mohammadTalaat');
                },
                child: Text("Unsubiscribe")),
            TextButton(
                onPressed: () {
                  sendMessageWithTopic(
                      "welcome", "How are u", "mohammadTalaat");
                },
                child: Text("Send Message with topic")),
          ]),
    );
  }
}

sendMessage(titleMessage, bodyMessage) async {
  var headersList = {
    'Accept': '*/*',
    'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
    'Content-Type': 'application/json',
    'Authorization':
        'key=AAAA0jfMXDk:APA91bE4VvaWu8N09TbRH8jDEQg68uJipqOoNh7j_ifBFOiDAXL1vmngkDCM449M1nAxYFvWRLvPUaoOP-g5-z3Zj4imInqezhUSTeMSI9lmPPKCMD7OMZ3op232RR9a2xGcbtHfql0H'
  };
  var url = Uri.parse('https://fcm.googleapis.com/fcm/send');

  var body = {
    "to":
        "d2uBoCskR1mdDQBc4Nx5o1:APA91bH16L6QUHLQhIxOBO6TlQs2mSwo-5P3A-cPFgyfUFh4GF4I2HqgqhFHvOplRjU281huEdrb6CkLZKaaCwZWVdaPkoJnROVGnahSkfq0s0r1DWTDTMpJ2v-hUWVxOM_D0hFDJr1K",
    "notification": {
      "title": "${titleMessage})",
      "body": "${bodyMessage}",
    },
    "data": {"id": "1", "name": "mohamed", "type": "normal"}
  };

  var req = http.Request('POST', url);
  req.headers.addAll(headersList);
  req.body = json.encode(body);

  var res = await req.send();
  final resBody = await res.stream.bytesToString();

  if (res.statusCode >= 200 && res.statusCode < 300) {
    print(resBody);
  } else {
    print(res.reasonPhrase);
  }
}

sendMessageWithTopic(titleMessage, bodyMessage, topic) async {
  var headersList = {
    'Accept': '*/*',
    'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
    'Content-Type': 'application/json',
    'Authorization':
        'key=AAAA0jfMXDk:APA91bE4VvaWu8N09TbRH8jDEQg68uJipqOoNh7j_ifBFOiDAXL1vmngkDCM449M1nAxYFvWRLvPUaoOP-g5-z3Zj4imInqezhUSTeMSI9lmPPKCMD7OMZ3op232RR9a2xGcbtHfql0H'
  };
  var url = Uri.parse('https://fcm.googleapis.com/fcm/send');

  var body = {
    "to": "/topics/$topic",
    "notification": {
      "title": "${titleMessage})",
      "body": "${bodyMessage}",
    },
    "data": {"id": "1", "name": "mohamed", "type": "normal"}
  };

  var req = http.Request('POST', url);
  req.headers.addAll(headersList);
  req.body = json.encode(body);

  var res = await req.send();
  final resBody = await res.stream.bytesToString();

  if (res.statusCode >= 200 && res.statusCode < 300) {
    print(resBody);
  } else {
    print(res.reasonPhrase);
  }
}
