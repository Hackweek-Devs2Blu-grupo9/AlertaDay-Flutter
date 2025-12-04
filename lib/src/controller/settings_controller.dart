import 'package:flutter/material.dart';

class SettingsController extends ChangeNotifier {
  bool notificacoes = true;
  bool somAlerta = true;
  bool altoContraste = false;
  double tamanhoFonte = 1.0; // 1.0 = normal
  ThemeMode tema = ThemeMode.system;

  void toggleNotificacoes(bool value) {
    notificacoes = value;
    notifyListeners();
  }

  void toggleSom(bool value) {
    somAlerta = value;
    notifyListeners();
  }

  void toggleAltoContraste(bool value) {
    altoContraste = value;
    notifyListeners();
  }

  void alterarTamanhoFonte(double value) {
    tamanhoFonte = value;
    notifyListeners();
  }

  // 🟢 CORRIGIDO → agora aceita ThemeMode? (resolve o erro)
  void alterarTema(ThemeMode? value) {
    if (value == null) return;
    tema = value;
    notifyListeners();
  }
}
