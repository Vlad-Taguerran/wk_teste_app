import 'package:flutter/material.dart';
import 'package:teste_wk_app/models/IMCFaixaEtaria.dart';
import 'package:teste_wk_app/services/web/api.services.dart' as api;
import 'package:teste_wk_app/utils/widgets/AppBarWidget.dart';
import 'package:teste_wk_app/utils/widgets/chars/BarChartSample7.dart';

class ImcFaixaEtariaScreen extends StatefulWidget {
  const ImcFaixaEtariaScreen({super.key});

  @override
  State<ImcFaixaEtariaScreen> createState() => _ImcFaixaEtariaScreenState();
}

class _ImcFaixaEtariaScreenState extends State<ImcFaixaEtariaScreen> {
  late Future<List<IMCFaixaEtaria>> imcFaixaetariaFuture;

  final List<Color> _colors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.yellow,
    Colors.teal
  ]; // Cores fixas para cada faixa etária

  @override
  void initState() {
    super.initState();
    imcFaixaetariaFuture = api.getImcFaixaEtaria();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: "IMC Faixa Etaria",
      ),
      body: FutureBuilder<List<IMCFaixaEtaria>>(
        future: imcFaixaetariaFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Erro ao carregar os dados"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Nenhum dado disponível"));
          }

          final imcList = snapshot.data!;

          return Container(
            child: Column(
              children: [
                BarChartSample7(imcList, _colors),
                const SizedBox(height: 20),
                _buildLegend(imcList),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLegend(List<IMCFaixaEtaria> imcList) {
    return Expanded(
      child: GridView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Define duas colunas
          crossAxisSpacing: 16.0, // Espaço entre as colunas
          mainAxisSpacing: 16.0, // Espaço entre as linhas
          childAspectRatio: 2, // Ajusta a proporção dos itens (largura/altura)
        ),
        itemCount: imcList.length,
        itemBuilder: (context, index) {
          final faixaEtaria = imcList[index].faixaEtaria;
          final imc = imcList[index].imcMedio;
          final color = _colors[index % _colors.length];

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
                    decoration:
                        BoxDecoration(color: color, shape: BoxShape.circle),
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
                        style: TextStyle(color: Colors.black26),
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
