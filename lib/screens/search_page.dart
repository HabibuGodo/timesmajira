import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:timesmajira/screens/homescreen.dart';
import 'package:timesmajira/screens/soma_zaid.dart';
import 'package:timesmajira/services/backendServices.dart';
import 'package:timesmajira/utility/fadetransation.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _typeAheadController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _typeAheadController.clear();
  }

  @override
  Widget build(BuildContext context) {
    _typeAheadController.clear();
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          
          image: DecorationImage(
            fit: BoxFit.fill,
            alignment: Alignment.centerRight,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.1), BlendMode.dstATop),
            image: AssetImage("assets/logo/logo_old.jpg"),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 70.0),
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: 0.5,
                color: Colors.grey,
              ),
              Container(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: // SizedBox(height: 3),
                      TypeAheadField(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: _typeAheadController,
                      autofocus: false,
                      style: TextStyle(color: Colors.black, fontSize: 24),
                      decoration: InputDecoration.collapsed(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        hintText: '  Search',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                    ),
                    suggestionsCallback: (pattern) async {
                      try {
                        return await BackendServices.getSuggestions(pattern);
                      } catch (e) {
                        throw "Something went wrong.";
                      }
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        // leading: suggestion !=
                        //         null
                        //     ? Image.network(
                        //         'https://image.tmdb.org/t/p/w185//${suggestion.poster_path}')
                        //     : Image.network(
                        //         'https://www.google.com/imgres?imgurl=https%3A%2F%2Fcdn.domestika.org%2Fraw%2Fupload%2Fassets%2Fprojects%2Fproject-default-cover-1248c9d991d3ef88af5464656840f5534df2ae815032af0fdf39562fee08f0a6.svg&imgrefurl=https%3A%2F%2Fwww.domestika.org%2Fen%2Fschools%2F12923-alberta-university-of-the-arts&tbnid=iO_TkdnJSBLLpM&vet=12ahUKEwja-_SSxuroAhUC-4UKHQBQDX0QMygUegQIARAr..i&docid=ca4YMtCI22hjfM&w=211&h=211&itg=1&q=no%20cover&ved=2ahUKEwja-_SSxuroAhUC-4UKHQBQDX0QMygUegQIARAr'),
                        title: Text(suggestion['title']['rendered'].toString()),
                        subtitle: Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          height: 0.5,
                          color: Colors.grey,
                        ),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      Navigator.of(context).push(MaterialPageRoute(
                        // ignore: missing_required_param
                        builder: (context) => SomaZaidi(
                          postData: suggestion,
                        ),
                      ));
                    },
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: 0.5,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.black,
        backgroundColor: Colors.white,
        buttonBackgroundColor: Colors.black,
        height: 45,
        items: <Widget>[
          Icon(Icons.arrow_back_ios, size: 20, color: Colors.orange),
          Icon(Icons.home, size: 20, color: Colors.orange),
          Icon(Icons.search, size: 20, color: Colors.orange),
        ],
        index: 2,
        animationDuration: Duration(milliseconds: 200),
        animationCurve: Curves.bounceInOut,
        onTap: (index) {
          if (index == 0) {
            Navigator.pop(context);
          } else if (index == 1) {
            Navigator.push(
              context,
              MyCustomRoute(
                builder: (context) => HomeScreen(),
              ),
            );
          } else {}
        },
      ),
    );
  }
}
