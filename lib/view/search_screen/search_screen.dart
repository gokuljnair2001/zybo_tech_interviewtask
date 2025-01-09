import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zybo_tech_interviewtask/controller/search_controller.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(viewModelBuilder: () => ProductSearchController(), builder: (context, viewModel, child) => Scaffold(
      appBar: AppBar(title: Text('Search'),),

      body:viewModel.noResult?Center(child: Text('No results Found'),): ListView.builder(itemBuilder:(context, index) =>  ListTile(
title: Text(viewModel.searchList[index].name??'Name not available'),
subtitle: Text(viewModel.searchList[index].price.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
trailing: Builder(builder: (context) {
  if (viewModel.searchList[index].isActive??true) 
  {

    return Container(
      decoration: BoxDecoration(color: Colors.green[200],borderRadius: BorderRadius.circular(9)),
      child: Padding(padding: 
      EdgeInsets.symmetric(horizontal: 5),
      
      child: Text('active',style: TextStyle(color: Colors.white),),
      ),
    );
    
  }
  else{
        return Container(
      decoration: BoxDecoration(color: Colors.red[200],borderRadius: BorderRadius.circular(9)),
      child: Padding(padding: 
      EdgeInsets.symmetric(horizontal: 5),
      
      child: Text('Not active',style: TextStyle(color: Colors.white),),
      ),
    );
  }
},),
),

      ) 
    ) );
  }
}