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
            fit: BoxFit.cover,
            alignment: Alignment.center,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5), BlendMode.dstATop),
            image: AssetImage("assets/images/archive.jpg"),
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
