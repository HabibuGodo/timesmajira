import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:timesmajira/utility/fadetransation.dart';

class GazetiLeo extends StatefulWidget {
  @override
  _GazetiLeoState createState() => _GazetiLeoState();
}

class _GazetiLeoState extends State<GazetiLeo> {
  var strToday = '';
  int downloadProgress = 0;
  String gazetiUrl = '';
  bool isLoad = false;
  String urlPDFPath = '';
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

  // check if movies is on firebase to download
  Future checkForDownload() async {
    // file name format is daymonth eg. 25August
    // firebase real name for live app = ${getStrToday()}
    StorageReference reference =
        FirebaseStorage.instance.ref().child("magazeti/timesmajira.pdf");
    String downloadURL = await reference.getDownloadURL();
    setState(() {
      gazetiUrl = downloadURL;
    });
    readNewsPaper(gazetiUrl).then((f) {
      setState(() {
        urlPDFPath = f.path;
      });
    });
  }

  Future<File> readNewsPaper(String url) async {
    try {
      var data = await http.get(url);
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/timesmajiraa.pdf");
      File urlFile = await file.writeAsBytes(bytes);
      return urlFile;
    } catch (e) {
      throw Exception("Tafadhari subiri");
    }
  }

  Widget buildActionForTask() {
    return new FloatingActionButton.extended(
      onPressed: () {
        if (urlPDFPath != null) {
          Navigator.push(
            context,
            MyCustomRoute(
              builder: (context) => ReadGazeti(
                path: urlPDFPath,
              ),
            ),
          );
        } else {
          Center(
            child: SpinKitThreeBounce(color: Colors.orange, size: 50),
          );
        }
      },
      label: Column(
        children: <Widget>[
          Icon(Icons.folder_open),
          Text(
            'Soma Hapa',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
      backgroundColor: Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Gazeti La Leo"),
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
          child: gazetiUrl != ''
              ? buildActionForTask()
              : Container(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20, left: 20),
                    child: Text(
                      "Tafadhari subiri punde utalipata gazeti la leo $strToday",
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
      ),
    );
  }
}

class ReadGazeti extends StatefulWidget {
  final String path;

  const ReadGazeti({Key key, this.path}) : super(key: key);

  @override
  _ReadGazetiState createState() => _ReadGazetiState();
}

class _ReadGazetiState extends State<ReadGazeti> {
  int _totalPages = 0;
  int _currentPage = 0;
  bool pdfReady = false;
  PDFViewController _pdfViewController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Gazeti La Leo'),
      ),
      body: Stack(
        children: <Widget>[
          PDFView(
            fitEachPage: true,
            filePath: widget.path,
            autoSpacing: true,
            enableSwipe: true,
            pageSnap: true,
            //swipeHorizontal: true,
            onRender: (_pages) {
              setState(() {
                _totalPages = _pages;
                pdfReady = true;
              });
            },
            onViewCreated: (PDFViewController vc) {
              _pdfViewController = vc;
            },
            onPageChanged: (int page, int total) {
              setState(() {
                _currentPage = page + 1;
                _totalPages = total;
                //_pdfViewController.setPage(_currentPage);
              });
            },
            onPageError: (page, error) {},
          ),
          !pdfReady
              ? Center(
                  child: SpinKitThreeBounce(color: Colors.orange, size: 50),
                )
              : Offstage(),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            "Uk $_currentPage / $_totalPages",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
