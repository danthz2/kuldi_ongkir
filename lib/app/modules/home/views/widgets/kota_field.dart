import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ongkir/app/data/models/kota_model.dart';
import 'package:ongkir/app/modules/home/controllers/home_controller.dart';

class KotaField extends GetView<HomeController> {
  KotaField({Key? key, required this.type}) : super(key: key);
  int type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: DropdownSearch<KotaModel>(
        clearButtonProps: ClearButtonProps(isVisible: true),
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            hintText: type == 0 ? 'Kota Asal' : 'Kota Tujuan',
            labelText: type == 0 ? 'Kota Asal' : 'Kota Tujuan',
            border: OutlineInputBorder(),
          ),
        ),
        popupProps: PopupProps.menu(
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              hintText: 'Cari Kota...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
          itemBuilder: (context, item, isSelected) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                '${item.type} ${item.cityName}',
                style: TextStyle(fontSize: 18),
              ),
            );
          },
        ),
        itemAsString: (item) => item.cityName ?? '',
        asyncItems: (text) =>
            controller.getKota(type == 0 ? controller.idProvAsal.value : controller.idProvTujuan.value),
        onChanged: (value) {
          if (value != null) {
            if (type == 0) {
              controller.idKotaAsal.value = int.parse(value.cityId!);
              print(controller.idKotaAsal.value);
            } else {
              controller.idKotaTujuan.value = int.parse(value.cityId!);
              print(controller.idKotaTujuan.value);
            }
          } else {
            if (type == 0) {
              controller.idKotaAsal.value = 0;
              print(controller.idKotaAsal.value);
            } else {
              controller.idKotaTujuan.value = 0;
              print(controller.idKotaTujuan.value);
            }
          }
        },
      ),
    );
  }
}
