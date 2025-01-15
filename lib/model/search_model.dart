

import 'dart:convert';

List<SearchResults> searchResultsFromJson(String str) => List<SearchResults>.from(json.decode(str).map((x) => SearchResults.fromJson(x)));

String searchResultsToJson(List<SearchResults> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchResults {
    int? id;
    List<dynamic>? variations;
    bool? inWishlist;
    int? avgRating;
    List<String>? images;
    bool? variationExists;
    int? salePrice;
    List<Addon>? addons;

    SearchResults({
        this.id,
        this.variations,
        this.inWishlist,
        this.avgRating,
        this.images,
        this.variationExists,
        this.salePrice,
        this.addons,
    });

    factory SearchResults.fromJson(Map<String, dynamic> json) => SearchResults(
        id: json["id"],
        variations: json["variations"] == null ? [] : List<dynamic>.from(json["variations"]!.map((x) => x)),
        inWishlist: json["in_wishlist"],
        avgRating: json["avg_rating"],
        images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
        variationExists: json["variation_exists"],
        salePrice: json["sale_price"],
        addons: json["addons"] == null ? [] : List<Addon>.from(json["addons"]!.map((x) => Addon.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "variations": variations == null ? [] : List<dynamic>.from(variations!.map((x) => x)),
        "in_wishlist": inWishlist,
        "avg_rating": avgRating,
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "variation_exists": variationExists,
        "sale_price": salePrice,
        "addons": addons == null ? [] : List<dynamic>.from(addons!.map((x) => x.toJson())),
    };
}

class Addon {
    int? id;
    int? price;
    String? name;
    String? description;
    String? featuredImage;
    int? stock;
    bool? isActive;
    int? taxRate;

    Addon({
        this.id,
        this.price,
        this.name,
        this.description,
        this.featuredImage,
        this.stock,
        this.isActive,
        this.taxRate,
    });

    factory Addon.fromJson(Map<String, dynamic> json) => Addon(
        id: json["id"],
        price: json["price"],
        name: json["name"],
        description: json["description"],
        featuredImage: json["featured_image"],
        stock: json["stock"],
        isActive: json["is_active"],
        taxRate: json["tax_rate"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "name": name,
        "description": description,
        "featured_image": featuredImage,
        "stock": stock,
        "is_active": isActive,
        "tax_rate": taxRate,
    };
}
