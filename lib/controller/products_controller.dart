import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:stacked/stacked.dart';
import 'package:zybo_tech_interviewtask/api/apis.dart';
import 'package:zybo_tech_interviewtask/model/banner_products_model.dart';
import 'package:zybo_tech_interviewtask/model/products_model.dart';

class ProductsController extends BaseViewModel {
  List<ProductsModel> products = [];
  List<BannerProductsModel> bannerProducts = [];

  Future<void> getProductList() async {
    try {
      var response = await http.get(Apis.productsData);
      if (response.statusCode == 200) {
        products = productsModelFromJson(response.body);
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> onBannerProducts() async {
    try {
      var response = await http.get(Apis.bannerProducts);
      if (response.statusCode == 200) {
        bannerProducts = bannerProductsModelFromJson(response.body);
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
