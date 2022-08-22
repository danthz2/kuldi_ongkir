import 'package:http/http.dart' as http;

void main() async {
  var url = Uri.parse('https://api.rajaongkir.com/starter/province');
  final response = await http.get(url);

  print('respon ' + response.body);
}
