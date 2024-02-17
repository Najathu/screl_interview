import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:svg_flutter/svg.dart';

class WeatherWidget extends StatefulWidget {
  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  String _location = '';
  String _temperature = '';
  String _weatherCondition = '';
  bool _loading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  Future<void> _fetchWeatherData() async {
    setState(() {
      _loading = true;
      _errorMessage = '';
    });

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      String url =
          'https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=ac0797a458f376e58b5fcf709618283f';
      http.Response response = await http.get(Uri.parse(url));
      Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        _location = '${data['name']}, ${data['sys']['country']}';
        _temperature = '${data['main']['temp']}°C';
        _weatherCondition = data['weather'][0]['main'];
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error fetching weather data';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _loading
            ? CircularProgressIndicator()
            : Column(
                children: <Widget>[
                  SvgPicture.asset(
                    'assets/weather_icons/day.svg',
                    width: 300,
                    height: 300,
                  ),
                  SizedBox(height: 10),
                  Text(
                    _location,
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Text(
                    _temperature,
                    style: TextStyle(fontSize: 30),
                  ),
                ],
              ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () => _fetchWeatherData(),
          child: Text('Refresh'),
        ),
        SizedBox(height: 10),
        Text(
          _errorMessage,
          style: TextStyle(color: Colors.red),
        ),
      ],
    );
  }
}
