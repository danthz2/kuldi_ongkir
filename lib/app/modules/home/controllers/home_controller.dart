import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:ongkir/app/data/models/courier_model.dart';

class HomeController extends GetxController {
  var hiddenKoteAsal = true.obs;
  var provAsalId = 0.obs;
  var kotaAsalId = 0.obs;
  var hiddenKoteTujuan = true.obs;
  var provTujuanId = 0.obs;
  var kotaTujuanId = 0.obs;
  var hiddenButton = true.obs;
  var kurir = ''.obs;

  double berat = 0.0;
  String satuan = 'gram';

  late TextEditingController beratC;

  void ongkosKirim() async {
    var url = Uri.parse('https://api.rajaongkir.com/starter/cost');
    try {
      final response = await http.post(
        url,
        headers: {
          'key': '11b896ce4c6ead12e44a01bc1f4926bd',
          'content-type': 'application/x-www-form-urlencoded',
        },
        body: {
          'origin': '$kotaAsalId',
          'destination': '$kotaTujuanId',
          'weight': '$berat',
          'courier': '${kurir.toLowerCase()}',
        },
      );
      var data = jsonDecode(response.body) as Map<String, dynamic>;
      var result = data['rajaongkir']['results'] as List<dynamic>;
      var listAllCourier = Courier.fromJsonList(result);
      var courier = listAllCourier[0];
      Get.defaultDialog(
          title: courier.name,
          content: Column(
            children: courier.costs
                .map((e) => ListTile(
                      isThreeLine: true,
                      leading: Text(e.cost[0].etd + ' hari'),
                      title: Text(e.description),
                      subtitle: Text(e.service),
                      trailing: Text('Rp ${e.cost[0].value}'),
                    ))
                .toList(),
          ));
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: 'Terjadi Kesalahan',
        middleText: e.toString(),
      );
    }
  }

  void showButton() {
    if (kotaAsalId != 0 && kotaTujuanId != 0 && berat > 0 && kurir != '') {
      hiddenButton.value = false;
    } else {
      hiddenButton.value = true;
    }
  }

  void ubahBerat(String value) {
    berat = double.tryParse(value) ?? 0.0;
    String cekSatuan = satuan;
    switch (cekSatuan) {
      case 'gram':
        berat = berat;
        break;
      case 'kg':
        berat = berat * 1000;
        break;
      default:
        berat = berat;
    }
    showButton();
    print(berat);
  }

  void ubahSatuan(String value) {
    berat = double.tryParse(beratC.text) ?? 0.0;
    switch (value) {
      case 'gram':
        berat = berat;
        break;
      case 'kg':
        berat = berat * 1000;
        break;
      default:
        berat = berat;
    }
    satuan = value;
    showButton();
    print(berat);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    beratC = TextEditingController(text: '$berat');
  }

  @override
  void dispose() {
    beratC.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
