// To parse this JSON data, do
//
//     final addToWishlist = addToWishlistFromJson(jsonString);

import 'dart:convert';

AddToWishlist addToWishlistFromJson(String str) => AddToWishlist.fromJson(json.decode(str));

String addToWishlistToJson(AddToWishlist data) => json.encode(data.toJson());

class AddToWishlist {
    String? productId;

    AddToWishlist({
        this.productId,
    });

    factory AddToWishlist.fromJson(Map<String, dynamic> json) => AddToWishlist(
        productId: json["product_id"],
    );

    Map<String, dynamic> toJson() => {
        "product_id": productId,
    };
}
