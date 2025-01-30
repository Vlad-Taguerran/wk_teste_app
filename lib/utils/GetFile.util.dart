import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:teste_wk_app/models/Candidatos.dart';
import 'package:teste_wk_app/services/web/api.services.dart' as api;

FutureOr<String?> jsonFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['json'],
  );
  if (result != null) {
    return result.files.single.path;
  } else {
    return null;
  }
}

FutureOr<List<dynamic>> readJsonFile(String filePath) async {
  try {
    final file = File(filePath);
    final contents = await file.readAsString();

    return jsonDecode(contents);
  } catch (e) {
    print('Erro ao ler o arquivo JSON: $e');
    return [];
  }
}

void handleSendJson() async {
  // 1. Selecionar o arquivo JSON
  String? filePath = await jsonFile();
  if (filePath != null) {
    // 2. Ler o conteúdo JSON do arquivo
    List<dynamic> jsonData = await readJsonFile(filePath);
    List<Candidato> candidatos =
        jsonData.map((item) => Candidato.fromJson(item)).toList();

    if (jsonData != null) {
      // 3. Enviar o JSON para o servidor
      await api.sendJsonToApi(candidatos);
    } else {
      print('Erro ao ler os dados do arquivo JSON');
    }
  } else {
    print('Nenhum arquivo selecionado');
  }
}
