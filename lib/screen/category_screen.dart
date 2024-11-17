import 'package:flutter/material.dart';

// Main Screen
class ProfileSelectionScreen extends StatefulWidget {
  @override
  _ProfileSelectionScreenState createState() => _ProfileSelectionScreenState();
}

class _ProfileSelectionScreenState extends State<ProfileSelectionScreen> {
  String? selectedProfile;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: screenHeight * 0.05), // Adjusted for screen size
            Text(
              'Please select your profile',
              style: TextStyle(
                fontSize: screenHeight * 0.025, // Adjusted font size
                height: 1.5,
                letterSpacing: 0.07,
                fontWeight: FontWeight.w700,
                fontFamily: "Roboto",
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: screenHeight * 0.03), // Adjusted for screen size
            // Shipper Profile Option
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: selectedProfile == 'Shipper'
                    ? Colors.indigo.withOpacity(0.1)
                    : Colors.white,
                border: Border.all(
                  width: 1,
                  color: selectedProfile == 'Shipper'
                      ? Colors.indigo
                      : Colors.grey,
                ),
              ),
              child: ListTile(
                onTap: () {
                  setState(() {
                    selectedProfile = 'Shipper';
                  });
                },
                title: Row(
                  children: [
                    Radio<String>(
                      value: 'Shipper',
                      groupValue: selectedProfile,
                      onChanged: (value) {
                        setState(() {
                          selectedProfile = value;
                        });
                      },
                      activeColor: Colors.indigo,
                    ),
                    SizedBox(
                        width: screenWidth * 0.02), // Adjusted for screen size
                    Icon(Icons.home,
                        size: screenHeight * 0.05, // Adjusted icon size
                        color: selectedProfile == 'Shipper'
                            ? Colors.indigo
                            : Colors.black54),
                    SizedBox(
                        width: screenWidth * 0.04), // Adjusted for screen size
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Shipper',
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize:
                                  screenHeight * 0.022, // Adjusted font size
                              fontWeight: FontWeight.w400,
                              color: selectedProfile == 'Shipper'
                                  ? Colors.indigo
                                  : Colors.black,
                            ),
                          ),
                          SizedBox(
                              height: screenHeight *
                                  0.005), // Adjusted for screen size
                          Text(
                            'Get season-ready with up to 50% off on your favorite styles',
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02), // Adjusted for screen size
            // Transporter Profile Option
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: selectedProfile == 'Transporter'
                    ? Colors.indigo.withOpacity(0.1)
                    : Colors.white,
                border: Border.all(
                  width: 1,
                  color: selectedProfile == 'Transporter'
                      ? Colors.indigo
                      : Colors.grey,
                ),
              ),
              child: ListTile(
                onTap: () {
                  setState(() {
                    selectedProfile = 'Transporter';
                  });
                },
                title: Row(
                  children: [
                    Radio<String>(
                      value: 'Transporter',
                      groupValue: selectedProfile,
                      onChanged: (value) {
                        setState(() {
                          selectedProfile = value;
                        });
                      },
                      activeColor: Colors.indigo,
                    ),
                    SizedBox(
                        width: screenWidth * 0.02), // Adjusted for screen size
                    Icon(Icons.local_shipping,
                        size: screenHeight * 0.05, // Adjusted icon size
                        color: selectedProfile == 'Transporter'
                            ? Colors.indigo
                            : Color(0xff2F3037)),
                    SizedBox(
                        width: screenWidth * 0.04), // Adjusted for screen size
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Transporter',
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize:
                                  screenHeight * 0.022, // Adjusted font size
                              fontWeight: FontWeight.w400,
                              color: selectedProfile == 'Transporter'
                                  ? Colors.indigo
                                  : Color(0xff2F3037),
                            ),
                          ),
                          SizedBox(
                              height: screenHeight *
                                  0.005), // Adjusted for screen size
                          Text(
                            'Get season-ready with up to 50% off on your favorite styles',
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            InkWell(
              onTap: selectedProfile != null
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SelectedProfileScreen(
                            profile: selectedProfile!,
                          ),
                        ),
                      );
                    }
                  : null,
              child: Container(
                height: screenHeight * 0.06, // Adjusted for screen size
                width: screenWidth * 0.9,
                decoration: BoxDecoration(
                  color:
                      selectedProfile != null ? Color(0xff2E3B62) : Colors.grey,
                  // borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    "CONTINUE",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Roboto",
                      fontSize: screenHeight * 0.022, // Adjusted font size
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

// New Screen to display selected profile
class SelectedProfileScreen extends StatelessWidget {
  final String profile;

  SelectedProfileScreen({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selected Profile'),
      ),
      body: Center(
        child: Text(
          'You selected: $profile',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
