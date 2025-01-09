// To parse this JSON data, do
//
//     final searchProductList = searchProductListFromJson(jsonString);

import 'dart:convert';

List<SearchProductList> searchProductListFromJson(String str) => List<SearchProductList>.from(json.decode(str).map((x) => SearchProductList.fromJson(x)));

String searchProductListToJson(List<SearchProductList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchProductList {
    int? id;
    String? name;
    int? price;
    bool? isActive;

    SearchProductList({
        this.id,
        this.name,
        this.price,
        this.isActive,
    });

    factory SearchProductList.fromJson(Map<String, dynamic> json) => SearchProductList(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        isActive: json["is_active"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "is_active": isActive,
    };
}
