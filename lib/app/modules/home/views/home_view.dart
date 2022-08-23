import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ongkir/app/data/models/provinsi_model.dart';
import 'package:http/http.dart' as http;
import 'package:ongkir/app/modules/home/views/widgets/berat_barang.dart';
import 'package:ongkir/app/modules/home/views/widgets/kota_field.dart';
import 'package:ongkir/app/modules/home/views/widgets/kurir.dart';
import 'package:ongkir/app/modules/home/views/widgets/provinsi_field.dart';
import 'package:ongkir/app/modules/home/views/widgets/satuan_field.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ongkos Kirim Indonesia'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        children: [
          ProvinsiField(type: 0),
          Obx(() => controller.idProvAsal.value != 0 ? KotaField(type: 0) : SizedBox()),
          ProvinsiField(type: 1),
          Obx(() => controller.idProvTujuan.value != 0 ? KotaField(type: 1) : SizedBox()),
          Row(
            children: [
              Expanded(flex: 4, child: BeratBarang()),
              SizedBox(
                width: 10,
              ),
              Expanded(flex: 3, child: SatuanField()),
            ],
          ),
          Kurir(),
          ElevatedButton(
            onPressed: () {
              controller.cekOngkir();
            },
            child: Text('CEK ONGKOS KIRIM'),
            style: ElevatedButton.styleFrom(),
          )
        ],
      ),
    );
  }
}
