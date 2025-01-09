import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:stacked/stacked.dart';
import 'package:zybo_tech_interviewtask/api/apis.dart';
import 'package:zybo_tech_interviewtask/model/wishlist_model.dart';

class WishlistDataController extends BaseViewModel {
  List<Wishlist> wishlistdata = [];

  Future<void> getProductList() async {
    try {
      var response = await http.get(Apis.getwishListData);
      if (response.statusCode == 200) {
        log("Data fetched successfully: ${response.body}");
        wishlistdata = wishlistFromJson(response.body);
        notifyListeners();
      }
    } catch (e) {
      log("$e");
    }
  }
}
