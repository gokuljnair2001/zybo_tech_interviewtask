
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:zybo_tech_interviewtask/controller/products_controller.dart';
import 'package:zybo_tech_interviewtask/controller/wishlist_controller.dart';
import 'package:zybo_tech_interviewtask/utils/constants/string_constants.dart';
import 'package:zybo_tech_interviewtask/view/login_page/login_page.dart';
import 'package:zybo_tech_interviewtask/view/products_page/produst_details.dart';
import 'package:zybo_tech_interviewtask/view/profile_page/profile_page.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final proRead = context.read<WishlistController>();
    return ViewModelBuilder.reactive(
      onViewModelReady: (viewModel) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          viewModel.getProductList();
          viewModel.onBannerProducts();
        });
      },
      viewModelBuilder: () => ProductsController(),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Popular Product'),
            backgroundColor: Colors.white,
            elevation: 0,
            foregroundColor: Colors.black,
            actions: [
              IconButton(
                onPressed: () async {
                  final secureStorage = FlutterSecureStorage();
                  await secureStorage.delete(key: StringConstants.token);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LogIn()),
                    (route) => false,
                  );
                },
                icon: Icon(Icons.logout),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(),
                        ));
                  },
                  icon: Icon(Icons.person))
            ],
          ),
          body: viewModel.products.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        viewModel.bannerProducts.isEmpty
                            ? Center(child: CircularProgressIndicator())
                            : CarouselSlider.builder(
                                itemCount: viewModel.bannerProducts.length,
                                itemBuilder: (context, index, realIndex) {
                                  final bannerProduct =
                                      viewModel.bannerProducts[index];
                                  return Container(
                                    height: 100,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.network(
                                        bannerProduct.imageUrl![0].toString(),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                                options: CarouselOptions(
                                  enlargeCenterPage: true,
                                  autoPlay: true,
                                  height: 250,
                                ),
                              ),
                        SizedBox(height: 16),
                        // Title
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Popular Product',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        SizedBox(height: 20),
                        GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.8,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemCount: viewModel.products.length,
                          itemBuilder: (context, index) {
                            final product = viewModel.products[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ProductDetailScreen(product: product),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Product Image with Favorite Icon
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          product.images?.isNotEmpty == true
                                              ? product.images![0]
                                              : 'https://via.placeholder.com/150',
                                          height: 120,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        top: 8,
                                        right: 8,
                                        child: GestureDetector(
                                          onTap: () {
                                            proRead.addToWishlist(
                                                context: context,
                                                id: viewModel.products[index].id
                                                    .toString());
                                          },
                                          child: Icon(
                                            product.inWishlist == true
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            size: 24,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  // Product Name and Price
                                  Text(
                                    product.name ?? 'Product Name',
                                    style: GoogleFonts.poppins(fontSize: 14),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    spacing: 9,
                                    children: [
                                      Stack(
                                        children: [
                                          Text(
                                            '${product.mrp} Rs',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                          Positioned(
                                            top: 3,
                                            child: SizedBox(
                                              width: 50,
                                              child: Divider(
                                                thickness: 2,
                                                color: Colors.black,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Text(
                                        '${product.salePrice} Rs',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
