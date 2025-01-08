import 'dart:convert';

List<ProductsModel> productsModelFromJson(String str) =>
    List<ProductsModel>.from(json.decode(str).map((x) => ProductsModel.fromJson(x)));

String productsModelToJson(List<ProductsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductsModel {
  int? id;
  List<dynamic>? variations;
  bool? inWishlist;
  int? avgRating;
  List<String>? images;
  bool? variationExists;
  int? salePrice;
  List<Addon>? addons;

  ProductsModel({
    this.id,
    this.variations,
    this.inWishlist,
    this.avgRating,
    this.images,
    this.variationExists,
    this.salePrice,
    this.addons,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        id: json["id"],
        variations: List<dynamic>.from(json["variations"] ?? []),
        inWishlist: json["in_wishlist"],
        avgRating: json["avg_rating"],
        images: List<String>.from(json["images"] ?? []),
        variationExists: json["variation_exists"],
        salePrice: json["sale_price"],
        addons: List<Addon>.from((json["addons"] ?? []).map((x) => Addon.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "variations": List<dynamic>.from(variations ?? []),
        "in_wishlist": inWishlist,
        "avg_rating": avgRating,
        "images": List<dynamic>.from(images ?? []),
        "variation_exists": variationExists,
        "sale_price": salePrice,
        "addons": List<dynamic>.from(addons?.map((x) => x.toJson()) ?? []),
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
