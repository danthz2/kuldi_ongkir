import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/kota_model.dart';

class KotaProvider {
  Future<List<KotaModel>> getKotaModel(int id) async {
    var url = Uri.parse('https://api.rajaongkir.com/starter/city?province=$id');
    try {
      var response = await http.get(url, headers: {'key': '11b896ce4c6ead12e44a01bc1f4926bd'});
      var data = jsonDecode(response.body) as Map<String, dynamic>;
      // print('data: $data');
      var listKota = data['rajaongkir']['results'] as List<dynamic>;
      print('list: $listKota');
      return KotaModel.fromJsonList(listKota);
    } catch (e) {
      print(e);
    }
    return [];
  }
}
