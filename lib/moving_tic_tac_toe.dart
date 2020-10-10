import 'package:flutter/material.dart';

class MovingTicTacToe extends StatefulWidget {
  @override
  _MovingTicTacToeState createState() => _MovingTicTacToeState();
}

class _MovingTicTacToeState extends State<MovingTicTacToe>
    with SingleTickerProviderStateMixin {
  //Stores if circle wins or cross wins
  String message;
//Creating a list of Strings
  List<String> gameState;
  List<String> movingGameState;
  AnimationController _animationController;
  int readyToMove = 9;
  bool ismoving = false;
  bool isCross = true;
  int max = 0;
  //TODO: initiazlie the state of box with empty
  @override
  void initState() {
    super.initState();
    _animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController.repeat(reverse: true);

    resetGame();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void resetGame() {
    setState(() {
      this.gameState = [
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
      ];
      this.message = "";
      this.max = 0;
      this.readyToMove = 9;
      emptyList.clear();
    });
  }

//TODO: playGame method
  playGame(int index) {
    if (max < 6) {
      if (this.gameState[index] == "empty") {
        setState(() {
          if (this.isCross) {
            this.gameState[index] = "cross";
          } else {
            this.gameState[index] = "circle";
          }
          this.isCross = !this.isCross;
          this.checkWin();
        });
      }
    } else {
      if (this.gameState[index] == "empty" && max > 5 && ismoving) {
        setState(() {
          if (this.isCross) {
            this.gameState[readyToMove] = "empty";
            this.gameState[index] = "cross";
          } else {
            this.gameState[readyToMove] = "empty";
            this.gameState[index] = "circle";
          }
          this.isCross = !this.isCross;
          emptyList.clear();
          this.checkWin();
          ismoving = false;
        });
      }
    }
    setState(() {
      max++;
    });
  }

  readytoMove(int index) {
    if (this.gameState[index] != "empty") {
      this.showAvailableSlots();
      setState(() {
        readyToMove = index;
        ismoving = true;
        // this.isCross = !this.isCross;
      });
    }
  }

  //delay Effect
  delay() {
    Future.delayed(const Duration(milliseconds: 0), () {
      showDialog(
        context: context,
        child: new AlertDialog(
          title: const Text("Tic Tac Toe"),
          content: Text(this.message),
          actions: [
            new FlatButton(
              child: const Text("Ok"),
              onPressed: () {
                setState(() {
                  print(this.message);
                  this.resetGame();
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    });
  }

//TODO: check for win logic
  checkWin() {
    if ((gameState[0] != 'empty') &&
        (gameState[0] == gameState[1]) &&
        (gameState[1] == gameState[2])) {
      // if any user Win update the message state
      setState(() {
        this.message = '${this.gameState[0]} wins';
        this.delay();
      });
    } else if ((gameState[3] != 'empty') &&
        (gameState[3] == gameState[4]) &&
        (gameState[4] == gameState[5])) {
      setState(() {
        this.message = '${this.gameState[3]} wins';
        this.delay();
      });
    } else if ((gameState[6] != 'empty') &&
        (gameState[6] == gameState[7]) &&
        (gameState[7] == gameState[8])) {
      setState(() {
        this.message = '${this.gameState[6]} wins';
        this.delay();
      });
    } else if ((gameState[0] != 'empty') &&
        (gameState[0] == gameState[3]) &&
        (gameState[3] == gameState[6])) {
      setState(() {
        this.message = '${this.gameState[0]} wins';
        this.delay();
      });
    } else if ((gameState[1] != 'empty') &&
        (gameState[1] == gameState[4]) &&
        (gameState[4] == gameState[7])) {
      setState(() {
        this.message = '${this.gameState[1]} wins';
        this.delay();
      });
    } else if ((gameState[2] != 'empty') &&
        (gameState[2] == gameState[5]) &&
        (gameState[5] == gameState[8])) {
      setState(() {
        this.message = '${this.gameState[2]} wins';
        this.delay();
      });
    } else if ((gameState[0] != 'empty') &&
        (gameState[0] == gameState[4]) &&
        (gameState[4] == gameState[8])) {
      setState(() {
        this.message = '${this.gameState[0]} wins';
        this.delay();
      });
    } else if ((gameState[2] != 'empty') &&
        (gameState[2] == gameState[4]) &&
        (gameState[4] == gameState[6])) {
      setState(() {
        this.message = '${this.gameState[2]} wins';
        this.delay();
      });
    } else if (!gameState.contains('empty')) {
      setState(() {
        this.message = 'Game Draw';
        this.delay();
      });
    }
  }

  IconData empty = Icons.check_box_outline_blank;
  IconData cross = Icons.close;
  IconData circle = Icons.trip_origin;
  IconData getIcon(String value) {
    switch (value) {
      case ('empty'):
        return null;
        break;
      case ('cross'):
        return cross;
        break;
      case ('circle'):
        return circle;
        break;
      default:
        return null;
    }
  }

  Color getIconColor(String value) {
    switch (value) {
      case ('empty'):
        return Colors.red;
        break;
      case ('cross'):
        return Colors.teal;
        break;
      case ('circle'):
        return Colors.yellow;
        break;
      default:
        return null;
    }
  }

  List<int> emptyList = [];
  showAvailableSlots() {
    for (var i = 0; i < this.gameState.length; i++) {
      if (this.gameState[i] == "empty") {
        emptyList.add(i);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Movable Tic Tac Toe"),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
                padding: EdgeInsets.all(20.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  // childAspectRatio: 1.0,
                  crossAxisSpacing: 1.0,
                  mainAxisSpacing: 1.0,
                ),
                itemCount: this.gameState.length,
                itemBuilder: (context, i) => InkWell(
                      onTap: () => this.playGame(i),
                      // onFocusChange: ,
                      onLongPress: () {
                        print("long pressed");
                        readytoMove(i);

                        emptyList.forEach((element) {
                          print("empty slot" + element.toString());
                        });
                        // this.move(i, 8);
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: emptyList.contains(i)
                              ? Colors.grey
                              : Colors.white.withOpacity(0.1),
                          // border: Border.all(color: Colors.grey[700]),
                        ),
                        child: Center(
                          child: readyToMove == i
                              ? FadeTransition(
                                  opacity: _animationController,
                                  child: Icon(
                                    this.getIcon(this.gameState[i]),
                                    color: this.getIconColor(this.gameState[i]),
                                    size: 60,
                                  ))
                              : Icon(
                                  this.getIcon(this.gameState[i]),
                                  color: this.getIconColor(this.gameState[i]),
                                  size: 60,
                                ),
                        ),
                      ),
                    )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => resetGame(),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  vertical: height * 0.03,
                ),
                decoration: BoxDecoration(
                  color: Colors.yellow,
                ),
                child: Center(
                    child: Text(
                  "Re-Start",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
