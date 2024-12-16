import 'dart:io';
import 'dart:ui';

import 'package:app_fliplaptop/Screens/NotificationScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();



  static Future<void> initialize() async {
    // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    // FlutterLocalNotificationsPlugin();

    // initializationSettings  for Android
    Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
      await Firebase.initializeApp();
    }

    const InitializationSettings initializationSettings =
    InitializationSettings(
        android: AndroidInitializationSettings("icon"),
        iOS: DarwinInitializationSettings());
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    // await flutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<
    //     AndroidFlutterLocalNotificationsPlugin>()
    //     ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (id)
      async {
        Get.to(() => NotificationScreen());

        // if (id != null) {
        //   print("Router Value1234 $id");
        //   if (childtoken != null || token != null) {
        //     Get.to(() => NotificationsScreen());
        //   } else {
        //     Get.to(() => LoginScreen());
        //   }

        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => DemoScreen(
        //       id: id,
        //     ),
        //   ),
        // );

        // }
      },
    );
    await requestPermissionForIOS();
  }

  static listenForegroundMessage(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin, AndroidNotificationChannel channel) async {
    FirebaseMessaging.onMessage.listen(
          (RemoteMessage message) async {
        RemoteNotification? notification = message.notification;

        if (Platform.isAndroid) {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification?.title,
            "Click to see view on application",
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                color: Color(0xffDDC6B6),
                icon: "@mipmap/ic_launcher",
              ),
            ),
          );
        }
      },
    );
  }


  static requestPermissionForIOS() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  static void createAndDisplayNotification(RemoteMessage message) async {
    try {
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "pushnotificationapp",
          "pushnotificationappchannel",
          importance: Importance.max,
          priority: Priority.high,
        ),
      );

      if (Platform.isAndroid) {
        await _notificationsPlugin.show(
          0,
          message.notification!.title,
          message.notification!.body,
          notificationDetails,
          payload: message.data['_id'],
        );

      }
    } on Exception catch (e) {
      print(e);
    }
  }
}