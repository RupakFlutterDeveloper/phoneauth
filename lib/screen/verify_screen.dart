import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:phoneauth/screen/category_screen.dart';
import 'package:pinput/pinput.dart';

class VerifyScreen extends StatefulWidget {
  final String number; // Phone number
  final String verificationId; // Verification ID from Firebase

  VerifyScreen({required this.number, required this.verificationId});

  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String? _verificationId;
  bool _isLoading = false; // Track loading state

  @override
  void initState() {
    super.initState();
    _verificationId = widget.verificationId;
  }

  // Function to resend the OTP code
  Future<void> resendOtp() async {
    setState(() {
      _isLoading = true; // Show loading indicator when OTP is being sent
    });

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: widget.number,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-verification completed, sign in the user automatically
          await _auth.signInWithCredential(credential);
          print("Phone number automatically verified.");
        },
        verificationFailed: (FirebaseAuthException e) {
          // Handle verification failure
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Verification failed: ${e.message}")),
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          // Update the verification ID
          setState(() {
            _verificationId = verificationId;
            _isLoading = false; // Hide loading indicator after OTP is sent
          });
          print("OTP sent again, new verificationId: $verificationId");
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Timeout for auto-retrieval
          print("Auto-retrieval timeout");
          setState(() {
            _isLoading = false; // Hide loading indicator on timeout
          });
        },
        timeout: Duration(seconds: 60),
      );
    } catch (e) {
      print("Error resending OTP: $e");
      setState(() {
        _isLoading = false; // Hide loading indicator in case of error
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error resending OTP: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 70),
            Text(
              "Verify Phone",
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                height: 1.172,
                letterSpacing: 0.07,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 7),
            Text(
              "Code is sent to ${widget.number}",
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
            if (_isLoading)
              CircularProgressIndicator() // Show loading indicator if in progress
            else
              Pinput(
                length: 6,
                keyboardType: TextInputType.number,
                onCompleted: (value) async {
                  try {
                    // Create a PhoneAuthCredential with the code
                    PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                      verificationId: _verificationId!,
                      smsCode: value,
                    );

                    // Sign in the user with the credential
                    await FirebaseAuth.instance
                        .signInWithCredential(credential);

                    // If successful, navigate to the next screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileSelectionScreen(),
                      ),
                    );
                  } catch (e) {
                    // Show an error message if the OTP verification fails
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Invalid OTP or error: $e")),
                    );
                  }
                },
                defaultPinTheme: PinTheme(
                  textStyle: TextStyle(fontSize: 25),
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Color(0xff93D2F3),
                  ),
                ),
              ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Didn’t receive the code? ",
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Color(0xff6A6C7B),
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    height: 1.5,
                    letterSpacing: 0.07,
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Trigger OTP resend
                    print("Request Again tapped");
                    resendOtp(); // Call the resendOtp function
                  },
                  child: Text(
                    "Request Again",
                    style: TextStyle(
                      color: Color.fromARGB(255, 78, 80, 82),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                // If you want to navigate directly (without verifying the OTP)
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileSelectionScreen(),
                  ),
                );
              },
              child: Container(
                height: 47,
                width: MediaQuery.of(context).size.width * 0.9,
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
