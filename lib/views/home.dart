import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('API Example'),
        ),
        body: Center(
          child: FutureBuilder(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                // Display fetched data
                return Text('${snapshot.data}');
              }
            },
          ),
        ),
      ),
    );
  }

  Future<String> fetchData() async {
    String url =
        'https://api.openweathermap.org/data/2.5/weather?lat=10.5&lon=56.0&appid=ac0797a458f376e58b5fcf709618283f';

    // Define your API key
    String apiKey = 'ac0797a458f376e58b5fcf709618283f';
    final response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
    });

    // Check if the request was successful (status code 200)
    if (response.statusCode == 200) {
      // Parse the JSON response
      Map<String, dynamic> data = json.decode(response.body);
      // Return the JSON data
      return data.toString();
    } else {
      // If the request was not successful, throw an error
      throw Exception('Failed to load data');
    }
  }
}
