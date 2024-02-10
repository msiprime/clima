import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../services/location.dart';
import '../utilities/constants.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late double latitude;
  late double longitude;
  late String date;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  Future<void> getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    latitude = location.latitude;
    longitude = location.longitude;
    date = getCurrentDateFormatted();
    getApiData();
  }

  String getCurrentDateFormatted() {
    final now = DateTime.now();
    final year = now.year;
    final month = now.month.toString().padLeft(2, '0');
    final day = now.day.toString().padLeft(2, '0');
    final formattedDate = '$year-$month-$day';
    return formattedDate;
  }

  void getApiData() async {
    String url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&date=$date&appid=$apiKey';
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;

        var temperature = jsonResponse['main']['temp'];
        var condition = jsonResponse['weather'][0]['id'];
        var city = jsonResponse['name'];
        print(city);
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (error) {
      print('Error making API request: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: const Text('Get Location'),
        ),
      ),
    );
  }
}
