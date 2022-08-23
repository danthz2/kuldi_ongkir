import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ongkir/app/data/models/kota_model.dart';
import 'package:ongkir/app/data/models/provinsi_model.dart';
import 'package:ongkir/app/data/providers/kota_provider.dart';
import 'package:ongkir/app/data/providers/kurir_provider.dart';
import 'package:ongkir/app/data/providers/provinsi_provider.dart';

class HomeController extends GetxController {
  var idProvAsal = 0.obs;
  var idProvTujuan = 0.obs;
  var idKotaAsal = 0.obs;
  var idKotaTujuan = 0.obs;
  var satuan = ''.obs;
  var kurir = ''.obs;
  double berat = 0.0;

  late TextEditingController beratC;

  Future<List<ProvinsiModel>> getProvinsi() async {
    var data = await ProvinsiProvider().getProvinsiModel();
    return data;
  }

  Future<List<KotaModel>> getKota(int idProv) async {
    var data = await KotaProvider().getKotaModel(idProv);
    return data;
  }

  void cekOngkir() async {
    switch (satuan.value) {
      case 'g':
        berat = double.parse(beratC.text);
        break;
      case 'kg':
        berat = double.parse(beratC.text) * 1000;
        break;
      case 'ons':
        berat = double.parse(beratC.text) * 28.3495;
        break;
      default:
    }
    var data = await KurirProvider().postOngkir(
      idKotaAsal.value.toString(),
      idKotaTujuan.value.toString(),
      berat.toString(),
      kurir.value,
    );

    Get.defaultDialog(
      title: 'Ongkir adalah',
      content: Column(
        children: data[0]
            .costs!
            .map((e) => Row(
                  children: [
                    Text(e.service.toString()),
                    Text(e.cost![0].value.toString()),
                  ],
                ))
            .toList(),
      ),
    );
  }

  @override
  void onInit() {
    super.onInit();
    beratC = TextEditingController();
  }

  @override
  void onClose() {
    beratC.dispose();
    super.onClose();
  }
}
