// To parse this JSON data, do
//
//     final productsBannertModel = productsBannertModelFromJson(jsonString);

import 'dart:convert';

List<ProductsBannertModel> productsBannertModelFromJson(String str) => List<ProductsBannertModel>.from(json.decode(str).map((x) => ProductsBannertModel.fromJson(x)));


class ProductsBannertModel {
    int? id;
    String? imageUrl;

    ProductsBannertModel({
        this.id,
        this.imageUrl,
    });

    factory ProductsBannertModel.fromJson(Map<String, dynamic> json) => ProductsBannertModel(
        id: json["id"],
        imageUrl: json["image_url"],
    );


}
