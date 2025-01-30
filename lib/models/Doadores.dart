class Doadores {
  final String tipoSanguineo;
  final int quantidadeDoadores;

  Doadores({
    required this.tipoSanguineo,
    required this.quantidadeDoadores,
  });

  // Converte um JSON para um objeto DoadorDTO
  factory Doadores.fromJson(Map<String, dynamic> json) {
    return Doadores(
      tipoSanguineo: json['tipoSanguineo'],
      quantidadeDoadores: json['quantidadeDoadores'],
    );
  }

  // Converte um objeto DoadorDTO para JSON
  Map<String, dynamic> toJson() {
    return {
      'tipoSanguineo': tipoSanguineo,
      'quantidadeDoadores': quantidadeDoadores,
    };
  }

  // Converte uma lista de JSONs para uma lista de objetos DoadorDTO
  static List<Doadores> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Doadores.fromJson(json)).toList();
  }
}
