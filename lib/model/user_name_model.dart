// To parse this JSON data, do
//
//     final profileResponse = profileResponseFromJson(jsonString);

import 'dart:convert';

ProfileResponse profileResponseFromJson(String str) => ProfileResponse.fromJson(json.decode(str));

String profileResponseToJson(ProfileResponse data) => json.encode(data.toJson());

class ProfileResponse {
    String? name;
    String? phoneNumber;

    ProfileResponse({
        this.name,
        this.phoneNumber,
    });

    factory ProfileResponse.fromJson(Map<String, dynamic> json) => ProfileResponse(
        name: json["name"],
        phoneNumber: json["phone_number"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "phone_number": phoneNumber,
    };
}
