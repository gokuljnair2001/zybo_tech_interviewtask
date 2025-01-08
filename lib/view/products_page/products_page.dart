import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:zybo_tech_interviewtask/controller/products_controller.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      onViewModelReady: (viewModel) {
        WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) {
            viewModel.getProductList();
          },
        );
        WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) => viewModel.onBannerProducts(),
        );
      },
      viewModelBuilder: () => ProductsController(),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Popular Product'),
            backgroundColor: Colors.white,
            elevation: 0,
            foregroundColor: Colors.black,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Carousel Slider
                CarouselSlider.builder(
                  itemCount: viewModel.bannerProducts.length,
                  itemBuilder: (context, index, realIndex) {
                    final bannerProduct = viewModel.bannerProducts[index];
                    return Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          bannerProduct.product?.images?.isNotEmpty == true
                              ? bannerProduct.product!.images!.first
                              : 'https://kerala.mallsmarket.com/sites/default/files/photos/events/LuLuMall-Kochi-LuLuOnSale2015-10-11Jan2015.jpg',
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
                Text(
                  'Popular Product',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                // Product Grid
                Expanded(
                  child: viewModel.products.isEmpty
                      ? Center(child: CircularProgressIndicator())
                      : GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.9,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemCount: viewModel.products.length,
                          itemBuilder: (context, index) {
                            final product = viewModel.products[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Image Container with Love Icon
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        product.images?.isNotEmpty == true
                                            ? product.images!.first
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
                                          // Add logic to add to wishlist
                                          print('Added to wishlist');
                                        },
                                        child: const Icon(
                                          Icons.favorite_border,
                                          size: 24,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                // Text Container (Name, Price, Rating)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '${product.salePrice} Rs',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue),
                                        ),
                                        const Spacer(),
                                        const Icon(
                                          Icons.star,
                                          size: 16,
                                          color: Colors.orange,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${product.avgRating ?? 0}',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      product.addons?.isNotEmpty == true
                                          ? product.addons!.first.name ?? ''
                                          : 'Product Name',
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
