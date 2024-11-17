import 'package:flutter/material.dart';
import 'package:phoneauth/screen/number_screen.dart';

class LanguageScreen extends StatefulWidget {
  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  List<String> language = ['English', 'Hindi'];

  String? selectItem = "English"; // Default language is set to "English"

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Center content vertically
          children: [
            SizedBox(
              height: 56,
              width: 56,
              child: Image.asset(
                "assets/icons/gallery_icon.png",
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Please select your Language",
              style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  height: 1.172,
                  letterSpacing: 0.07,
                  fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              "You can change the language \n at any time.",
              textAlign: TextAlign.center,
              softWrap: true,
              style: TextStyle(
                fontFamily: 'Roboto',
                color: Color(0xff6A6C7B),
                fontSize: 15,
                height: 1.5,
                letterSpacing: 0.07,
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 215,
              height: 47,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                color: Colors.white,
                //  borderRadius: BorderRadius.circular(8), // Rounded corners
              ),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: selectItem,
                  underline: SizedBox(), // Remove the default underline
                  items: language.map(
                    (String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    },
                  ).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectItem = value;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 30),
            InkWell(
              onTap: () {
                // Action for Next button
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NumberScreen(),
                    ));
              },
              child: Container(
                height: 47,
                width: 215,
                decoration: BoxDecoration(
                  color: Color(0xff2E3B62), // Custom color
                  // borderRadius: BorderRadius.circular(8), // Rounded corners
                ),
                child: Center(
                  child: Text(
                    "NEXT",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Roboto",
                        fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity, // Full width container
        child: Stack(
          children: [
            Image.asset(
              "assets/images/inner_waves.png",
              width: double.infinity, // Stretch to full width
              fit: BoxFit.cover, // Stretch to cover the full width
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                "assets/images/outer_waves.png",
                width: double.infinity, // Stretch to full width
                fit: BoxFit.cover, // Stretch to cover the full width
              ),
            ),
          ],
        ),
      ),
    );
  }
}
