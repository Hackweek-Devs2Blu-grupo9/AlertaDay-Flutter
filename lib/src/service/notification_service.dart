import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();
  factory NotificationService() => instance;

  final FlutterLocalNotificationsPlugin _local = FlutterLocalNotificationsPlugin();

  static const String _channelId = "local_channel";
  static const String _channelName = "Local Notifications";

  Future<void> init() async {
    // ==== LOCAL NOTIFICATIONS ====
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings();
    const initSettings = InitializationSettings(android: androidInit, iOS: iosInit);

    await _local.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (details) {
        print("Local notification clicked: ${details.payload}");
      },
    );

    if (Platform.isAndroid) {
      final android = _local.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

      await android?.createNotificationChannel(
        const AndroidNotificationChannel(
          _channelId,
          _channelName,
          description: "Canal local",
          importance: Importance.max,
        ),
      );
    }

    // ==== ONE SIGNAL ====

    //final appId = dotenv.env['ONESIGNAL_APP_ID'];
    //if (appId == null) {
      //throw Exception("ONESIGNAL_APP_ID não encontrado no .env");
    //}

    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
   // OneSignal.initialize(appId);

    // Solicita permissão para notificações (iOS + Android 13+)
    OneSignal.Notifications.requestPermission(true);

    // Foreground listener (API nova)
    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      print("Foreground recebido: ${event.notification.title}");

      // Impede notificação do OS aparecer
      event.preventDefault();

      showLocalNotification(
        title: event.notification.title ?? 'Notificação',
        body: event.notification.body ?? '',
        data: event.notification.additionalData,
      );
    });

    // Clique na notificação
    OneSignal.Notifications.addClickListener((event) {
      print("Notificação clicada: ${event.notification.title}");
    });

    print("NotificationService inicializado.");
  }

  Future<void> showLocalNotification({
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) async {
    final android = AndroidNotificationDetails(
      _channelId,
      _channelName,
      importance: Importance.max,
      priority: Priority.high,
    );

    final ios = DarwinNotificationDetails();
    final details = NotificationDetails(android: android, iOS: ios);

    final payload = data != null ? jsonEncode(data) : null;
    final id = DateTime.now().millisecondsSinceEpoch % 100000;

    await _local.show(id, title, body, details, payload: payload);
  }
}
