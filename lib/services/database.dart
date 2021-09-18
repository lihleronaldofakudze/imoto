import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:imoto/models/Car.dart';

class DatabaseService {
  final String? uid;
  final String? carId;

  DatabaseService({this.uid, this.carId});

  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference _carsCollection =
      FirebaseFirestore.instance.collection('cars');

  Future setUserProfile(
      {required String image,
      required String username,
      required String email,
      required String address,
      required String number,
      required String type}) {
    return _usersCollection.doc(uid).set({
      'image': image,
      'username': username,
      'email': email,
      'address': address,
      'number': number,
      'type': type
    });
  }

  Future addCar({
    required List<String> images,
    required String model,
    required String brand,
    required String bodyType,
    required String condition,
    required String fuelType,
    required String engineType,
    required String drivenWheels,
    required String enginePosition,
    required double fuelCapacity,
    required double engineCapacity,
    required int topSpeed,
    required int seats,
    required int doors,
    required double price,
    required String comment,
  }) {
    return _carsCollection.add({
      'uid': uid,
      'images': images,
      'model': model,
      'brand': brand,
      'bodyType': bodyType,
      'condition': condition,
      'fuelType': fuelType,
      'engineType': engineType,
      'enginePosition': enginePosition,
      'drivenWheels': drivenWheels,
      'engineCapacity': engineCapacity,
      'fuelCapacity': fuelCapacity,
      'topSpeed': topSpeed,
      'seats': seats,
      'doors': doors,
      'price': price,
      'comment': comment,
      'postedAt': new DateTime.now(),
      'updatedAt': new DateTime.now(),
    });
  }

  List<Car> _carsFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Car(
        id: doc.id,
        uid: doc.get('uid'),
        model: doc.get('model'),
        brand: doc.get('brand'),
        fuelType: doc.get('fuelType'),
        numberOfSeats: doc.get('seats'),
        topSpeed: doc.get('topSpeed'),
        engineCapacity: doc.get('engineCapacity'),
        price: doc.get('price'),
        updatedAt: doc.get('updatedAt'),
        drivenWheels: doc.get('drivenWheels'),
        fuelCapacity: doc.get('fuelCapacity'),
        comment: doc.get('comment'),
        numberOfDoors: doc.get('doors'),
        condition: doc.get('condition'),
        engineType: doc.get('engineType'),
        bodyType: doc.get('bodyType'),
        postedAt: doc.get('postedAt'),
        enginePositions: doc.get('enginePosition'),
        images: doc.get('images'),
      );
    }).toList();
  }

  Car _carFromSnapshot(DocumentSnapshot snapshot) {
    return Car(
      id: snapshot.id,
      uid: snapshot.get('uid'),
      model: snapshot.get('model'),
      brand: snapshot.get('brand'),
      fuelType: snapshot.get('fuelType'),
      numberOfSeats: snapshot.get('seats'),
      topSpeed: snapshot.get('topSpeed'),
      engineCapacity: snapshot.get('engineCapacity'),
      price: snapshot.get('price'),
      updatedAt: snapshot.get('updatedAt'),
      drivenWheels: snapshot.get('drivenWheels'),
      fuelCapacity: snapshot.get('fuelCapacity'),
      comment: snapshot.get('comment'),
      numberOfDoors: snapshot.get('doors'),
      condition: snapshot.get('condition'),
      engineType: snapshot.get('engineType'),
      bodyType: snapshot.get('bodyType'),
      postedAt: snapshot.get('postedAt'),
      enginePositions: snapshot.get('enginePosition'),
      images: snapshot.get('images'),
    );
  }

  Stream<List<Car>> get cars {
    return _carsCollection
        .orderBy('postedAt', descending: true)
        .snapshots()
        .map(_carsFromSnapshot);
  }

  Stream<Car> get car {
    return _carsCollection.doc(carId).snapshots().map(_carFromSnapshot);
  }
}
