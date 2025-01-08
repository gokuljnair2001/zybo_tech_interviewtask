import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:stacked/stacked.dart';
import 'package:zybo_tech_interviewtask/api/apis.dart';

class RegistrationController extends BaseViewModel {
  Future<void> createUser({required String phonenum}) async {
    Map registrationMap = {"first_name": 'qwerty', "phone_number": phonenum};
    try {
      var response = await http.post(Apis.registration, body: registrationMap);
      if (response.statusCode == 200) {
        log(response.body);
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
