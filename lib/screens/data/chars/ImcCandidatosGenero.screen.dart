import 'package:flutter/material.dart';
import 'package:teste_wk_app/models/ImcGenero.dart';
import 'package:teste_wk_app/services/web/api.services.dart' as api;
import 'package:teste_wk_app/utils/widgets/chars/PieChartSample3.dart';

import '../../../utils/widgets/AppBarWidget.dart';

class ImcCandidatosGeneroScreen extends StatefulWidget {
  const ImcCandidatosGeneroScreen({super.key});

  @override
  State<ImcCandidatosGeneroScreen> createState() =>
      _ImcCandidatosGeneroScreenState();
}

class _ImcCandidatosGeneroScreenState extends State<ImcCandidatosGeneroScreen> {
  late Future<List<ImcGenero>> imcCandidatosGenero;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imcCandidatosGenero = api.geImcPorGenero();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: "IMC Genero",
      ),
      body: FutureBuilder<List<ImcGenero>>(
        future: imcCandidatosGenero,
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [PieChartSample3(imcList: imcList)],
            ),
          );
        },
      ),
    );
  }
}
