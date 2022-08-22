import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ongkir/app/modules/home/views/widgets/berat_barang.dart';

import '../../home/views/widgets/field_kota.dart';
import '../../home/views/widgets/field_provinsi.dart';
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
        padding: EdgeInsets.all(20),
        children: [
          FieldProvinsi(tipe: 'asal'),
          Obx(() => controller.hiddenKoteAsal.value
              ? SizedBox()
              : FieldKota(
                  tipe: 'asal',
                  provId: controller.provAsalId.value,
                )),
          FieldProvinsi(tipe: 'tujuan'),
          Obx(
            () => controller.hiddenKoteTujuan.value
                ? SizedBox()
                : FieldKota(
                    tipe: 'tujuan',
                    provId: controller.provTujuanId.value,
                  ),
          ),
          BeratBarang(),
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: DropdownSearch<String>(
              clearButtonProps: ClearButtonProps(isVisible: true),
              items: ['JNE', 'TIKI', 'POS'],
              popupProps: PopupProps.menu(
                constraints: BoxConstraints(maxHeight: 200),
                showSearchBox: true,
                searchFieldProps: TextFieldProps(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                    hintText: 'Pilih ekspedisi...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  label: Text('Metode Pengiriman'),
                  border: OutlineInputBorder(),
                ),
              ),
              onChanged: (value) {
                if (value != null) {
                  controller.kurir.value = value;
                  controller.showButton();
                } else {
                  controller.hiddenButton.value = true;
                  controller.kurir.value = '';
                }
              },
            ),
          ),
          Obx(() => controller.hiddenButton.value
              ? SizedBox()
              : ElevatedButton(
                  onPressed: () {
                    controller.ongkosKirim();
                  },
                  child: Text('CEK ONGKOS KIRIM'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 20),
                  ),
                ))
        ],
      ),
    );
  }
}
