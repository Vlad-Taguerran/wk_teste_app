import 'package:flutter/material.dart';

class LegendCharsWidget extends StatelessWidget {
  final List<dynamic> list;
  final List<Color> colors;

  const LegendCharsWidget({
    super.key,
    required this.list,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Duas colunas
          crossAxisSpacing: 16.0, // Espaço entre colunas
          mainAxisSpacing: 16.0, // Espaço entre linhas
          childAspectRatio: 2, // Ajusta a proporção dos itens
        ),
        itemCount: list.length,
        itemBuilder: (context, index) {
          final faixaEtaria = list[index].faixaEtaria;
          final imc = list[index].imcMedio;
          final color = colors[index % colors.length];

          return Card(
            elevation: 5,
            color: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Faixa $faixaEtaria+",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      Text(
                        "IMC: $imc~",
                        style: const TextStyle(color: Colors.black26),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
