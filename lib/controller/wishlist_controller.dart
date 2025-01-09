import 'package:http/http.dart' as http;
import 'package:stacked/stacked.dart';

class WishlistController extends BaseViewModel{
  bool isInwhishList=false;
  void checkisInwishlist(){
    isInwhishList=true;
    notifyListeners();



   

  }
}