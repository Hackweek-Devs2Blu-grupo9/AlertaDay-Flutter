import 'package:flutter/material.dart';
import 'package:alertaday/src/model/home_model.dart';

class HomeController extends ChangeNotifier {
  final List<DefesaCivilInfo> dicas = [
    DefesaCivilInfo(
      titulo: "Chuva forte",
      descricao: "Evite áreas alagadas. Fique longe de postes e árvores.",
      icone: "🌧️",
    ),
    DefesaCivilInfo(
      titulo: "Deslizamento",
      descricao: "Observe rachaduras nas paredes e no chão. Saia do local imediatamente.",
      icone: "⛰️",
    ),
    DefesaCivilInfo(
      titulo: "Tempestade com raios",
      descricao: "Desconecte aparelhos elétricos e evite ficar ao ar livre.",
      icone: "⚡",
    ),
    DefesaCivilInfo(
      titulo: "Enchente",
      descricao: "Não atravesse correntezas. Procure um local elevado.",
      icone: "🌊",
    ),
  ];
}
