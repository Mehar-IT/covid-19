import 'package:covid_app/models/world_model.dart';
import 'dart:convert';
import 'package:covid_app/services/utils/app_urls.dart';
import 'package:http/http.dart';

class StateServices {
  static Future<WorldModel> fetchData() async {
    Response response = await get(Uri.parse(AppUrls.world));
    var decodedData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      var data = WorldModel.fromJson(decodedData);
      return data;
    } else {
      throw Exception('Data Not Found');
    }
  }
}
