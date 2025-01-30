import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:teste_wk_app/models/Candidatos.dart';
import 'package:teste_wk_app/models/Doadores.dart';
import 'package:teste_wk_app/models/EstadoCandidatos.dart';
import 'package:teste_wk_app/models/IMCFaixaEtaria.dart';
import 'package:teste_wk_app/models/ImcGenero.dart';
import 'package:teste_wk_app/models/MediaIdadeTipoSanguineo.dart';

final url = dotenv.env['API_BASE_URL'];

FutureOr<void> sendJsonToApi(List<Candidato> jsonData) async {
  try {
    final response = await http.post(
      Uri.parse('$url/candidatos'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(jsonData),
    );

    if (response.statusCode == 200) {
      print('Dados enviados com sucesso!');
    } else {
      print('Erro ao enviar os dados: ${response.statusCode}');
    }
  } catch (e) {
    print(e);
  }
}

Future<String> getTotalCandidatos() async {
  try {
    var response = await http.get(Uri.parse("$url/candidatos/total"));

    if (response.statusCode != 200 || response.body.isEmpty) {
      return "0";
    }
    return response.body;
  } catch (e) {
    print(e);
    return "0";
  }
}

Future<List<EstadoCandidatos>> getCandidatosPorEstado() async {
  print(url);
  try {
    var response = await http.get(Uri.parse("$url/candidatos"));

    if (response.statusCode != 200) {
      return [];
    }

    List<dynamic> jsonData = json.decode(response.body);
    List<EstadoCandidatos> estadoCandidato =
        jsonData.map((item) => EstadoCandidatos.fromJson(item)).toList();

    return estadoCandidato;
  } catch (e) {
    debugPrint("Erro ao buscar dados da API: $e");
    return [];
  }
}

Future<List<ImcGenero>> geImcPorGenero() async {
  try {
    var response = await http.get(Uri.parse("$url/candidatos/imc-genero"));

    if (response.statusCode != 200) {
      return [];
    }

    List<dynamic> jsonData = json.decode(response.body);
    List<ImcGenero> imcGenero =
        jsonData.map((item) => ImcGenero.fromJson(item)).toList();

    return imcGenero;
  } catch (e) {
    debugPrint("Erro ao buscar dados da API: $e");
    return [];
  }
}

Future<List<MediaIdadeTipoSanguineo>> geMediaTipoSanguineo() async {
  try {
    var response =
        await http.get(Uri.parse("$url/candidatos/media-idade-tipo-sanguineo"));

    if (response.statusCode != 200) {
      return [];
    }

    List<dynamic> jsonData = json.decode(response.body);
    List<MediaIdadeTipoSanguineo> tipoSangineo =
        jsonData.map((item) => MediaIdadeTipoSanguineo.fromJson(item)).toList();

    return tipoSangineo;
  } catch (e) {
    debugPrint("Erro ao buscar dados da API: $e");
    return [];
  }
}

Future<List<Doadores>> getDoadores() async {
  try {
    var response =
        await http.get(Uri.parse("$url/candidatos/quantidade-doadores"));

    if (response.statusCode != 200) {
      return [];
    }

    List<dynamic> jsonData = json.decode(response.body);
    List<Doadores> tipoSangineo =
        jsonData.map((item) => Doadores.fromJson(item)).toList();

    return tipoSangineo;
  } catch (e) {
    debugPrint("Erro ao buscar dados da API: $e");
    return [];
  }
}

Future<List<IMCFaixaEtaria>> getImcFaixaEtaria() async {
  try {
    var response = await http.get(Uri.parse("$url/candidatos/imc-faixaetaria"));

    if (response.statusCode != 200) {
      return [];
    }

    List<dynamic> jsonData = json.decode(response.body);
    List<IMCFaixaEtaria> imcList =
        jsonData.map((item) => IMCFaixaEtaria.fromJson(item)).toList();

    return imcList;
  } catch (e) {
    debugPrint("Erro ao buscar dados da API: $e");
    return [];
  }
}
