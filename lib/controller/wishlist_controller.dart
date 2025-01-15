import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:zybo_tech_interviewtask/api/apis.dart';
import 'package:zybo_tech_interviewtask/utils/constants/string_constants.dart';
import 'package:zybo_tech_interviewtask/utils/functions/snakcbar.dart';

class WishlistController extends ChangeNotifier {
  Future<void> addToWishlist(
      {required BuildContext context, required String id}) async {
    final secureStorage = FlutterSecureStorage();
    String? token = await secureStorage.read(key: StringConstants.token);

    try {
      Map<String, dynamic> data = {"product_id": id};
      var response = await http.post(
        Apis.wishList,
        body: jsonEncode(data),
        headers: {
          "Authorization": "Bearer $token", // Correct formatting
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        log('succes');
      } else {
        log('failed..status code ${response.statusCode}');
      }
    } catch (e) {
      errorSnackbar(error: e.toString(), context: context);
    }
  }

  void getWishlist() {}

  void toggleWishList() {}
}
