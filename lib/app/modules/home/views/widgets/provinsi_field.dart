import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ongkir/app/data/models/provinsi_model.dart';
import 'package:ongkir/app/modules/home/controllers/home_controller.dart';

class ProvinsiField extends GetView<HomeController> {
  ProvinsiField({Key? key, required this.type}) : super(key: key);
  int type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: DropdownSearch<ProvinsiModel>(
        clearButtonProps: ClearButtonProps(isVisible: true),
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            hintText: type == 0 ? 'Provinsi Asal' : 'Provinsi Tujuan',
            labelText: type == 0 ? 'Provinsi Asal' : 'Provinsi Tujuan',
            border: OutlineInputBorder(),
          ),
        ),
        popupProps: PopupProps.dialog(
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              hintText: 'Cari Kota...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ),
        asyncItems: (text) => controller.getProvinsi(),
        itemAsString: (item) => item.province ?? '',
        onChanged: (value) {
          if (value != null) {
            if (type == 0) {
              controller.idProvAsal.value = int.parse(value.provinceId!);
              print(controller.idProvAsal.value);
            } else {
              controller.idProvTujuan.value = int.parse(value.provinceId!);
              print(controller.idProvTujuan.value);
            }
          } else {
            if (type == 0) {
              controller.idProvAsal.value = 0;
              print(controller.idProvAsal.value);
            } else {
              controller.idProvTujuan.value = 0;
              print(controller.idProvTujuan.value);
            }
          }
        },
      ),
    );
  }
}
