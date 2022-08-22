import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../home/controllers/home_controller.dart';
import '../../../../data/models/province_model.dart';

class FieldProvinsi extends GetView<HomeController> {
  const FieldProvinsi({Key? key, required this.tipe}) : super(key: key);

  final String tipe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: DropdownSearch<Province>(
        // dropdownSearchDecoration: InputDecoration(labelText: "Name"),
        clearButtonProps: ClearButtonProps(isVisible: true),
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            label: Text((tipe == 'asal') ? 'Provinsi Asal' : 'Provinsi Tujuan'),
            border: OutlineInputBorder(),
          ),
        ),
        popupProps: PopupProps.dialog(
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
              decoration:
                  InputDecoration(hintText: 'Cari Provinsi...', border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)))),
          itemBuilder: (context, item, isSelected) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                item.province!,
                style: TextStyle(fontSize: 18),
              ),
            );
          },
        ),

        itemAsString: (item) => item.province!,
        asyncItems: (String filter) async {
          var url = Uri.parse('https://api.rajaongkir.com/starter/province');
          try {
            final response = await http.get(
              url,
              headers: {'key': '11b896ce4c6ead12e44a01bc1f4926bd'},
            );
            var data = jsonDecode(response.body) as Map<String, dynamic>;
            var statusCode = data['rajaongkir']['status']['code'];
            if (statusCode != 200) {
              throw data['rajaongkir']['status']['description'];
            }

            var allProvince = data['rajaongkir']['results'] as List<dynamic>;
            var models = Province.fromJsonList(allProvince);

            return models;
          } catch (e) {
            print(e);
            return List<Province>.empty();
          }
        },
        onChanged: (value) {
          if (value != null) {
            if (tipe == 'asal') {
              controller.hiddenKoteAsal.value = false;
              controller.provAsalId.value = int.parse(value.provinceId!);
            } else {
              controller.hiddenKoteTujuan.value = false;
              controller.provTujuanId.value = int.parse(value.provinceId!);
            }
          } else {
            if (tipe == 'asal') {
              controller.hiddenKoteAsal.value = true;
              controller.provAsalId.value = 0;
            } else {
              controller.hiddenKoteTujuan.value = true;
              controller.provTujuanId.value = 0;
            }
          }
          controller.showButton();
        },
      ),
    );
  }
}
