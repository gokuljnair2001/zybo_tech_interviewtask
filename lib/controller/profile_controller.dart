import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:zybo_tech_interviewtask/api/apis.dart';
import 'package:zybo_tech_interviewtask/model/user_name_model.dart';
import 'package:zybo_tech_interviewtask/utils/constants/string_constants.dart';

class ProfileController extends BaseViewModel {
  ProfileResponse? profileResponse;

  Future<void> getData({required BuildContext context}) async {
    final preff = await SharedPreferences.getInstance();
    String? token = preff.getString(StringConstants.token);

    if (token == null || token.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Token not found. Please log in again.')),
      );
      return;
    }

    try {
      var response = await http.post(
        Apis.profileurl,
        headers: {
          "Authorization": "Bearer $token", // Correct formatting
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        // Parse the response body and assign it to the model
        profileResponse = profileResponseFromJson(response.body);
        notifyListeners();
      } else {
        log('Error: ${response.statusCode} - ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to fetch data: ${response.body}')),
        );
      }
    } catch (e) {
      log('Exception: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }
}
