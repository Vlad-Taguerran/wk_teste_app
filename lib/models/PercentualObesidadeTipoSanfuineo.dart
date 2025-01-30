class PercentualObesidadeDTO {
  final String sexo;
  final double percentualObesos;

  PercentualObesidadeDTO({
    required this.sexo,
    required this.percentualObesos,
  });

  // Converte um JSON para um objeto PercentualObesidadeDTO
  factory PercentualObesidadeDTO.fromJson(Map<String, dynamic> json) {
    return PercentualObesidadeDTO(
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
  static List<PercentualObesidadeDTO> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => PercentualObesidadeDTO.fromJson(json))
        .toList();
  }
}
