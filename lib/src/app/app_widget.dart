import 'package:alertaday/src/app/app_routes.dart';
import 'package:alertaday/src/theme/color_theme.dart';
import 'package:flutter/material.dart';

class AlertaDay extends StatelessWidget {
  const AlertaDay({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AlertaDay',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: AppRoutes.home,
      routes: AppRoutes.routes,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
