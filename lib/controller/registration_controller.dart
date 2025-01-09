import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:stacked/stacked.dart';
import 'package:zybo_tech_interviewtask/api/apis.dart';
import 'package:zybo_tech_interviewtask/model/usermodel.dart';

class RegistrationController extends BaseViewModel {
  Future<Usermodel?> createUser({required String phonenum}) async {
    Map registrationMap = {"phone_number": phonenum};

    try {
      var response = await http.post(Apis.registration, body: registrationMap);
      if (response.statusCode == 200) {
        // log(response.body);
        var data = jsonDecode(response.body);
        log("${data["otp"]}");
        return Usermodel(otp: data["otp"]);
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<Usermodel?> loginUser({required String username}) async {
    Map<String, String> registrationMap = {
      "first_name": username,
      "phone_number": "7217212218"
    };

    try {
      var response = await http.post(
        Apis.loginwithname,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(registrationMap),
      );

      if (response.statusCode == 200) {
        log("Response: ${response.body}");
        var data = jsonDecode(response.body);

        if (data.containsKey("token") && data["token"].containsKey("access")) {
          String token = data["token"]["access"];
          String userId = data["user_id"];
          String message = data["message"];
          final pref=await SharedPreferences.getInstance();

          

          log("Token: $token");
          log("User ID: $userId");

          return Usermodel(token: token, message: message);
        } else {
          log("Invalid response format: ${response.body}");
          return null;
        }
      } else {
        log("Failed with status code: ${response.statusCode}");
        log("Response: ${response.body}");
        return null;
      }
    } catch (e) {
      log("Error: ${e.toString()}");
      return null;
    }
  }

  Usermodel? userModel;

  Future<void> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    // log('Token: $token');

    try {
      var response = await http.get(Apis.userData, headers: {
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        log("User Data: ${data["name"]}, ${data["phone_number"]}");

        userModel = Usermodel(
          name: data['name'],
          phonenumber: data['phone_number'],
        );

        notifyListeners();
      } else {
        log("Failed to fetch user data: ${response.statusCode}");
      }
    } catch (e) {
      log("Error fetching user data: ${e.toString()}");
    }
  }
}
