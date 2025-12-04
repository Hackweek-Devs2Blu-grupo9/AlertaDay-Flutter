import 'package:flutter/material.dart';
import 'package:alertaday/src/controller/about_controller.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AboutController();
    final faq = controller.getFAQ();

    return Scaffold(
      appBar: AppBar(title: const Text("Sobre")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: faq.length,
        itemBuilder: (context, index) {
          final item = faq[index];

          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 16),
            child: ExpansionTile(
              title: Text(
                item.pergunta,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              childrenPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              children: [
                Text(
                  item.resposta,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
