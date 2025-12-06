import 'package:alertaday/src/model/faq_model.dart';

class AboutController {
  List<FAQ> getFAQ() {
    return [
      FAQ(
        pergunta: "O que é o AlertaDay?",
        resposta:
            "O AlertaDay é um aplicativo da Defesa Civil para enviar alertas de risco em tempo real.",
      ),
      FAQ(
        pergunta: "Como recebo alertas?",
        resposta:
            "Os alertas são enviados via notificações. Verifique se as permissões estão ativadas.",
      ),
      FAQ(
        pergunta: "O app funciona offline?",
        resposta:
            "Sim, mas os alertas exigem conexão ativa com a internet.",
      ),
      FAQ(
        pergunta: "Meus dados são seguros?",
        resposta:
            "Sim, o app segue a LGPD e não compartilha seus dados com terceiros.",
      ),
      FAQ(
        pergunta: "O que fazer em caso de evacuação?",
        resposta:
            "Siga imediatamente as orientações da Defesa Civil e vá ao ponto seguro indicado.",
      ),
    ];
  }
}
