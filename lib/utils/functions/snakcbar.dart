import 'package:flutter/material.dart';
 errorSnackbar({required String error,required BuildContext context}){
  return    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $error')));
  
}