import 'dart:isolate';
import 'dart:ui';

import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';

class GazetiLeo extends StatefulWidget {
  @override
  _GazetiLeoState createState() => _GazetiLeoState();
}

class _GazetiLeoState extends State<GazetiLeo> {
  var strToday = '';
  int downloadProgress = 0;
  DownloadTaskStatus downloadStatus;
  ReceivePort _port = ReceivePort();
  String movieUrl = '';
  String downloadId;
  bool isLoad = false;
  void initState() {
    super.initState();

    checkForDownload(); // check if movies is on firebase to download
  }

  _init() {
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      print('UI Isolate Callback: $data');
      //String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];

      setState(() {
        downloadProgress = progress;
        downloadStatus = status;
      });
    });
    FlutterDownloader.registerCallback(downloadCallback);
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    print(
        'Isolate Callback: task ($id) is in status ($status) and process ($progress)');
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }

  Future<PermissionStatus> _checkPermission() async {
    // _isLoading = true;
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);
    if (permission != PermissionStatus.granted) {
      Map<PermissionGroup, PermissionStatus> permisionStatus =
          await PermissionHandler()
              .requestPermissions([PermissionGroup.storage]);
      return permisionStatus[PermissionGroup.storage] ??
          PermissionStatus.unknown;
    } else {
      return permission;
    }
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
    StorageReference reference =
        FirebaseStorage.instance.ref().child("magazeti/${getStrToday()}.pdf");
    String downloadURL = await reference.getDownloadURL();
    setState(() {
      movieUrl = downloadURL;
      isLoad = true;
    });
  }

  Future _requestDownload() async {
    PermissionStatus permissionStatus = await _checkPermission();
    if (permissionStatus == PermissionStatus.granted) {
      String dir = await ExtStorage.getExternalStoragePublicDirectory(
          ExtStorage.DIRECTORY_DOWNLOADS);
      final taskId = await FlutterDownloader.enqueue(
        url: movieUrl,
        fileName: "Timesmajira.pdf",
        savedDir: dir,
        showNotification:
            true, // show download progress in status bar (for Android)
        openFileFromNotification:
            true, // click on notification to open downloaded file (for Android)
      );
      downloadId = taskId;
    }
  }

  void _stopDownload(String taskId) async {
    await FlutterDownloader.cancel(taskId: taskId);
  }

  Future<bool> _openDownloadedFile(String taskId) {
    return FlutterDownloader.open(taskId: taskId);
  }

  Widget _buildActionForTask(String taskId) {
    if (downloadId == null || downloadStatus == DownloadTaskStatus.undefined) {
      return new FloatingActionButton.extended(
        onPressed: () {
          _requestDownload();
        },
        label: Column(
          children: <Widget>[
            Icon(Icons.cloud_download),
            Text(
              'Download',
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
          child: movieUrl != ''
              ? _buildActionForTask(downloadId)
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
