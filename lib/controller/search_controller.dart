import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stacked/stacked.dart';
import 'package:zybo_tech_interviewtask/api/apis.dart';
import 'package:zybo_tech_interviewtask/model/search_model.dart';
import 'package:zybo_tech_interviewtask/utils/functions/snakcbar.dart';

class ProductSearchController extends BaseViewModel {
  bool isloading = false;
  bool noResult=false;
  List<SearchResults> searchResults = [];
  Future<void> getSearchResults(
      {required String keyword, required BuildContext context}) async {
    Map<String, dynamic> data = {"query": keyword};
    try {
      isloading = true;
      notifyListeners();
      var response =
          await http.post(Apis.searchUrl, body: jsonEncode(data), headers: {
        "Content-Type": "application/json",
      });

      if (response.statusCode == 200) {
        searchResults = searchResultsFromJson(response.body);
        notifyListeners();
      }
      if (response.body.contains("No products found.")) {
        noResult=true;
        notifyListeners();
      }



      isloading = false;
      notifyListeners();
    } catch (e) {
      log(e.toString());
      isloading = false;
errorSnackbar(error: e.toString(), context: context);
    }
  }
}
