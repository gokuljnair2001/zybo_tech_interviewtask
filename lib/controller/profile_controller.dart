import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:stacked/stacked.dart';
import 'package:zybo_tech_interviewtask/api/apis.dart';
import 'package:zybo_tech_interviewtask/model/user_name_model.dart';
import 'package:zybo_tech_interviewtask/utils/constants/string_constants.dart';

class ProfileController extends BaseViewModel {
  ProfileResponse? profileResponse;
  bool noData = false;
  Future<void> getData({required BuildContext context}) async {
    final secureStorage = FlutterSecureStorage();
    String? token =
        await secureStorage.read(key: StringConstants.token).toString();

    if (token == null || token.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Token not found. Please log in again.')));
      return;
    }

    try {
      var response = await http.post(
        Apis.profileurl,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        profileResponse = profileResponseFromJson(response.body);
        notifyListeners();
      } else {
        log('Error: ${response.statusCode} - ${response.body}');
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('Failed to fetch data: ${response.body}')),
        // );
      }

      if (response.statusCode == 401 || response.statusCode >= 500) {
        noData = true;
        notifyListeners();
      }
    } catch (e) {
      log('Exception: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }
}
