import 'package:flutter/material.dart';
import "package:teste_wk_app/services/web/api.services.dart" as api;
import 'package:teste_wk_app/utils/widgets/AppBarWidget.dart';

import '../../../models/Doadores.dart';

class DoadoresValidosScreen extends StatefulWidget {
  const DoadoresValidosScreen({super.key});

  @override
  State<DoadoresValidosScreen> createState() => _DoadoresValidosScreenState();
}

class _DoadoresValidosScreenState extends State<DoadoresValidosScreen> {
  late Future<List<Doadores>> list;
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
    // TODO: implement initState
    super.initState();
    getQtdDoadores();
  }

  void getQtdDoadores() {
    list = api.getDoadores();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: "Doadores Validos"),
      body: FutureBuilder<List<Doadores>>(
          future: list,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text("Erro ao carregar os dados"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("Nenhum dado disponível"));
            }

            final _list = snapshot.data!;

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
                itemCount: _list.length,
                itemBuilder: (context, index) {
                  final tipo = _list[index].tipoSanguineo;
                  final qtd = _list[index].quantidadeDoadores;
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
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Tipo : $tipo",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              Text(
                                "Quantidade : $qtd",
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
          }),
    );
  }
}
