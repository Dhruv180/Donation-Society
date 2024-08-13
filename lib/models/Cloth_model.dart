import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Define a class Example to represent a clothing center
class Example {
  String name;
  String address;
  LatLng locationCoords;
  Widget image;
  String no;

  // Constructor to initialize the properties
  Example({
    required this.name,
    required this.address,
    required this.locationCoords,
    required this.image,
    required this.no,
  });
}

// List of Example objects representing clothing centers
List<Example> exnames = [
  Example(
    name: 'Dharamshala Centre',
    address: 'Dharamshala, India',
    no: '781xxxxxx',
    locationCoords: LatLng(32.219042, 76.323404), // Example coordinates (replace with actual)
    image: Image.asset('images/a1.jpg', width: 80.0),
  ),
  Example(
    name: 'Mumbai Center',
    address: 'Mumbai, India',
    no: '6789123478',
    locationCoords: LatLng(19.0760, 72.8777),
    image: Image.asset('images/a2.jpg', width: 80.0),
  ),
  Example(
    name: 'Delhi center',
    address: 'Delhi, India',
    no: '9012345678',
    locationCoords: LatLng(28.7041, 77.1025),
    image: Image.asset('images/a3.jpg', width: 80.0),
  ),
  Example(
    name: 'Bangaluru Center',
    address: 'Bangalore, India',
    no: '1234567890',
    locationCoords: LatLng(12.9716, 77.5946),
    image: Image.asset('images/a4.jpg', width: 80.0),
  ),
  Example(
    name: 'Hyderabad Center',
    address: 'Hyderabad, India',
    no: '5643217890',
    locationCoords: LatLng(17.3850, 78.4867),
    image: Image.asset('images/a5.jpg', width: 80.0),
  ),
  Example(
    name: 'Kolkata Center',
    address: 'Kolkata, India',
    no: '9045673211',
    locationCoords: LatLng(22.5726, 88.3639),
    image: Image.asset('images/a6.jpg', width: 80.0),
  ),
  Example(
    name: 'Chennai Center',
    address: 'Chennai, India',
    no: '6754322299',
    locationCoords: LatLng(13.0827, 80.2707),
    image: Image.asset('images/a7.jpg', width: 80.0),
  ),
];

// Function to add a new Example to the exnames list
void addNewExample(String name, String address, String no, LatLng locationCoords, String imagePath) {
  Example newExample = Example(
    name: name,
    address: address,
    no: no,
    locationCoords: locationCoords,
    image: Image.asset(imagePath, width: 80.0),
  );
  exnames.add(newExample);
}

// Function to filter exnames based on search query
List<Example> searchExamples(String query) {
  return exnames.where((example) => example.name.toLowerCase().contains(query.toLowerCase())).toList();
}
