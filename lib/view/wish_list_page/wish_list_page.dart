import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:zybo_tech_interviewtask/controller/wishlist_data_controller.dart';
import 'package:zybo_tech_interviewtask/utils/constants/asset_constants.dart';

class WishListPage extends StatelessWidget {
  const WishListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => WishlistDataController(),
        onModelReady: (viewModel) {
          viewModel.getProductList();
        },
        builder: (context, viewModel, child) => Scaffold(
            appBar: AppBar(
              title: Text(
                'WishList',
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.w600),
              ),
              backgroundColor: Colors.white,
              elevation: 0,
              foregroundColor: Colors.black,
            ),
            body: viewModel.wishlistdata.isEmpty
                ? Center(
                    child: Column(
                    children: [
                      Image(
                        image: AssetImage(AssetConstants.noData),
                      ),
                      Text(
                        'No Wishlist data found',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Text(
                        "Can't get wishlist data due API Issue",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      )
                    ],
                  ))
                : ListView.builder(
                    padding: EdgeInsets.all(12),
                    itemCount: viewModel.wishlistdata.length,
                    itemBuilder: (context, index) {
                      final wishlistItem = viewModel.wishlistdata[index];

                      return ListTile(
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            wishlistItem.images != null &&
                                    wishlistItem.images!.isNotEmpty
                                ? wishlistItem.images!.first
                                : 'https://via.placeholder.com/150',
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          wishlistItem.name ?? 'Product Name',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Row(
                          children: [
                            Text(
                              '${wishlistItem.salePrice ?? 0} Rs', // Price
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.star,
                              size: 16,
                              color: Colors.orange,
                            ),
                            SizedBox(width: 4),
                            Text(
                              '${wishlistItem.avgRating ?? 0}', // Rating
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            // Add logic to remove from wishlist
                            print('Removed from wishlist');
                          },
                          child: Icon(
                            Icons.favorite,
                            size: 24,
                            color: Colors.red,
                          ),
                        ),
                      );
                    },
                  )));
  }
}
