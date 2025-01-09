import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zybo_tech_interviewtask/controller/search_controller.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return ViewModelBuilder<ProductSearchController>.reactive(
      viewModelBuilder: () => ProductSearchController(),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Search'),
        ),
        body: Column(
          children: [
            // Search TextField
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: TextField(
                controller: controller,
                onChanged: (value) {
                  viewModel.search(keyword: controller.text, context: context);
                },
                decoration: InputDecoration(
                  hintText: 'Search products...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
            ),

            // Display loading indicator or search results
            Expanded(
              child: viewModel.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : viewModel.searchList.isEmpty
                      ? Center(
                          child: Text(
                            'No products found',
                            style:
                                TextStyle(fontSize: 16, color: Colors.grey[600]),
                          ),
                        )
                      : ListView.builder(
                          itemCount: viewModel.searchList.length,
                          itemBuilder: (context, index) {
                            final product = viewModel.searchList[index];
                            return ListTile(
                              title: Text(product.name ?? 'Name not available'),
                              subtitle: Text(
                                product.price.toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              trailing: Container(
                                decoration: BoxDecoration(
                                  color: (product.isActive ?? false)
                                      ? Colors.green[200]
                                      : Colors.red[200],
                                  borderRadius: BorderRadius.circular(9),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Text(
                                    (product.isActive ?? false)
                                        ? 'Active'
                                        : 'Not active',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
