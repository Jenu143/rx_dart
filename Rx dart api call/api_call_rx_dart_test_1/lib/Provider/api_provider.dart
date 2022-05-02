import 'dart:convert';
import 'package:api_call_rx_dart2/Model/data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  Future apiProvider() async {
    final response = await http.get(
      Uri.parse(
        "https://api.themoviedb.org/3/movie/popular?api_key=2a61185ef6a27f400fd92820ad9e8537&page=1",
      ),
    );

    if (response.statusCode == 200) {
      return DataModel.fromJson(jsonDecode(response.body));
    } else {
      throw const Text("Error : Fail to load data");
    }
  }
}
