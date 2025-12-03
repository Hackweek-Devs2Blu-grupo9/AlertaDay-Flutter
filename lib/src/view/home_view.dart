import 'package:flutter/material.dart';
import 'package:alertaday/src/app/app_menu.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      drawer: const AppMenu(),
      body: const Center(child: Text('Conteúdo da Home')),
    );
  }
}