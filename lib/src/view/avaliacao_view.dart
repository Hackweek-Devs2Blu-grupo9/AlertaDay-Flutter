import 'package:flutter/material.dart';
import 'package:alertaday/src/controller/avaliacao_controller.dart';

class AvaliacaoView extends StatefulWidget {
  const AvaliacaoView({super.key});

  @override
  State<AvaliacaoView> createState() => _AvaliacaoViewState();
}

class _AvaliacaoViewState extends State<AvaliacaoView> {
  final controller = AvaliacaoController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sobre o AlertaDay")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Formulário de Feedback",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: controller.nomeController,
              decoration: const InputDecoration(
                labelText: "Seu nome",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: controller.opiniaoController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "O que você achou do aplicativo?",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              value: controller.satisfacao,
              decoration: const InputDecoration(
                labelText: "Nível de satisfação",
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: "Excelente", child: Text("Excelente")),
                DropdownMenuItem(value: "Bom", child: Text("Bom")),
                DropdownMenuItem(value: "Regular", child: Text("Regular")),
                DropdownMenuItem(value: "Ruim", child: Text("Ruim")),
              ],
              onChanged: (value) {
                setState(() {
                  controller.satisfacao = value!;
                });
              },
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  controller.enviarFeedback(context);
                },
                child: const Text("Enviar"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
