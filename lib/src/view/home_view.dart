import 'package:flutter/material.dart';
import 'package:alertaday/src/app/app_menu.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:vibration/vibration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final FlutterTts tts = FlutterTts();

  bool altoContraste = false;
  bool fonteGrande = false;
  bool vibracaoForte = false;
  bool leituraTela = false;

  @override
  void initState() {
    super.initState();
    carregarPreferencias();
  }

  Future<void> carregarPreferencias() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      altoContraste = pref.getBool("altoContraste") ?? false;
      fonteGrande = pref.getBool("fonteGrande") ?? false;
      vibracaoForte = pref.getBool("vibracaoForte") ?? false;
      leituraTela = pref.getBool("leituraTela") ?? false;
    });
  }

  Future<void> salvarPreferencias() async {
    final pref = await SharedPreferences.getInstance();
    pref.setBool("altoContraste", altoContraste);
    pref.setBool("fonteGrande", fonteGrande);
    pref.setBool("vibracaoForte", vibracaoForte);
    pref.setBool("leituraTela", leituraTela);
  }

  Future<void> falar(String texto) async {
    if (!leituraTela) return;
    await tts.setLanguage("pt-BR");
    await tts.setSpeechRate(0.9);
    await tts.speak(texto);
  }

  Future<void> vibrar() async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: vibracaoForte ? 400 : 200);
    }
  }

  // ===============================
  //   CONSTRUÇÃO DA TELA
  // ===============================

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: altoContraste
          ? ThemeData(
              colorScheme: ColorScheme.highContrastLight(),
              textTheme: Theme.of(context).textTheme.apply(
                    fontSizeFactor: fonteGrande ? 1.3 : 1.0,
                  ),
            )
          : Theme.of(context).copyWith(
              textTheme: Theme.of(context).textTheme.apply(
                    fontSizeFactor: fonteGrande ? 1.3 : 1.0,
                  ),
            ),
      child: Scaffold(
        drawer: const AppMenu(),
        appBar: AppBar(
          title: const Text('AlertaDay'),
        ),

        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // -------------------------------------
            // BANNER
            // -------------------------------------
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.primary.withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(Icons.campaign_rounded, size: 48, color: Colors.white),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      "Bem-vindo ao AlertaDay!\nAcompanhe alertas e orientações da Defesa Civil.",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // -------------------------------------
            // ÚLTIMOS ALERTAS
            // -------------------------------------
            Text(
              "Últimos Alertas",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),

            _alertCard(
              context: context,
              icon: Icons.water_drop_rounded,
              title: "Risco de Enchente",
              message: "A Defesa Civil identificou risco elevado de alagamentos.",
            ),
            _alertCard(
              context: context,
              icon: Icons.terrain_rounded,
              title: "Deslizamento de Terra",
              message: "Possibilidade de deslizamentos em áreas de encosta.",
            ),
            _alertCard(
              context: context,
              icon: Icons.bolt_rounded,
              title: "Tempestade",
              message: "Chuva intensa com trovoadas nas próximas horas.",
            ),

            const SizedBox(height: 24),

            Text(
              "Orientações da Defesa Civil",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),

            _infoTile(Icons.warning_rounded, "Evite áreas alagadas"),
            _infoTile(Icons.house_rounded, "Mantenha documentos em local seguro"),
            _infoTile(Icons.radio_rounded, "Acompanhe comunicados oficiais"),
            _infoTile(Icons.flashlight_on_rounded, "Tenha lanterna e kit de emergência"),

            const SizedBox(height: 24),

            // -------------------------------------
            // SIMULAÇÃO
            // -------------------------------------
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Simulação",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Faça um teste para ver como notificações e alertas funcionarão no seu aparelho.",
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Simulação enviada!")),
                      );
                      falar("Simulação de alerta enviada!");
                    },
                    icon: const Icon(Icons.notifications_active_rounded),
                    label: const Text("Enviar alerta de teste"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 80),
          ],
        ),

        // ====================================
        // BOTÃO DE ACESSIBILIDADE
        // ====================================
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _abrirMenuAcessibilidade(context),
          icon: const Icon(Icons.accessibility_new_rounded),
          label: const Text("Acessibilidade"),
        ),
      ),
    );
  }

  // ====================================
  //  MENU MODAL DE ACESSIBILIDADE
  // ====================================
  void _abrirMenuAcessibilidade(BuildContext context) {
    vibrar();
    falar("Menu de acessibilidade aberto.");

    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Acessibilidade",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  SwitchListTile(
                    title: const Text("Leitura de tela (TTS)"),
                    value: leituraTela,
                    onChanged: (v) {
                      setModalState(() => leituraTela = v);
                      setState(() {});
                      falar("Leitura de tela ativada.");
                      salvarPreferencias();
                    },
                  ),

                  SwitchListTile(
                    title: const Text("Alto contraste"),
                    value: altoContraste,
                    onChanged: (v) {
                      setModalState(() => altoContraste = v);
                      setState(() {});
                      salvarPreferencias();
                    },
                  ),

                  SwitchListTile(
                    title: const Text("Fonte grande (idosos)"),
                    value: fonteGrande,
                    onChanged: (v) {
                      setModalState(() => fonteGrande = v);
                      setState(() {});
                      salvarPreferencias();
                    },
                  ),

                  SwitchListTile(
                    title: const Text("Vibração forte"),
                    value: vibracaoForte,
                    onChanged: (v) {
                      setModalState(() => vibracaoForte = v);
                      setState(() {});
                      vibrar();
                      salvarPreferencias();
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // -------------------------------------
  // WIDGET: CARD DE ALERTA
  // -------------------------------------
  Widget _alertCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String message,
  }) {
    return GestureDetector(
      onTap: () => falar("$title. $message"),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(icon, size: 40, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 16),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "$title\n",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: message,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoTile(IconData icon, String text) {
    return ListTile(
      onTap: () => falar(text),
      leading: Icon(icon),
      title: Text(text),
    );
  }
}
