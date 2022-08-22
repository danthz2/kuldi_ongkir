import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ongkir/app/modules/home/controllers/home_controller.dart';

class BeratBarang extends GetView<HomeController> {
  const BeratBarang({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              autocorrect: false,
              controller: controller.beratC,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Berat Barang',
                hintText: 'Berat Barang',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => controller.ubahBerat(value),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            width: 150,
            child: DropdownSearch<String>(
              items: ['kg', 'gran'],
              popupProps: PopupProps.menu(
                constraints: BoxConstraints(maxHeight: 200),
                showSearchBox: true,
                searchFieldProps: TextFieldProps(
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                    hintText: 'Berat dalam...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  label: Text('Satuan Berat'),
                  border: OutlineInputBorder(),
                ),
              ),
              selectedItem: 'gram',
              onChanged: (value) => controller.ubahSatuan(value!),
            ),
          )
        ],
      ),
    );
  }
}
