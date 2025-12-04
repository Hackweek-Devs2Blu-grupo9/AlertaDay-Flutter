import 'package:flutter/material.dart';
import 'package:alertaday/src/model/avaliacao_model.dart';

class AvaliacaoController {
  final nomeController = TextEditingController();
  final opiniaoController = TextEditingController();
  String satisfacao = "Excelente";

  AvaliacaoModel? ultimoFeedback; // opcional

  AvaliacaoModel montarFeedback() {
    return AvaliacaoModel(
      nome: nomeController.text,
      opiniao: opiniaoController.text,
      satisfacao: satisfacao,
      dataEnvio: DateTime.now(),
    );
  }

  void enviarFeedback(BuildContext context) {
    if (nomeController.text.isEmpty || opiniaoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Preencha todos os campos!")),
      );
      return;
    }

    final feedback = montarFeedback();
    ultimoFeedback = feedback;

    // Aqui você pode enviar para API, Firebase, MySQL, Supabase...
    print("=== FEEDBACK ENVIADO ===");
    print(feedback.toMap());

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Feedback enviado!")),
    );

    // Limpar campos
    nomeController.clear();
    opiniaoController.clear();
  }
}
