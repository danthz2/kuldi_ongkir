import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/provinsi_model.dart';

class ProvinsiProvider {
  var url = 'https://api.rajaongkir.com/starter/province';
  Future<List<ProvinsiModel>> getProvinsiModel() async {
    var url = Uri.parse('https://api.rajaongkir.com/starter/province');
    try {
      var response = await http.get(url, headers: {'key': '11b896ce4c6ead12e44a01bc1f4926bd'});
      var data = jsonDecode(response.body) as Map<String, dynamic>;
      // print('data: $data');
      var listProvinsi = data['rajaongkir']['results'] as List<dynamic>;
      print('list: $listProvinsi');
      return ProvinsiModel.fromJsonList(listProvinsi);
    } catch (e) {
      print(e);
    }
    return [];
  }
}
