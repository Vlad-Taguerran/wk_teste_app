class MediaIdadeTipoSanguineo {
  final String tipoSanguineo;
  final double mediaIdade;

  MediaIdadeTipoSanguineo({
    required this.tipoSanguineo,
    required this.mediaIdade,
  });

  // Converte um JSON para um objeto TipoSanguineoDTO
  factory MediaIdadeTipoSanguineo.fromJson(Map<String, dynamic> json) {
    return MediaIdadeTipoSanguineo(
      tipoSanguineo: json['tipoSanguineo'],
      mediaIdade: (json['mediaIdade'] as num).toDouble(),
    );
  }

  // Converte um objeto TipoSanguineoDTO para JSON
  Map<String, dynamic> toJson() {
    return {
      'tipoSanguineo': tipoSanguineo,
      'mediaIdade': mediaIdade,
    };
  }

  // Converte uma lista de JSONs para uma lista de objetos
  static List<MediaIdadeTipoSanguineo> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => MediaIdadeTipoSanguineo.fromJson(json))
        .toList();
  }
}
