import 'package:flutter/material.dart';
import 'package:teste_wk_app/screens/data/chars/DoadoresValidos.screen.dart';
import 'package:teste_wk_app/screens/data/chars/ImcCandidatosGenero.screen.dart';
import 'package:teste_wk_app/screens/data/chars/ImcCharsFaixaEtaria.screen.dart';
import 'package:teste_wk_app/screens/data/chars/ListarCandidatosEstado.screen.dart';
import 'package:teste_wk_app/screens/data/chars/MediaTipoSanguineo.screen.dart';
import 'package:teste_wk_app/utils/widgets/AppBarWidget.dart';

class DataSelectScreen extends StatefulWidget {
  const DataSelectScreen({super.key});

  @override
  State<DataSelectScreen> createState() => _DataSelectScreenState();
}

class _DataSelectScreenState extends State<DataSelectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: "Visualizar Gráficos"),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Número de itens por linha
          ),
          children: [
            Card(
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                splashColor: Colors.redAccent.withAlpha(10),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => ImcFaixaEtariaScreen()));
                  debugPrint('Card tapped.');
                },
                child: Column(
                  children: [
                    Image.network(
                        "https://media.istockphoto.com/id/1480574526/pt/foto/happy-multigenerational-people-having-fun-sitting-on-grass-in-a-public-park.jpg?s=1024x1024&w=is&k=20&c=-gWjmzmO3z5yFxR0TvSnDYTzU_KdJH0jCIrM2FGKowE="),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    const Center(
                      child: Text('IMC por faixa etaria'),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                splashColor: Colors.redAccent.withAlpha(10),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => ListaCandidatosEstadoScreen()));
                },
                child: Column(
                  children: [
                    Image.network(
                        "https://media.istockphoto.com/id/1480574526/pt/foto/happy-multigenerational-people-having-fun-sitting-on-grass-in-a-public-park.jpg?s=1024x1024&w=is&k=20&c=-gWjmzmO3z5yFxR0TvSnDYTzU_KdJH0jCIrM2FGKowE="),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    const Center(
                      child: Text('Doador por estado.'),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                splashColor: Colors.redAccent.withAlpha(10),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => ImcCandidatosGeneroScreen()));
                  debugPrint('Card tapped.');
                },
                child: Column(
                  children: [
                    Image.network(
                        "https://media.istockphoto.com/id/1480574526/pt/foto/happy-multigenerational-people-having-fun-sitting-on-grass-in-a-public-park.jpg?s=1024x1024&w=is&k=20&c=-gWjmzmO3z5yFxR0TvSnDYTzU_KdJH0jCIrM2FGKowE="),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    const Center(
                      child: Text('IMC por genero'),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                splashColor: Colors.redAccent.withAlpha(10),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) =>
                              const MediaTipoSanguineoScreen()));
                  debugPrint('Card tapped.');
                },
                child: Column(
                  children: [
                    Image.network(
                        "https://media.istockphoto.com/id/1480574526/pt/foto/happy-multigenerational-people-having-fun-sitting-on-grass-in-a-public-park.jpg?s=1024x1024&w=is&k=20&c=-gWjmzmO3z5yFxR0TvSnDYTzU_KdJH0jCIrM2FGKowE="),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    const Center(
                      child: Text('Média tipo sanguineo'),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                splashColor: Colors.redAccent.withAlpha(10),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => const DoadoresValidosScreen()));
                  debugPrint('Card tapped.');
                },
                child: Column(
                  children: [
                    Image.network(
                        "https://media.istockphoto.com/id/1480574526/pt/foto/happy-multigenerational-people-having-fun-sitting-on-grass-in-a-public-park.jpg?s=1024x1024&w=is&k=20&c=-gWjmzmO3z5yFxR0TvSnDYTzU_KdJH0jCIrM2FGKowE="),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    const Center(
                      child: Text('Doadores'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
