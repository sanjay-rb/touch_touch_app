import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double redPoints = 0.0;
  double bluePoints = 0.0;

  final double upValue = 20;

  @override
  void initState() {
    super.initState();
    start();
  }

  start() {
    Future.delayed(const Duration(milliseconds: 1), () {
      setState(() {
        redPoints = MediaQuery.of(context).size.height * 0.5;
        bluePoints = MediaQuery.of(context).size.height * 0.5;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          InkWell(
            onTap: () {
              if (isWon(redPoints)) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => AlertDialog(
                    title: const Text("Red Won"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          start();
                          Navigator.pop(context);
                        },
                        child: const Text("Restart"),
                      )
                    ],
                  ),
                );
              }
              setState(() {
                redPoints += upValue;
                bluePoints -= upValue;
              });
            },
            child: Container(
              color: Colors.red,
              width: MediaQuery.of(context).size.width,
              height: redPoints,
              child: Center(
                child: Text(
                  "${((redPoints / MediaQuery.of(context).size.height) * 100).toStringAsFixed(0)}%",
                  style: const TextStyle(fontSize: 60),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              if (isWon(bluePoints)) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => AlertDialog(
                    title: const Text("Blue Won"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          start();
                          Navigator.pop(context);
                        },
                        child: const Text("Restart"),
                      )
                    ],
                  ),
                );
              }
              setState(() {
                bluePoints += upValue;
                redPoints -= upValue;
              });
            },
            child: Container(
              color: Colors.blue,
              width: MediaQuery.of(context).size.width,
              height: bluePoints,
              child: Center(
                child: Text(
                  "${((bluePoints / MediaQuery.of(context).size.height) * 100).toStringAsFixed(0)}%",
                  style: const TextStyle(fontSize: 60),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isWon(double points) {
    String percentageStr = ((points / MediaQuery.of(context).size.height) * 100)
        .toStringAsFixed(0);
    int percentage = int.parse(percentageStr);
    if (percentage > 80) {
      return true;
    }
    return false;
  }
}
