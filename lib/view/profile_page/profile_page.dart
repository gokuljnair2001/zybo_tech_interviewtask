import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:zybo_tech_interviewtask/controller/profile_controller.dart';
import 'package:zybo_tech_interviewtask/utils/constants/string_constants.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    late String name;
    late String number;

    return ViewModelBuilder.reactive(
      onModelReady: (viewModel) {
        viewModel.getData(context: context);
        WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) async {
            final preff = await SharedPreferences.getInstance();
            name = preff.getString(StringConstants.name).toString();
            number = preff.getString(StringConstants.phoneNumber).toString();
          },
        );
      },
      viewModelBuilder: () => ProfileController(),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'My Profile',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          body: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Name',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Builder(builder: (context) {
                  if (viewModel.noData) {
                    return Text(name,
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ));
                  } else {
                    return Text(
                      viewModel.profileResponse?.name ?? 'No Name',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    );
                  }
                }),
                const SizedBox(height: 24),
                const Text(
                  'Phone',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Builder(builder: (context) {
                  if (viewModel.noData) {
                    return Text(
                      number,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    );
                  } else {
                    return Text(
                      viewModel.profileResponse?.phoneNumber ?? 'No Number',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    );
                  }
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}
