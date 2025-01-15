// To parse this JSON data, do
//
//     final registrationModel = registrationModelFromJson(jsonString);

import 'dart:convert';

RegistrationModel registrationModelFromJson(String str) => RegistrationModel.fromJson(json.decode(str));

String registrationModelToJson(RegistrationModel data) => json.encode(data.toJson());

class RegistrationModel {
    Token? token;
    String? userId;
    String? message;

    RegistrationModel({
        this.token,
        this.userId,
        this.message,
    });

    factory RegistrationModel.fromJson(Map<String, dynamic> json) => RegistrationModel(
        token: json["token"] == null ? null : Token.fromJson(json["token"]),
        userId: json["user_id"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "token": token?.toJson(),
        "user_id": userId,
        "message": message,
    };
}

class Token {
    String? access;

    Token({
        this.access,
    });

    factory Token.fromJson(Map<String, dynamic> json) => Token(
        access: json["access"],
    );

    Map<String, dynamic> toJson() => {
        "access": access,
    };
}
