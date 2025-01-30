import 'package:flutter/material.dart';
import 'package:teste_wk_app/custom/BloodAnimation.dart';
import 'package:teste_wk_app/screens/data/DataSelect.screen.dart';
import 'package:teste_wk_app/screens/doadores/CadastrarDoador.screen.dart';
import 'package:teste_wk_app/utils/GetFile.util.dart' as utils;
import 'package:teste_wk_app/utils/widgets/AppBarWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: "wk_app"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                "Total de candidatos",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              BloodAnimation(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => utils.handleSendJson(),
                      child: Text("Importar"),
                    ),
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width *
                          0.09), // Espaço entre os botões
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => CadastrarDoadorScreen()));
                      },
                      child: Text("Cadastrar"),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16), // Espaço entre a linha e o botão de baixo
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => DataSelectScreen()));
                },
                child: Text("Visualizar"),
                style: ElevatedButton.styleFrom(
                  minimumSize:
                      Size(double.infinity, 48), // Ocupa toda a largura
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
