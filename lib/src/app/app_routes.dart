import 'package:alertaday/src/view/about_view.dart';
import 'package:flutter/material.dart';
import 'package:alertaday/src/view/home_view.dart';
import 'package:alertaday/src/view/settings_view.dart';
import 'package:alertaday/src/view/avaliacao_view.dart';

class AppRoutes {
  AppRoutes._();

  static const String home = '/';
  static const String settings = '/settings';
  static const String avaliacao = '/avaliacao';
  static const String about = '/about';

  // Mapa de rotas (útil para `routes:` do MaterialApp)
  static Map<String, WidgetBuilder> get routes => {
        home: (_) => const HomeView(),
        settings: (_) => const SettingsView(),
        avaliacao: (_) => const AvaliacaoView(),
        about: (_) => const AboutView(),
      };

  // - Faz lookup no mapa `routes`
  // - Permite fallback para rota não encontrada
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final builder = routes[settings.name];
    if (builder != null) {
      
      // Se precisar ler argumentos:
      // final args = settings.arguments;
      return MaterialPageRoute(
        builder: (context) => builder(context),
        settings: settings,
      );
    }

    // Fallback (rota não encontrada)
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Rota não encontrada')),
        body: Center(child: Text('Rota não encontrada: ${settings.name}')),
      ),
      settings: settings,
    );
  }
}