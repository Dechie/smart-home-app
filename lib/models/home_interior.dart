import 'package:flutter/material.dart';

String assetz = 'assets/images';

class HomeInterior {
  final String title, image;
  String? humidifier, airPurifier;
  bool? boolHumidifier, boolAirPurifier;
  bool? boolSubLight, boolMainLight;

  HomeInterior({
    required this.title,
    required this.image,
    this.humidifier,
    this.airPurifier,
    this.boolAirPurifier,
    this.boolHumidifier,
    this.boolSubLight,
    this.boolMainLight,
  });
}

List demoHomeInterior = [
  HomeInterior(
    title: 'Living Room',
    image: '$assetz/livingRoom.jpg',
    humidifier: '50%',
    airPurifier: 'true%',
    boolAirPurifier: true,
    boolHumidifier: false,
    boolSubLight: true,
    boolMainLight: false,
  ),
  HomeInterior(
    title: 'Bedroom',
    image: '$assetz/bedroom.jpg',
    humidifier: '87%',
    airPurifier: '52%',
    boolAirPurifier: true,
    boolHumidifier: true,
    boolSubLight: true,
    boolMainLight: false,
  ),
  HomeInterior(
    title: 'Kitchen',
    image: '$assetz/kitchen.jpg',
    humidifier: '80%',
    airPurifier: 'false%',
    boolAirPurifier: true,
    boolHumidifier: false,
    boolSubLight: false,
    boolMainLight: true,
  ),
];
