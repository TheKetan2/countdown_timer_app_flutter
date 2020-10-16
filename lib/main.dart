/**
 * Github: theketan2
 */

import "dart:async";
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.pink,
            ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int seconds = 0;
  Timer timer;
  bool start = true, setting = false;
  int min = 0, sec = 0;

  void _countSec() {
    int s = (min * 60) + sec;
    setState(() {
      seconds = s;
    });
  }

  String _getTime() {
    int m = (seconds / 60).floor();
    int s = seconds - m * 60;
    String fm = "0" + m.toString();
    String fs = "0" + s.toString();
    setState(() {
      setting = seconds == 0 ? true : false;
    });
    return seconds == 0
        ? "00:00"
        : fm.substring(fm.length == 3 ? 1 : 0) +
            ":" +
            fs.substring(fs.length == 3 ? 1 : 0);
  }

  void _startStop() {
    print("Button tapped");
    setState(() {
      start = !start;
      setting = false;
    });
    if (seconds <= 0) {
      setState(() {
        setting = true;
        seconds = min * 60 + sec;
      });
    }
    Timer.periodic(Duration(seconds: 1), (timer) {
      start || seconds == 0
          ? timer.cancel()
          : setState(() {
              seconds--;
            });
    });

    // if (start) timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
                // color: Colors.red,
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NumberPicker.integer(
                        initialValue: min,
                        minValue: 0,
                        maxValue: 10,
                        onChanged: (value) {
                          print(value);
                          setState(() {
                            min = value;
                            setting = true;
                          });
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "MINUTES",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NumberPicker.integer(
                        // decoration: BoxDecoration(color: Colors.white),
                        initialValue: sec,
                        minValue: 0,
                        maxValue: 60,
                        onChanged: (value) {
                          print(value);
                          setState(() {
                            sec = value;
                            setting = true;
                          });
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "SECONDS",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            )),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                _getTime(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 90.0,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Center(
              child: GestureDetector(
                onTap: _startStop,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: setting
                        ? Colors.blueAccent
                        : !start ? Colors.red : Colors.green[400],
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Center(
                      child: Text(
                        setting ? "SET" : start ? "START" : "PAUSE",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
