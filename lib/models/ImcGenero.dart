class ImcGenero {
  final String sexo;
  final double percentualObesos;

  ImcGenero({
    required this.sexo,
    required this.percentualObesos,
  });

  // Converte um JSON para um objeto PercentualObesidadeDTO
  factory ImcGenero.fromJson(Map<String, dynamic> json) {
    return ImcGenero(
      sexo: json['sexo'],
      percentualObesos: (json['percentualObesos'] as num).toDouble(),
    );
  }

  // Converte um objeto PercentualObesidadeDTO para JSON
  Map<String, dynamic> toJson() {
    return {
      'sexo': sexo,
      'percentualObesos': percentualObesos,
    };
  }

  // Converte uma lista de JSONs para uma lista de objetos
  static List<ImcGenero> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ImcGenero.fromJson(json)).toList();
  }
}
