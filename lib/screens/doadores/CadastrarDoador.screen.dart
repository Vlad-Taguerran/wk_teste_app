import 'package:flutter/material.dart';
import 'package:teste_wk_app/models/Candidatos.dart';
import 'package:teste_wk_app/services/web/api.services.dart' as api;
import 'package:teste_wk_app/utils/widgets/AppBarWidget.dart';

class CadastrarDoadorScreen extends StatefulWidget {
  @override
  _CadastrarDoadorScreenState createState() => _CadastrarDoadorScreenState();
}

class _CadastrarDoadorScreenState extends State<CadastrarDoadorScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controladores dos campos
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _rgController = TextEditingController();
  final TextEditingController _dataNascController = TextEditingController();
  final TextEditingController _sexoController = TextEditingController();
  final TextEditingController _maeController = TextEditingController();
  final TextEditingController _paiController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _enderecoController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _celularController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _tipoSanguineoController =
      TextEditingController();

  Candidato getCandidatoFromForm() {
    return Candidato(
      nome: _nomeController.text,
      cpf: _cpfController.text,
      rg: _rgController.text,
      dataNasc: _dataNascController.text,
      sexo: _sexoController.text,
      mae: _maeController.text,
      pai: _paiController.text,
      email: _emailController.text,
      cep: _cepController.text,
      endereco: _enderecoController.text,
      numero: int.tryParse(_numeroController.text) ?? 0,
      bairro: _bairroController.text,
      cidade: _cidadeController.text,
      estado: _estadoController.text,
      telefoneFixo: _telefoneController.text,
      celular: _celularController.text,
      altura: double.tryParse(_alturaController.text) ?? 0.0,
      peso: double.tryParse(_pesoController.text) ?? 0.0,
      tipoSanguineo: _tipoSanguineoController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: "Cadastrar Doador"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('Dados Pessoais'),
                _buildTextField(_nomeController, 'Nome Completo', Icons.person),
                _buildTextField(_cpfController, 'CPF', Icons.credit_card),
                _buildTextField(_rgController, 'RG', Icons.badge),
                _buildTextField(_dataNascController, 'Data de Nascimento',
                    Icons.calendar_today),
                _buildTextField(_sexoController, 'Sexo', Icons.wc),
                _buildTextField(
                    _maeController, 'Nome da Mãe', Icons.family_restroom),
                _buildTextField(
                    _paiController, 'Nome do Pai', Icons.family_restroom),
                _buildSectionTitle('Contato'),
                _buildTextField(_emailController, 'E-mail', Icons.email),
                _buildTextField(
                    _telefoneController, 'Telefone Fixo', Icons.phone),
                _buildTextField(
                    _celularController, 'Celular', Icons.smartphone),
                _buildSectionTitle('Endereço'),
                _buildTextField(_cepController, 'CEP', Icons.location_on),
                _buildTextField(_enderecoController, 'Endereço', Icons.home),
                _buildTextField(
                    _numeroController, 'Número', Icons.confirmation_number),
                _buildTextField(_bairroController, 'Bairro', Icons.map),
                _buildTextField(
                    _cidadeController, 'Cidade', Icons.location_city),
                _buildTextField(_estadoController, 'Estado', Icons.flag),
                _buildSectionTitle('Saúde'),
                _buildTextField(_alturaController, 'Altura (m)', Icons.height),
                _buildTextField(
                    _pesoController, 'Peso (kg)', Icons.fitness_center),
                _buildTextField(_tipoSanguineoController, 'Tipo Sanguíneo',
                    Icons.bloodtype),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Candidato _candidato = getCandidatoFromForm();
                        List<Candidato> salvar = [];
                        salvar.add(_candidato);
                        api.sendJsonToApi(salvar);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Cadastro realizado com sucesso!')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Cadastrar',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, preencha este campo';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
      ),
    );
  }
}
