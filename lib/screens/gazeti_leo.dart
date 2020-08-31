import 'dart:ui';
import 'package:advance_pdf_viewer_fork/advance_pdf_viewer_fork.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';

class GazetiLeo extends StatefulWidget {
  @override
  _GazetiLeoState createState() => _GazetiLeoState();
}

class _GazetiLeoState extends State<GazetiLeo> {
  var strToday = '';
  String gazetiUrl = '';
  bool _loading;
  PDFDocument _doc;
  void initState() {
    super.initState();
    // check if gazeti is on firebase to download
    checkForDownload();
    //initiate the file path
  }

  //METHOD TO CONVERT DATE
  String getStrToday() {
    var today = DateFormat().add_yMMMMd().format(DateTime.now());
    var day = today.split(' ')[1].replaceFirst(',', '');
    var strDay = today.split(' ')[1].replaceFirst(',', '');
    if (strDay == '1') {
      strDay = strDay + 'st';
    } else if (strDay == '2') {
      strDay = strDay + 'nd';
    } else if (strDay == '3') {
      strDay = strDay + 'rd';
    } else {
      strDay = strDay + 'th';
    }

    var strMonth = today.split(' ')[0];
    var strYear = today.split(' ')[2];
    strToday = '$strDay $strMonth, $strYear';
    //return '$day$strMonth$strYear';
    return '$day$strMonth';
  }

  // check if newspaper is on firebase to download
  Future checkForDownload() async {
    // file name format is daymonth eg. 25August
    // firebase real name for live app = ${getStrToday()}
    setState(() {
      _loading = true;
    });
    StorageReference reference =
        FirebaseStorage.instance.ref().child("magazeti/${getStrToday()}.pdf");
    String downloadURL = await reference.getDownloadURL();
    setState(() {
      gazetiUrl = downloadURL;
    });
    final doc = await PDFDocument.fromURL(gazetiUrl);
    setState(() {
      _doc = doc;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Gazeti La Leo"),
      ),
      body: gazetiUrl != ''
          ? _loading
              ? Center(
                  child: SpinKitThreeBounce(color: Colors.orange, size: 50),
                )
              : PDFViewer(
                  document: _doc,
                  indicatorBackground: Colors.orange,
                  indicatorPosition: IndicatorPosition.bottomRight,
                  indicatorText: Colors.black,
                  enableSwipeNavigation: true,
                  scrollDirection: Axis.horizontal,
                  showIndicator: true,
                  showPicker: false,
                )
          : Container(
              child: Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: Center(
                  child: Text(
                    "Gazeti la leo $strToday litapatikana hapa",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
    );
  }
}
