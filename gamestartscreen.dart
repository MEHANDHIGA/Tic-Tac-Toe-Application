import 'package:flutter/material.dart';
import 'choosesidescreen.dart';

class PlayModeScreen extends StatelessWidget {
  const PlayModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6f6f6),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/cross_.png', width: 100),
                Image.asset('assets/circle_.png', width: 100),
              ],
            ),
            SizedBox(height: 50),
            Text(
              "Choose your play mode",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: Size(300,50),
                padding: EdgeInsets.symmetric(vertical: 10),
                elevation: 10,
                shadowColor: Colors.blueGrey,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChooseSideScreen(isAI: true),
                  ),
                );
              },
              child: Text("With NeuralTac",
              style: TextStyle(
                fontSize:24,
                color: Colors.white,
              )),
            ),
            SizedBox(height: 30),
            ElevatedButton( 
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                minimumSize: Size(300,50),
                padding: EdgeInsets.symmetric(vertical: 10),
                elevation: 10,
                shadowColor: Colors.grey,
            ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChooseSideScreen(isAI: false),
                  ),
                );
              },
              child: Text("With a Friend",
               style: TextStyle(
                fontSize:24,
                color: Colors.black,),
            ),
          ),
          ],
        ),
      ),
    );
  }
}
