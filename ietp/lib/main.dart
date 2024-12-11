import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ietp/front_page.dart';
import 'package:ietp/notification_service.dart';
import 'package:just_audio/just_audio.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Initialize Firebase to ensure it's ready
  await Firebase.initializeApp();
  _playAlarm();
}

void _playAlarm() async {
  final player = AudioPlayer();
  await player.setAsset('assets/music/alart.mp3'); // Add your alarm audio file
  player.play();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  NotificationService notificationService = NotificationService();
  // await Alarm.init();
  await notificationService.initialize();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IETP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FrontPage()
    );
  }
}
