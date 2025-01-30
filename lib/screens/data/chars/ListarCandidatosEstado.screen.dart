import 'package:flutter/material.dart';
import 'package:teste_wk_app/models/EstadoCandidatos.dart';
import 'package:teste_wk_app/services/web/api.services.dart' as api;
import 'package:teste_wk_app/utils/widgets/AppBarWidget.dart';

class ListaCandidatosEstadoScreen extends StatefulWidget {
  const ListaCandidatosEstadoScreen({super.key});

  @override
  State<ListaCandidatosEstadoScreen> createState() =>
      _ListaCandidatosEstadoScreenState();
}

class _ListaCandidatosEstadoScreenState
    extends State<ListaCandidatosEstadoScreen> {
  List<EstadoCandidatos> candidatos = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDoadoresEstado();
  }

  void getDoadoresEstado() async {
    var list = await api.getCandidatosPorEstado();
    setState(() {
      candidatos = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Candidatos por estado"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: candidatos.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : DataTable(
                    border: TableBorder.all(),
                    columns: const [
                      DataColumn(label: Text("Estado")),
                      DataColumn(label: Text("Candidatos"))
                    ],
                    rows: candidatos.map((candidato) {
                      return DataRow(cells: [
                        DataCell(Text(candidato.estado)),
                        DataCell(Text(candidato.totalCandidatos.toString()))
                      ]);
                    }).toList()),
          ),
        ),
      ),
    );
  }
}
