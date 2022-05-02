import 'dart:convert';

import 'package:api_call_with_rx_test_2/model/api_model.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  Future<CustomApiProvider<ApiModel>> apiProvider() async {
    final response = await http.get(
      Uri.parse(
        "https://api.themoviedb.org/3/movie/popular?api_key=2a61185ef6a27f400fd92820ad9e8537&page=2",
      ),
    );

    if (response.statusCode == 200) {
      return CustomApiProvider<ApiModel>(
        data: ApiModel.fromJson(json.decode(response.body)),
      );
    } else {
      return CustomApiProvider(statusCode: 400);
    }
  }
}
