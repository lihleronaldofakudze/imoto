import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:imoto/models/Car.dart';
import 'package:imoto/models/Garage.dart';
import 'package:imoto/models/Part.dart';

class DatabaseService {
  final String? uid;
  final String? carId;
  final String? category;
  final String? partId;

  DatabaseService({this.uid, this.carId, this.category, this.partId});

  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference _carsCollection =
      FirebaseFirestore.instance.collection('cars');

  final CollectionReference _partsCollection =
      FirebaseFirestore.instance.collection('parts');

  Future setUserProfile({
    required String image,
    required String username,
    required String email,
    required String address,
    required String number,
    required String type,
    required int cars,
    required int parts,
  }) {
    return _usersCollection.doc(uid).set({
      'image': image,
      'username': username,
      'email': email,
      'address': address,
      'number': number,
      'type': type,
      'cars': cars,
      'parts': parts
    });
  }

  Garage _garageFromSnapshot(DocumentSnapshot snapshot) {
    return Garage(
        id: snapshot.id,
        image: snapshot.get('image'),
        username: snapshot.get('username'),
        email: snapshot.get('email'),
        number: snapshot.get('number'),
        address: snapshot.get('address'),
        type: snapshot.get('type'),
        cars: snapshot.get('cars'),
        parts: snapshot.get('parts'));
  }

  List<Garage> _garagesFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Garage(
          id: doc.id,
          image: doc.get('image'),
          username: doc.get('username'),
          email: doc.get('email'),
          number: doc.get('number'),
          address: doc.get('address'),
          type: doc.get('type'),
          cars: doc.get('cars'),
          parts: doc.get('parts'));
    }).toList();
  }

  Stream<Garage> get garage {
    return _usersCollection.doc(uid).snapshots().map(_garageFromSnapshot);
  }

  Stream<List<Garage>> get garages {
    return _usersCollection
        .where('type', isEqualTo: 'Company')
        .snapshots()
        .map(_garagesFromSnapshot);
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
    }).then((value) {
      return _usersCollection
          .doc(uid)
          .update({'cars': FieldValue.increment(1)});
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

  Stream<List<Car>> get garageCars {
    return _carsCollection
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map(_carsFromSnapshot);
  }

  Stream<List<Car>> get bodyTpe {
    return _carsCollection
        .where('bodyType', isEqualTo: category)
        .snapshots()
        .map(_carsFromSnapshot);
  }

  Future deleteCar() {
    return _carsCollection.doc(carId).delete().then((value) {
      return _usersCollection
          .doc(uid)
          .update({'cars': FieldValue.increment(-1)});
    });
  }

  Future addPart(
      {required List<String> images,
      required String brand,
      required String part,
      required String condition,
      required double price}) {
    return _partsCollection.add({
      'uid': uid,
      'images': images,
      'brand': brand,
      'part': part,
      'price': price,
      'condition': condition
    }).then((value) {
      return _usersCollection
          .doc(uid)
          .update({'parts': FieldValue.increment(1)});
    });
  }

  Part _partFromSnapshot(DocumentSnapshot snapshot) {
    return Part(
        id: snapshot.id,
        condition: snapshot.get('condition'),
        part: snapshot.get('part'),
        brand: snapshot.get('brand'),
        price: snapshot.get('price'),
        uid: snapshot.get('uid'),
        images: snapshot.get('images'));
  }

  List<Part> _partsFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Part(
          id: doc.id,
          uid: doc.get('uid'),
          brand: doc.get('brand'),
          part: doc.get('part'),
          price: doc.get('price'),
          condition: doc.get('condition'),
          images: doc.get('images'));
    }).toList();
  }

  Stream<Part> get part {
    return _partsCollection.doc(partId).snapshots().map(_partFromSnapshot);
  }

  Stream<List<Part>> get parts {
    return _partsCollection.snapshots().map(_partsFromSnapshot);
  }

  Stream<List<Part>> get garageParts {
    return _partsCollection
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map(_partsFromSnapshot);
  }

  Future deletePart() {
    return _partsCollection.doc(partId).delete().then((value) {
      return _usersCollection
          .doc(uid)
          .update({'parts': FieldValue.increment(-1)});
    });
  }
}
