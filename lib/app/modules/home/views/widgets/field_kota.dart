import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ongkir/app/modules/home/controllers/home_controller.dart';

import '../../../../data/models/city_model.dart';

class FieldKota extends GetView<HomeController> {
  const FieldKota({
    Key? key,
    required this.provId,
    required this.tipe,
  }) : super(key: key);
  final int provId;
  final String tipe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: DropdownSearch<City>(
        // dropdownSearchDecoration: InputDecoration(labelText: "Name"),
        clearButtonProps: ClearButtonProps(isVisible: true),
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            label: Text((tipe == 'asal') ? 'Kota Asal' : 'Kota Tujuan'),
            border: OutlineInputBorder(),
          ),
        ),
        popupProps: PopupProps.menu(
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
              decoration: InputDecoration(hintText: 'Cari Kota...', border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)))),
          itemBuilder: (context, item, isSelected) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                '${item.type} ${item.cityName!}',
                style: TextStyle(fontSize: 18),
              ),
            );
          },
        ),
        itemAsString: (item) => '${item.type} ${item.cityName!}',
        asyncItems: (String filter) async {
          var url = Uri.parse('https://api.rajaongkir.com/starter/city?province=$provId');
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
            var models = City.fromJsonList(allProvince);

            return models;
          } catch (e) {
            print(e);
            return List<City>.empty();
          }
        },
        onChanged: (value) {
          if (value != null) {
            if (tipe == 'asal') {
              controller.kotaAsalId.value = int.parse(value.cityId!);
            } else {
              controller.kotaTujuanId.value = int.parse(value.cityId!);
            }
          } else {
            if (tipe == 'asal') {
              controller.kotaAsalId.value = 0;
            } else {
              controller.kotaTujuanId.value = 0;
            }
          }
          controller.showButton();
        },
      ),
    );
  }
}
