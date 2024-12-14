import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


Future<void> saveToken(String name) async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

   String? deviceToken = await messaging.getToken();

  await firestore.collection('users').add({
    'token': deviceToken,
    'name':name,
    'timestamp': FieldValue.serverTimestamp(), 
  });
}



Future<void> deleteToken() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String? deviceToken = await messaging.getToken();

  QuerySnapshot querySnapshot = await firestore
      .collection('users')
      .where('token', isEqualTo: deviceToken)
      .get();

  querySnapshot.docs.forEach((doc) {
    doc.reference.delete();
  });
}

Future<void> safeState() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String? deviceToken = await messaging.getToken();

  QuerySnapshot querySnapshot = await firestore
      .collection('in_danger')
      .where('token', isEqualTo: deviceToken)
      .get();

  querySnapshot.docs.forEach((doc) {
    doc.reference.delete();
  });
}

Future<void> FirebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Handle background messages
  print('Background message received: ${message.messageId}');
}

void requestNotificationPermissions() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else {
    print('User declined or has not accepted permission');
  }
}
