import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Name',
              style: GoogleFonts.poppins(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Gokul J Nair',
              style: GoogleFonts.poppins(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Phone Number',
              style: GoogleFonts.poppins(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '9746405789',
              style: GoogleFonts.poppins(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
