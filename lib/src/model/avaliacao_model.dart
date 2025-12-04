class AvaliacaoModel {
  final String nome;
  final String opiniao;
  final String satisfacao;
  final DateTime dataEnvio;

  AvaliacaoModel({
    required this.nome,
    required this.opiniao,
    required this.satisfacao,
    required this.dataEnvio,
  });

  Map<String, dynamic> toMap() {
    return {
      "nome": nome,
      "opiniao": opiniao,
      "satisfacao": satisfacao,
      "dataEnvio": dataEnvio.toIso8601String(),
    };
  }

  factory AvaliacaoModel.fromMap(Map<String, dynamic> map) {
    return AvaliacaoModel(
      nome: map["nome"],
      opiniao: map["opiniao"],
      satisfacao: map["satisfacao"],
      dataEnvio: DateTime.parse(map["dataEnvio"]),
    );
  }
}
