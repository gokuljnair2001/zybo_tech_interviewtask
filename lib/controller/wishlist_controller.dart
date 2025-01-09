import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zybo_tech_interviewtask/api/apis.dart';

class WishlistController extends ChangeNotifier {
  bool isInWishlist = false;

  Future<void> toggleWishlist({
    required String productId,
    required BuildContext context,
  }) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      if (token == null) {
        throw Exception('Token not found in shared preferences');
      }

      print('Token: $token');
      print('API URL: ${Apis.wishList}');

      final response = await http.post(
        Apis.wishList,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'product_id': productId}),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('Response Data: $responseData');

        if (responseData['message'] == 'Product added to favorites') {
          isInWishlist = true;
          notifyListeners();
        } else if (responseData['message'] ==
            'Product removed from favorites') {
          isInWishlist = false;
          notifyListeners();
        }

        notifyListeners();
      } else {
        throw Exception(
          'Failed to update wishlist. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      log('Error: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  Future<void> getWishList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    var response = await http.get(
      Apis.getwishList,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      log(response.body);
    } else {
      log(response.statusCode.toString());
    }
  }
}
