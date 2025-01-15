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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SearchBar(
                controller: controller,
                hintText: 'Search Here',
                onChanged: (value) {
                  viewModel.getSearchResults(
                    keyword: value,
                    context: context,
                  );
                },
              ),
              const SizedBox(height: 20),
              Expanded(child: Builder(
                builder: (context) {
                  if (viewModel.isloading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (viewModel.noResult) {
                    return Center(
                      child: Text('Sorry No reulst found'),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: viewModel.searchResults.length,
                      itemBuilder: (context, index) {
                        final data = viewModel.searchResults[index];
                        return ListTile(
                          leading: Image.network(
                            data.images?.isNotEmpty == true
                                ? data.images![0]
                                : 'https://via.placeholder.com/150',
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(data.addons?.isNotEmpty == true
                              ? data.addons![0].name ?? 'Name not available'
                              : 'Name not available'),
                          subtitle: Text(
                            data.addons?.isNotEmpty == true
                                ? data.addons![0].description ??
                                    'No description available'
                                : 'No description available',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Text(
                            '₹${data.salePrice}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
