class IMCFaixaEtaria {
  final int faixaEtaria;
  final double imcMedio;

  IMCFaixaEtaria({
    required this.faixaEtaria,
    required this.imcMedio,
  });

  // Método para criar o DTO a partir de um mapa (para conversão de JSON)
  factory IMCFaixaEtaria.fromJson(Map<String, dynamic> json) {
    return IMCFaixaEtaria(
      faixaEtaria: json['faixaEtaria'],
      imcMedio: json['imcMedio'].toDouble(),
    );
  }

  // Método para converter o DTO para um mapa (para serialização de JSON)
  Map<String, dynamic> toJson() {
    return {
      'faixaEtaria': faixaEtaria,
      'imcMedio': imcMedio,
    };
  }
}
