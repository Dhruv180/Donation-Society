import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class FoodBank {
  final String name;
  final String address;
  final LatLng locationCoords;
  final Widget image;
  final String no;

  FoodBank({
    required this.name,
    required this.address,
    required this.locationCoords,
    required this.image,
    required this.no,
  });
}

final List<FoodBank> centerNames = [
  FoodBank(
    address: 'Noida center',
    name: 'Noida_FoodBank',
    no: '9012345678',
    locationCoords: LatLng(28.5355, 77.3910),
    image: Image(
      image: AssetImage('images/ce2.jpg'),
      width: 80.0,
    ),
  ),
  FoodBank(
    address: 'Bangaluru Center',
    name: 'Bangaluru_FoodBank',
    no: '1234567890',
    locationCoords: LatLng(12.9716, 77.5946),
    image: Image(
      image: AssetImage('images/ce9.png'),
      width: 70.0,
      height: 120.0,
    ),
  ),
  FoodBank(
    address: 'Ahmedabad Center',
    name: 'Ahmedabad_FoodBank',
    no: '7812345678',
    locationCoords: LatLng(23.0225, 72.5714),
    image: Image(
      image: AssetImage('images/ce10.jpg'),
      width: 80.0,
    ),
  ),
  FoodBank(
    address: 'Mumbai Center',
    name: 'Mumbai_FoodBank',
    no: '6789123478',
    locationCoords: LatLng(19.0760, 72.8777),
    image: Image(
      image: AssetImage('images/ce4.jpg'),
      width: 80.0,
    ),
  ),
  FoodBank(
    address: 'Hyderabad Center',
    name: 'Hyderabad_FoodBank',
    no: '5643217890',
    locationCoords: LatLng(17.3850, 78.4867),
    image: Image(
      image: AssetImage('images/ce6.png'),
      width: 80.0,
    ),
  ),
  FoodBank(
    address: 'Kolkata Center',
    name: 'kolkata_FoodBank',
    no: '9045673211',
    locationCoords: LatLng(22.5726, 88.3639),
    image: Image(
      image: AssetImage('images/ce7.jpg'),
      width: 80.0,
    ),
  ),
  FoodBank(
    address: 'Chennai Center',
    name: 'Chennai_FoodBank',
    no: '6754322299',
    locationCoords: LatLng(13.0827, 80.2707),
    image: Image(
      image: AssetImage('images/ce8.jpg'),
      width: 80.0,
    ),
  ),
];
