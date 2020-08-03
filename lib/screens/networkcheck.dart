import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class NetworkChek extends StatefulWidget {
  @override
  _NetworkChekState createState(
  
  ) => _NetworkChekState();
}

class _NetworkChekState extends State<NetworkChek> {
  ConnectivityResult result;

  @override
  void initState() {
    super.initState();
    _checkInternetConnectivity(result);
  }

  _showDialog(title, text) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(text),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Ok"),
              )
            ],
          );
        });
  }

  void _checkInternetConnectivity(result) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        
      } else {
        _showDialog('Error!', "No internet connection.");
      }
    } on SocketException catch (_) {
      _showDialog('Error!', "No internet connection.");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}