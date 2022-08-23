import 'dart:convert';

import 'package:get/get.dart';

import '../models/kurir_model.dart';

import 'package:http/http.dart' as http;

class KurirProvider {
  Future<List<KurirModel>> postOngkir(String idKotaAsal, String idKotaTujuan, String berat, String kurir) async {
    var url = Uri.parse('https://api.rajaongkir.com/starter/cost');
    try {
      var response = await http.post(url, headers: {
        'key': '11b896ce4c6ead12e44a01bc1f4926bd',
        'content-type': 'application/x-www-form-urlencoded',
      }, body: {
        // ID kota atau kabupaten asal
        'origin': idKotaAsal,
        // ID kota atau kabupaten tujuan
        'destination': idKotaTujuan,
        // Berat kiriman dalam gram
        'weight': berat,
        // kurir 'jne' , 'post', 'tiki'
        'courier': kurir,
      });
      var data = jsonDecode(response.body) as Map<String, dynamic>;
      var ongkir = data['rajaongkir']['results'];
      return KurirModel.fromJsonList(ongkir);
    } catch (e) {
      Get.defaultDialog(
        title: 'Terjadi Kesalahan',
        middleText: e.toString(),
      );
    }
    return [];
  }
}
