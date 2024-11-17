import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:phoneauth/screen/verify_screen.dart';

class NumberScreen extends StatefulWidget {
  @override
  _NumberScreenState createState() => _NumberScreenState();
}

class _NumberScreenState extends State<NumberScreen> {
  final TextEditingController phoneController = TextEditingController();
  FirebaseAuth? firebaseAuth;
  bool isLoading = false; // To track loading state

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the screen on close icon press
          },
          icon: Icon(Icons.close),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              "Please enter your mobile number",
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                height: 1.172,
                letterSpacing: 0.07,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "You’ll receive a 6 digit code \n to verify next.",
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
              width: screenWidth * 0.9, // Set width to 90% of screen width
              height: 60,
              child: IntlPhoneField(
                controller: phoneController,
                initialCountryCode: "IN",
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  labelStyle: TextStyle(color: Color(0xff6A6C7B)),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 15), // Adjust vertical padding
                ),
                onChanged: (phone) {
                  // Print the complete phone number to debug
                  print("Phone number: ${phone.completeNumber}");
                },
              ),
            ),
            SizedBox(height: 20),
            isLoading
                ? CircularProgressIndicator() // Show loading indicator if isLoading is true
                : InkWell(
                    onTap: () async {
                      setState(() {
                        isLoading =
                            true; // Set loading to true when the user taps the button
                      });

                      String phoneNumber = phoneController.text.trim();

                      // Ensure phone number includes the correct country code format
                      if (!phoneNumber.startsWith('+')) {
                        phoneNumber = '+91' +
                            phoneNumber; // Add India country code if missing
                      }

                      if (phoneNumber.isNotEmpty && phoneNumber.length >= 10) {
                        try {
                          // Ensure FirebaseAuth is initialized
                          FirebaseAuth auth = FirebaseAuth.instance;

                          await auth.verifyPhoneNumber(
                            phoneNumber:
                                phoneNumber, // Use the complete phone number with country code
                            verificationCompleted:
                                (PhoneAuthCredential credential) async {
                              // Auto-retrieval or auto-verification completed
                              await auth.signInWithCredential(credential);
                              print(
                                  "Phone number automatically verified and user signed in");
                            },
                            verificationFailed: (FirebaseAuthException e) {
                              // Handle verification failure
                              print("Verification failed: ${e.message}");
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content:
                                    Text("Verification failed: ${e.message}"),
                              ));
                            },
                            codeSent:
                                (String verificationId, int? resendToken) {
                              // Code successfully sent
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VerifyScreen(
                                    number: phoneNumber,
                                    verificationId:
                                        verificationId, // Pass verification ID
                                  ),
                                ),
                              );
                            },
                            codeAutoRetrievalTimeout: (String verificationId) {
                              // Auto-retrieval timeout
                              print("Auto-retrieval timeout");
                            },
                            timeout: Duration(seconds: 60), // Timeout duration
                          );
                        } catch (e) {
                          print("Error: $e");
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("An error occurred: $e"),
                          ));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Please enter a valid phone number."),
                        ));
                      }

                      setState(() {
                        isLoading =
                            false; // Set loading to false once the process completes
                      });
                    },
                    child: Container(
                      height: 47,
                      width: screenWidth * 0.9,
                      decoration: BoxDecoration(
                        color: Color(0xff2E3B62),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          "CONTINUE",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Roboto",
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
