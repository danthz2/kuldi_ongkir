class ProvinsiModel {
  String? provinceId;
  String? province;

  ProvinsiModel({this.provinceId, this.province});

  ProvinsiModel.fromJson(Map<String, dynamic> json) {
    provinceId = json['province_id'];
    province = json['province'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['province_id'] = provinceId;
    data['province'] = province;
    return data;
  }

  static List<ProvinsiModel> fromJsonList(List list) {
    if (list.isEmpty) return List<ProvinsiModel>.empty();
    return list.map((item) => ProvinsiModel.fromJson(item)).toList();
  }
}
