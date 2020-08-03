import 'dart:convert';
import 'package:http/http.dart' as http;

class BackendServices {
  static final String _key = 'Basic Ym1sYXRhOkN1ZGRsZXoyMDE5Lg==';
  static final String _acceptance = 'application/json';

  static Future<List> getSuggestions(String query) async {
    //List<ItemModel> myList = List<ItemModel>();
    try {
      if (query.length == 0) {
        return null;
      }
      final response = await http.get(
        'http://timesmajira.co.tz/wp-json/wp/v2/posts?filter[s]=$query&_embed&per_page=50',
        headers: {'Authorization': _key, 'Accept': _acceptance},
      );

      if (response.statusCode == 200) {
        //print(response.body);
        var responseData = jsonDecode(response.body);
        //ItemModel mymodel = ItemModel.fromJson(json.decode(response.body), false);
        return responseData;
      }
    } catch (e) {
      // print("error imetokea");
      throw Exception('Failed to load post');
    }
    return null;
  }


}
