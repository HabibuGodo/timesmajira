import 'package:flutter/material.dart';


class GazetiLeo extends StatefulWidget {
  @override
  _GazetiLeoState createState() => _GazetiLeoState();
}

class _GazetiLeoState extends State<GazetiLeo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Gazeti La Leo"),
      ),
      body: Container(
        child: Center(
          child: Text(
            "Huduma hii itakujia hivi punde..",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
