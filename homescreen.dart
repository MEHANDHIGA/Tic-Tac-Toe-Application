import 'package:flutter/material.dart';
import 'package:tic_tac_toe/gamestartscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false; // To manage the loading state

  // Function to handle the button press and navigate to a new screen
  void _handleButtonPress() async {
    setState(() {
      isLoading = true; // Show the loading indicator
    });

    // Simulate a delay (e.g., fetching data or processing)
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      isLoading = false; // Hide the loading indicator
    });

    // Navigate to the new screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PlayModeScreen()), // Go to NewScreen after loading
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand, // Makes the background image fill the entire screen
        children: [
          // Background Image
          Image.asset(
            'assets/background.png', // Path to your background image
            fit: BoxFit.cover, // Ensures the image covers the entire screen
          ),

          // Foreground Content
          Stack(
            children: [
              // Centered Welcome Text
              Center(
                child: Text(
                  'Welcome to the Quadro-XO!',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white, // Text color for contrast
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        offset: Offset(2, 2),
                        blurRadius: 4,
                        color: Colors.black54, // Text shadow for better visibility
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              // Loading Button Positioned at Bottom-Center
              Align(
                alignment: Alignment.bottomCenter, // Position the button at the bottom-center
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40), // Add padding from the bottom edge
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _handleButtonPress,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey, // Button color
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: isLoading
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.0,
                            ),
                          )
                        : Text(
                            'Loading......',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}





void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeScreen(), // HomeScreen is the entry point
  ));
}
