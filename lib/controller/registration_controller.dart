import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:zybo_tech_interviewtask/api/apis.dart';
import 'package:zybo_tech_interviewtask/model/otpModel.dart';
import 'package:zybo_tech_interviewtask/model/usermodel.dart';
import 'package:zybo_tech_interviewtask/utils/constants/string_constants.dart';
import 'package:zybo_tech_interviewtask/view/otp_screen/otp_screen.dart';

class RegistrationController extends BaseViewModel {
  RegistrationModel? registrationModel;
  Future<void> registerUser(
      {required String name,
      required String number,
      required BuildContext context}) async {
    Map<String, dynamic> userData = {
      "first_name": name,
      "phone_number": number
    };

    try {
      var response = await http.post(
        Apis.loginwithname,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(userData),
      );
      if (response.statusCode == 200) {
        registrationModel = registrationModelFromJson(response.body);
        notifyListeners();
        final preff = await SharedPreferences.getInstance();
        preff.setString(
            StringConstants.token, registrationModel!.token.toString());

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpScreen(
                otp: otpModel!.otp.toString(),
              ),
            ));
      }
    } catch (e) {
      log(e.toString());
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  OtpModel? otpModel;
  Future<void> getOtp(
      {required String phone_number, required BuildContext context}) async {
    try {
      Map<String, dynamic> numData = {"phone_number": phone_number};
      var response = await http.post(
        Apis.registration,
        body: jsonEncode(numData),
        headers: {
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        otpModel = otpModelFromJson(response.body);
        notifyListeners();
        log(otpModel!.otp.toString());
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
