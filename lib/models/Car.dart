import 'package:cloud_firestore/cloud_firestore.dart';

class Car {
  final String id;
  final String uid;
  final List images;
  final String model;
  final String brand;
  final String bodyType;
  final String condition;
  final String fuelType;
  final String engineType;
  final String drivenWheels;
  final String enginePositions;
  final double engineCapacity;
  final double fuelCapacity;
  final int topSpeed;
  final int numberOfSeats;
  final int numberOfDoors;
  final double price;
  final String comment;
  final Timestamp postedAt;
  final Timestamp updatedAt;

  Car(
      {required this.id,
      required this.uid,
      required this.images,
      required this.model,
      required this.brand,
      required this.bodyType,
      required this.condition,
      required this.fuelCapacity,
      required this.price,
      required this.comment,
      required this.drivenWheels,
      required this.engineCapacity,
      required this.enginePositions,
      required this.engineType,
      required this.fuelType,
      required this.numberOfDoors,
      required this.numberOfSeats,
      required this.topSpeed,
      required this.postedAt,
      required this.updatedAt});
}
