// import 'package:alarmplayer/alarmplayer.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart'
    as firebase_messaging;
import 'package:just_audio/just_audio.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final firebase_messaging.FirebaseMessaging _firebaseMessaging =
      firebase_messaging.FirebaseMessaging.instance;

  Future<void> initialize() async {
    // Initialize local notifications
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _localNotificationsPlugin.initialize(initializationSettings);

    // Request notification permissions (iOS only)
    firebase_messaging.NotificationSettings settings =
        await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus ==
        firebase_messaging.AuthorizationStatus.authorized) {
      print('User granted permission');
    } else {
      print('User declined or has not accepted permission');
    }

    // Handle foreground notifications
    firebase_messaging.FirebaseMessaging.onMessage
        .listen((firebase_messaging.RemoteMessage message) async {
      print('Foreground message received: ${message.notification?.title}');
      _showNotification(message);
      _playAlarm();
    });

    // Handle background messages
    firebase_messaging.FirebaseMessaging.onMessageOpenedApp
        .listen((firebase_messaging.RemoteMessage message) {
      print('Message clicked!');
    });
  }

  Future<void> _showNotification(
      firebase_messaging.RemoteMessage message) async {
    if (message.notification == null) {
      print('No notification payload to show.');

      return;
    }

    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'channel_id', // Must match the channel ID used elsewhere
      'Channel Name', // Channel name visible to the user
      channelDescription: 'Description of the channel',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await _localNotificationsPlugin.show(
      0, // Notification ID
      message.notification!.title ?? 'No Title',
      message.notification!.body ?? 'No Body',
      notificationDetails,
    );
  }

  void _playAlarm() async {
    final player = AudioPlayer();
    await player.setAsset('assets/music/alart.mp3');
    player.setLoopMode(LoopMode.one);
    player.play();
  }
}
