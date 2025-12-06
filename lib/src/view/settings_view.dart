import 'package:flutter/material.dart';
import 'package:alertaday/src/controller/settings_controller.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final controller = SettingsController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Configurações")),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // 🔊 Notificações
              SwitchListTile(
                title: const Text("Receber notificações"),
                value: controller.notificacoes,
                onChanged: controller.toggleNotificacoes,
              ),

              // 🔔 Som
              SwitchListTile(
                title: const Text("Som de alerta"),
                value: controller.somAlerta,
                onChanged: controller.toggleSom,
              ),

              // 🌗 Tema
              const SizedBox(height: 20),
              const Text("Tema"),
              DropdownButton<ThemeMode>(
                value: controller.tema,
                isExpanded: true,
                items: const [
                  DropdownMenuItem(
                      value: ThemeMode.system, child: Text("Sistema")),
                  DropdownMenuItem(
                      value: ThemeMode.light, child: Text("Claro")),
                  DropdownMenuItem(
                      value: ThemeMode.dark, child: Text("Escuro")),
                ],
                onChanged: controller.alterarTema,
              ),

              const SizedBox(height: 20),

              // 🅰 Tamanho da fonte
              const Text("Tamanho da fonte"),
              Slider(
                value: controller.tamanhoFonte,
                min: 0.8,
                max: 1.4,
                divisions: 6,
                label: "${(controller.tamanhoFonte * 100).round()}%",
                onChanged: controller.alterarTamanhoFonte,
              ),

              // ♿ Alto contraste
              SwitchListTile(
                title: const Text("Modo alto contraste"),
                value: controller.altoContraste,
                onChanged: controller.toggleAltoContraste,
              ),
            ],
          );
        },
      ),
    );
  }
}
