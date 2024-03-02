import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_permission/view/home_page.dart';

void main() {
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'location-update',
        channelName: "Location Update",
        channelDescription: "Notifications of Loacation update status",
      ),
    ],
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  static final scaffoldMessangerKey = GlobalKey<ScaffoldMessengerState>();
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessangerKey,
      debugShowCheckedModeBanner: false,
      // theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}
