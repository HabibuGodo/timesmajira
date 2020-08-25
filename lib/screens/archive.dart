import 'package:flutter/material.dart';


class ArchiveSreen extends StatefulWidget {
  @override
  _ArchiveSreenState createState() => _ArchiveSreenState();
}

class _ArchiveSreenState extends State<ArchiveSreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Archive"),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.contain,
            alignment: Alignment.center,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.2),
              BlendMode.dstATop,
            ),
            image: AssetImage("assets/logo/logonew1.png"),
          ),
        ),
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
