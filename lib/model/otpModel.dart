// To parse this JSON data, do
//
//     final otpModel = otpModelFromJson(jsonString);

import 'dart:convert';

OtpModel otpModelFromJson(String str) => OtpModel.fromJson(json.decode(str));

String otpModelToJson(OtpModel data) => json.encode(data.toJson());

class OtpModel {
    String? otp;
    bool? user;

    OtpModel({
        this.otp,
        this.user,
    });

    factory OtpModel.fromJson(Map<String, dynamic> json) => OtpModel(
        otp: json["otp"],
        user: json["user"],
    );

    Map<String, dynamic> toJson() => {
        "otp": otp,
        "user": user,
    };
}
