import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  final String playerSide;
  final bool isAI;

  const GameScreen({super.key, required this.playerSide, required this.isAI});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<String> board = List.filled(16, '');
  String currentPlayer = 'X';
  String winner = '';
  int playScore = 0;
  int aiScore = 0;
  String playerOneName = 'Player';
  String playerTwoName = 'NeuralTAc';

  @override
  void initState() {
    //TODO: implement initState
    super.initState();
    if (widget.playerSide == '0' && widget.isAI) {
      currentPlayer = 'X';
      aiMove();
    }
    if (widget.isAI == false) {
      playerOneName = 'Player 1';
      playerTwoName = 'Player 2';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff6f6f6),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                children: [
                  Text(
                    playerOneName,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade400,
                          blurRadius: 30,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Text(
                      '$playScore - $aiScore',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Text(
                    playerTwoName,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Card(
              color: Colors.white,
              elevation: 5,
              margin: EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                    ),
                    itemCount: 16,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => makeMove(index),
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                              bottom: index < 12
                                  ? BorderSide(width: 2, color: Colors.grey)
                                  : BorderSide.none,
                              right: index < 16 && index % 4 != 3
                                  ? BorderSide(width: 2, color: Colors.grey)
                                  : BorderSide.none,
                            )),
                            child: Center(
                              child: board[index] == 'X'
                                  ? Image.asset(
                                      'assets/cross_.png',
                                      width: 80,
                                    )
                                  : board[index] == 'O'
                                      ? Image.asset(
                                          'assets/circle_.png',
                                          width: 80,
                                        )
                                      : null,
                            )),
                      );
                    }),
              ),
            ),
           SizedBox(height: 20,),
           Text(winner, style: TextStyle(fontSize: 24,color: Colors.green),),
           SizedBox(height: 20,),
           ElevatedButton(
            style: ElevatedButton.styleFrom(
               minimumSize:  Size(200,50),
               backgroundColor: Colors.blue,
               padding: EdgeInsets.symmetric(vertical: 10),
               elevation: 10,
               shadowColor: Colors.blueGrey
            ),
            onPressed: resetBoard,
             child:  Text(
              'Reset Game',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white
              ),
             )
             )
          ],
        )
      );
  }

  void aiMove() {
    for (int i = 0; i < 16; i++) {
      if (board[i] == '') {
        board[i] = currentPlayer;
        if (checkWinner(currentPlayer)) {
          setState(() {
            winner = '$currentPlayer Wins!';
            aiScore++;
          });
          return;
        }
        board[i] = '';
      }
    }

    String opponent = widget.playerSide;
    for (int i = 0; i < 16; i++) {
      if (board[i] == '') {
        board[i] = opponent;
        if (checkWinner(opponent)) {
          setState(() {
            board[i] = currentPlayer;
          });
          currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
          return;
        }
        board[i] = '';
      }
    }
    if (board[4] == '') {
      setState(() {
        board[4] = currentPlayer;
        currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
      });
      return;
    }
    List<int> corners = [0, 3, 12, 15];
    for (int corner in corners) {
      if (board[corner] == '') {
        setState(() {
          board[corner] = currentPlayer;
          currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
        });
        return;
      }
    }
  }

  bool checkWinner(String player) {
    List<List<int>> winPatterns = [
      [0, 1, 2, 3],
      [4, 5, 6, 7],
      [8, 9, 10, 11],
      [12, 13, 14, 15],
      [0, 4, 8, 12],
      [1, 5, 9, 13],
      [2, 6, 10, 14],
      [3, 7, 11, 12],
      [0, 5, 10, 15],
      [3, 6, 9, 12],
    ];
    for (var pattern in winPatterns) {
      if (board[pattern[0]] == player &&
          board[pattern[1]] == player &&
          board[pattern[2]] == player &&
          board[pattern[3]] == player) {
        return true;
      }
    }
    return false;
  }

  void makeMove(int index) {
    if (board[index] == '' && winner == '') {
      setState(() {
        board[index] = currentPlayer;
        if (checkWinner(currentPlayer)) {
          winner = '$currentPlayer Wins!';
          if (currentPlayer == widget.playerSide) {
            playScore++;
          } else {
            aiScore++;
          }
        } else if (!board.contains('')) {
          winner = 'Draw!';
        } else {
          currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
          if (widget.isAI && currentPlayer != widget.playerSide) {
            aiMove();
          }
        }
      });
    }
  }

  void resetBoard() {
    setState(() {
      board = List.filled(16, '');
      winner = '';
      currentPlayer = widget.playerSide == 'O' ? 'X' : 'X';
      if(widget.playerSide == 'O' && widget.isAI){
        aiMove();
      }
    });
  }
}
