import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'src/app/app_widget.dart';
import 'src/service/notification_service.dart';
import 'src/service/realtime_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //await dotenv.load(fileName: ".env");

  // Inicializa notificações locais + push OneSignal
  //await NotificationService().init();

  // Serviço de realtime (mock)
  //RealtimeService().startListening();

  runApp(const AlertaDay());
}