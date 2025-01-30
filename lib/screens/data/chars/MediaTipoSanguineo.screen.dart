import 'package:flutter/material.dart';
import 'package:teste_wk_app/models/MediaIdadeTipoSanguineo.dart';
import 'package:teste_wk_app/services/web/api.services.dart' as api;
import 'package:teste_wk_app/utils/widgets/AppBarWidget.dart';

class MediaTipoSanguineoScreen extends StatefulWidget {
  const MediaTipoSanguineoScreen({super.key});
  @override
  State<MediaTipoSanguineoScreen> createState() =>
      _MediaTipoSanguineoScreenState();
}

class _MediaTipoSanguineoScreenState extends State<MediaTipoSanguineoScreen> {
  late Future<List<MediaIdadeTipoSanguineo>> list;
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
    getMediaTipoSanguineo();
  }

  void getMediaTipoSanguineo() {
    list = api.geMediaTipoSanguineo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: "Média Idade"),
      body: FutureBuilder<List<MediaIdadeTipoSanguineo>>(
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
                  final media = _list[index].mediaIdade;
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
                                "Média " + media.toInt().toString() + " Anos",
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
