class EstadoCandidatos {
  final String estado;
  final int totalCandidatos;

  EstadoCandidatos({
    required this.estado,
    required this.totalCandidatos,
  });

  // Método para converter um JSON em um objeto EstadoCandidatosDTO
  factory EstadoCandidatos.fromJson(Map<String, dynamic> json) {
    return EstadoCandidatos(
      estado: json['estado'],
      totalCandidatos: json['totalCandidatos'],
    );
  }

  // Método para converter um objeto EstadoCandidatosDTO em um JSON
  Map<String, dynamic> toJson() {
    return {
      'estado': estado,
      'totalCandidatos': totalCandidatos,
    };
  }

  // Método para converter uma lista de JSONs em uma lista de objetos
  static List<EstadoCandidatos> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => EstadoCandidatos.fromJson(json)).toList();
  }
}
