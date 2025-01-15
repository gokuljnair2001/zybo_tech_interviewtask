import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:zybo_tech_interviewtask/controller/products_controller.dart';
import 'package:zybo_tech_interviewtask/controller/wishlist_controller.dart';
import 'package:zybo_tech_interviewtask/utils/constants/string_constants.dart';
import 'package:zybo_tech_interviewtask/utils/functions/shimmers.dart';
import 'package:zybo_tech_interviewtask/view/login_page/login_page.dart';
import 'package:zybo_tech_interviewtask/view/products_page/produst_details.dart';
import 'package:zybo_tech_interviewtask/view/profile_page/profile_page.dart';
import 'package:zybo_tech_interviewtask/view/search_screen/search_screen.dart';

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
            title: const Text('Popular Product'),
            backgroundColor: Colors.white,
            elevation: 0,
            foregroundColor: Colors.black,
            actions: [
              IconButton(
                onPressed: () async {
                  const secureStorage = FlutterSecureStorage();
                  await secureStorage.delete(key: StringConstants.token);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LogIn()),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.logout),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfilePage(),
                      ));
                },
                icon: const Icon(Icons.person),
              )
            ],
          ),
          body: viewModel.products.isEmpty
              ? buildShimmerLoading()
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SearchScreen(),
                                ));
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 20),
                            padding: EdgeInsets.symmetric(horizontal: 9),
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Search...'),
                                  Icon(Icons.search)
                                ],
                              ),
                            ),
                          ),
                        ),
                        viewModel.bannerProducts.isEmpty
                            ? buildShimmerBanner()
                            : CarouselSlider.builder(
                                itemCount: 5,
                                itemBuilder: (context, index, realIndex) {
                                  return Container(
                                    height: 100,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.network(
                                        viewModel.products[index].images?[0] ??
                                            'https://via.placeholder.com/150',
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
                        const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Popular Product',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
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
                                  Text(
                                    product.name ?? 'Product Name',
                                    style: GoogleFonts.poppins(fontSize: 14),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
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
                                              child: const Divider(
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
