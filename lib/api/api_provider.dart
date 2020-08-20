import 'dart:convert';
import 'dart:io';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class ApiProvider extends BaseCacheManager {
  var responseData;
  static final String _baseUrl =
      'https://timesmajira.co.tz/wp-json/wp/v2/posts?_embed&per_page=100';
  static final String _key = 'Basic Ym1sYXRhOkN1ZGRsZXoyMDE5Lg==';
  static final String _acceptance = 'application/json';

  static const key = "customCache";

  static ApiProvider _instance;

  // singleton implementation
  // for the custom cache manager
  factory ApiProvider() {
    if (_instance == null) {
      _instance = new ApiProvider._();
    }
    return _instance;
  }

  // pass the default setting values to the base class
  // link the custom handler to handle HTTP calls
  // via the custom cache manager
  ApiProvider._()
      : super(
          key,
          maxAgeCacheObject: Duration(days: 7),
          maxNrOfCacheObjects: 100,
        );

  @override
  Future<String> getFilePath() async {
    var directory = await getTemporaryDirectory();
    return path.join(directory.path, key);
  }

  Future<List> getPostedNews() async {
    try {
      var file = await ApiProvider().getSingleFile(_baseUrl,
          headers: {"Authorization": _key, "Accept": _acceptance});
      if (file != null && await file.exists()) {
        var res = await file.readAsString();
        responseData = jsonDecode(res);
        print(responseData);
        return responseData;
      }
    } on SocketException {
      print('No internet connection');
    } catch (e) {
      // print("error imetokea");
      throw Exception('Failed to load post');
    }
    return null;
  }

  Future<List> getSportNews() async {
    try {
      var file = await ApiProvider().getSingleFile(
        _baseUrl + "&categories=35",
        headers: {'Authorization': _key, 'Accept': _acceptance},
      );
      if (file != null && await file.exists()) {
        var res = await file.readAsString();
        responseData = jsonDecode(res);
        print(responseData);
        return responseData;
      }
    } on SocketException {
      print('No internet connection');
    } catch (e) {
      // print("error imetokea");
      throw Exception('Failed to load post');
    }
    return null;
  }

  Future<List> getLocalNews() async {
    try {
      var file = await ApiProvider().getSingleFile(
        _baseUrl + "&categories=32",
        headers: {'Authorization': _key, 'Accept': _acceptance},
      );
      if (file != null && await file.exists()) {
        var res = await file.readAsString();
        responseData = jsonDecode(res);
        print(responseData);
        return responseData;
      }
    } on SocketException {
      print('No internet connection');
    } catch (e) {
      // print("error imetokea");
      throw Exception('Failed to load post');
    }
    return null;
  }

  Future<List> getInternationalNews() async {
    try {
      var file = await ApiProvider().getSingleFile(
        _baseUrl + "&categories=31",
        headers: {'Authorization': _key, 'Accept': _acceptance},
      );
      if (file != null && await file.exists()) {
        var res = await file.readAsString();
        responseData = jsonDecode(res);
        print(responseData);
        return responseData;
      }
    } on SocketException {
      print('No internet connection');
    } catch (e) {
      // print("error imetokea");
      throw Exception('Failed to load post');
    }
    return null;
  }

  Future<List> getMagazetiNews() async {
    try {
      var file = await ApiProvider().getSingleFile(
        _baseUrl + "&categories=34",
        headers: {'Authorization': _key, 'Accept': _acceptance},
      );
      if (file != null && await file.exists()) {
        var res = await file.readAsString();
        responseData = jsonDecode(res);
        print(responseData);
        return responseData;
      }
    } on SocketException {
      print('No internet connection');
    } catch (e) {
      // print("error imetokea");
      throw Exception('Failed to load post');
    }
    return null;
  }

  Future<List> getRegionNews() async {
    try {
      var file = await ApiProvider().getSingleFile(
        _baseUrl + "&categories=33",
        headers: {'Authorization': _key, 'Accept': _acceptance},
      );
      if (file != null && await file.exists()) {
        var res = await file.readAsString();
        responseData = jsonDecode(res);
        print(responseData);
        return responseData;
      }
    } on SocketException {
      print('No internet connection');
    } catch (e) {
      // print("error imetokea");
      throw Exception('Failed to load post');
    }
    return null;
  }

  Future<List> getMakalaNews() async {
    try {
      var file = await ApiProvider().getSingleFile(
        _baseUrl + "&categories=39",
        headers: {'Authorization': _key, 'Accept': _acceptance},
      );
      if (file != null && await file.exists()) {
        var res = await file.readAsString();
        responseData = jsonDecode(res);
        print(responseData);
        return responseData;
      }
    } on SocketException {
      print('No internet connection');
    } catch (e) {
      // print("error imetokea");
      throw Exception('Failed to load post');
    }
    return null;
  }
}
