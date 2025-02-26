import 'package:flutter/material.dart';
import 'gamescreen.dart';

class ChooseSideScreen extends StatefulWidget {
  final bool isAI;
  const ChooseSideScreen({super.key, required this.isAI});

  @override
  _ChooseSideScreenState createState() => _ChooseSideScreenState();
}

class _ChooseSideScreenState extends State<ChooseSideScreen> {
  String selectedSide = 'X';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6f6f6),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Pick Your Side",
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/cross_.png',
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                    Transform.scale(
                      scale: 1.5,
                      child: Radio(
                        value: 'X',
                        groupValue: selectedSide,
                        activeColor: Colors.green,
                        onChanged: (value) {
                          setState(() {
                            selectedSide = value!;
                          });
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Image.asset(
                      'assets/circle_.png',
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                    Transform.scale(
                      scale: 1.5,
                      child: Radio(
                        value: 'O',
                        groupValue: selectedSide,
                        activeColor: Colors.red,
                        onChanged: (value) {
                          setState(() {
                            selectedSide = value!;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(200, 50),
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    elevation: 10,
                    shadowColor: Colors.grey),
                onPressed: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => GameScreen(
                        playerSide: selectedSide, 
                        isAI: widget.isAI)
                      )
                  );
                },
                child: Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black54,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
