import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:zybo_tech_interviewtask/controller/registration_controller.dart';

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    final nameController = TextEditingController();
    final key = GlobalKey<FormState>();
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => RegistrationController(),
      builder: (context, viewModel, child) => Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 200),
                  Text(
                    'Login',
                    style: GoogleFonts.poppins(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Let's Connect with Lorem Ipsum..!",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      const Text(
                        '+91',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          // onChanged: (value) {

                          //   log('Api called');
                          // },
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Number can\'t be empty';
                            }
                            return null;
                          },
                          controller: controller,
                          decoration: const InputDecoration(
                            hintText: 'Enter Phone',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            border: UnderlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name can\'t be empty';
                      }
                      return null;
                    },
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: 'Enter Name',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      border: UnderlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        viewModel.getOtp(
                          phone_number: controller.text,
                          context: context,
                        );
                        if (key.currentState!.validate()) {
                          viewModel.registerUser(
                            name: nameController.text,
                            number: controller.text,
                            context: context,
                          );

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'otp is ${viewModel.otpModel?.otp.toString()}'),
                          ));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: 'By Continuing you accepting the ',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(
                            text: 'Terms of Use ',
                            style: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          const TextSpan(text: '& '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
