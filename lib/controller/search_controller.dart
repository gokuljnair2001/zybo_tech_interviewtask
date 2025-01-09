import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stacked/stacked.dart';
import 'package:zybo_tech_interviewtask/api/apis.dart';
import 'package:zybo_tech_interviewtask/model/search_model.dart';

class ProductSearchController extends BaseViewModel {
  List<SearchProductList> searchList = [];
  bool noResult = false;

  Future<void> search({required String keyword, required BuildContext context}) async {
    try {
      var response = await http.post(
        Apis.searchUrl,
        body: jsonEncode({'query': keyword}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        if (decodedResponse is List) {
          searchList = searchProductListFromJson(response.body);
          noResult = searchList.isEmpty;
        } else if (decodedResponse['message'] == "No products found.") {
          noResult = true;
          searchList = [];
        }
      } else {
        noResult = true;
        searchList = [];
      }
      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }
}
