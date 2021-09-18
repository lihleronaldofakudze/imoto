import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:imoto/models/CurrentUser.dart';
import 'package:imoto/services/database.dart';
import 'package:imoto/widgets/loading.dart';
import 'package:imoto/widgets/okAlertDialog.dart';
import 'package:imoto/widgets/picked_images_widget.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class AddCarScreen extends StatefulWidget {
  const AddCarScreen({Key? key}) : super(key: key);

  @override
  _AddCarScreenState createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  final _carBrands = [
    'Abarth',
    'Alfa Romeo',
    'Aston Martin',
    'Audi',
    'BMW',
    'Bentley',
    'Cadillac',
    'CAM',
    'Chana',
    'Chevrolet',
    'Chery',
    'Chrysler',
    'CMC',
    'Citroen',
    'Mitsubishi',
    'Dacia',
    'Daewoo',
    'Daihatsu',
    'Daimler',
    'DFSK',
    'Dodge',
    'FAW',
    'Ferrari',
    'Fiant',
    'Foton',
    'Ford',
    'GoNow',
    'Geely',
    'GWM',
    'Honda',
    'Honda',
    'Hyundai',
    'Hummer',
    'Infiniti',
    'Isuzu',
    'Iveco',
    'Jaguar',
    'Jeep',
    'JMC',
    'Lamborghini',
    'Kia',
    'Lancia',
    'Land Rover',
    'LDV',
    'Lexus',
    'Lotus',
    'Maserati',
    'Mahindra',
    'Maybach',
    'Mazda',
    'Mercedes-Benz',
    'Mercedes-AMG',
    'Meiya',
    'MG',
    'MINI',
    'Nissan',
    'Noble',
    'Opel',
    'Peugeot',
    'Porsche',
    'Proton',
    'Renault',
    'Rover',
    'Maxus',
    'Saic',
    'Saab',
    'SEAT',
    'Smart',
    'SsangYong',
    'Subaru',
    'Suzuki',
    'Tata',
    'Toyota',
    'TVR',
    'Volkswagen',
    'Volvo',
    'ZX Auto',
    'McLaren',
    'Rolls-Royce',
    'Changan',
    'Datsun',
    'Mercedes-Maybach',
    'Truimph',
    'AMC Rambler',
    'Austin',
    'Buick',
    'DKW',
    'Hillman',
    'KCC',
    'Lynx',
    'MGA',
    'MGB',
    'Morris',
    'Pontiac',
    'Range Rover',
    'Valiant',
    'Vauxhall',
    'Willys Jeep',
    'Morgan',
    'Birkin',
    'Golden Journey',
    'Sunbeam',
    'Backdraft',
    'KTM',
    'London',
    'AC',
    'Jinbei',
    'BAW',
    'Willys',
    'Austin-Healey',
    'Ariel',
    'BAIC',
    'Oldsmobile',
    'Haval',
    'JAC',
    'Packard',
    'Puma',
    'Secma',
    'De Tomaso',
    'Lola',
    'Leyland',
    'GMC',
    'Jensen',
    'Plymouth',
    'DAF',
    'Pagani',
    'Bajaj',
    'HUMBER',
    'Shelby',
    'Asia',
    'Nash',
    'Caterham',
    'Millennium',
    'Goggomobil'
  ];
  final _bodyTypes = [
    'Cabriolet',
    'Coupe',
    'Crew Bus',
    'Double Cab',
    'Extended Cab',
    'Fastback',
    'Hatchback',
    'King Cab',
    'LCV',
    'Minibus',
    'MPV',
    'Panel Van',
    'Sedan',
    'Single Cab',
    'Sportback',
    'Station Wagon',
    'Supercab',
    'SUV'
  ];
  final _conditions = ['New', 'Used'];
  final _engineTypes = ['Automatic', 'Manual'];
  final _drivenWheels = ['Front', 'Back', 'Both'];
  final _enginePositions = ['Front', 'Back'];
  final _fuelTypes = ['Petrol', 'Diesel'];

  //Changing Variables
  List<File> images = [];
  bool _loading = false;
  String _tenImages = 'No Images Selected';
  final _modelController = TextEditingController();
  final _fuelCapacityController = TextEditingController();
  final _engineCapacityController = TextEditingController();
  final _topSpeedController = TextEditingController();
  final _seatsController = TextEditingController();
  final _doorsController = TextEditingController();
  final _priceController = TextEditingController();
  final _commentsController = TextEditingController();
  String _brand = '';
  String _bodyType = '';
  String _condition = '';
  String _fuelType = '';
  String _engineType = '';
  String _driven = '';
  String _enginePosition = '';

  _pickImages() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true, type: FileType.image, allowCompression: true);

    if (result!.files.length > 10) {
      setState(() {
        _tenImages = 'Only Ten Images Allowed';
        images = [];
      });
    } else {
      setState(() {
        images = result.paths.map((path) => File(path!)).toList();
      });
    }
  }

  Future<List<String>> uploadFiles(List<File> _images) async {
    var imageUrls =
        await Future.wait(_images.map((_image) => uploadFile(_image)));
    return imageUrls;
  }

  Future<String> uploadFile(File _image) async {
    Reference storageReference =
        FirebaseStorage.instance.ref().child('imoto/${basename(_image.path)}');
    UploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.whenComplete(() => null);

    return await storageReference.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<CurrentUser?>(context);
    return _loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              title: Text(
                'Add New Car',
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  images.length == 0
                      ? Container(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                _tenImages,
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ),
                        )
                      : PickedImagesWidget(
                          images: images,
                        ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: images.length == 0
                                ? Colors.orange
                                : Colors.red),
                        onPressed: () => _pickImages(),
                        child: Text(
                          images.length == 0
                              ? 'Choose 10 Pictures'
                              : 'Change Pictures',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'Car Model', border: OutlineInputBorder()),
                    controller: _modelController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                        labelText: 'Car Brand', border: OutlineInputBorder()),
                    items: _carBrands.map((brand) {
                      return DropdownMenuItem(value: brand, child: Text(brand));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _brand = value.toString();
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                        labelText: 'Car Body Type',
                        border: OutlineInputBorder()),
                    items: _bodyTypes.map((type) {
                      return DropdownMenuItem(value: type, child: Text(type));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _bodyType = value.toString();
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                        labelText: 'Car Condition',
                        border: OutlineInputBorder()),
                    items: _conditions.map((condition) {
                      return DropdownMenuItem(
                          value: condition, child: Text(condition));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _condition = value.toString();
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                        labelText: 'Car Fuel Type',
                        border: OutlineInputBorder()),
                    items: _fuelTypes.map((fuel) {
                      return DropdownMenuItem(value: fuel, child: Text(fuel));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _fuelType = value.toString();
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                        labelText: 'Car Engine Type',
                        border: OutlineInputBorder()),
                    items: _engineTypes.map((engine) {
                      return DropdownMenuItem(
                          value: engine, child: Text(engine));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _engineType = value.toString();
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                        labelText: 'Car Driven Wheels',
                        border: OutlineInputBorder()),
                    items: _drivenWheels.map((driven) {
                      return DropdownMenuItem(
                          value: driven, child: Text(driven));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _driven = value.toString();
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                        labelText: 'Car Engine Positions',
                        border: OutlineInputBorder()),
                    items: _enginePositions.map((position) {
                      return DropdownMenuItem(
                          value: position, child: Text(position));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _enginePosition = value.toString();
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                        labelText: 'Car Fuel Capacity',
                        border: OutlineInputBorder()),
                    controller: _fuelCapacityController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                        labelText: 'Car Engine Capacity',
                        border: OutlineInputBorder()),
                    controller: _engineCapacityController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Top Speed', border: OutlineInputBorder()),
                    controller: _topSpeedController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'NO of Seats', border: OutlineInputBorder()),
                    controller: _seatsController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'NO of Doors', border: OutlineInputBorder()),
                    controller: _doorsController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Car Price', border: OutlineInputBorder()),
                    controller: _priceController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    maxLines: 4,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                        labelText: 'Seller Comments',
                        border: OutlineInputBorder()),
                    controller: _commentsController,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            _loading = true;
                          });
                          if (images.length != 0 &&
                              _modelController.text.isNotEmpty &&
                              _brand.isNotEmpty &&
                              _bodyType.isNotEmpty &&
                              _condition.isNotEmpty &&
                              _fuelType.isNotEmpty & _engineType.isNotEmpty &&
                              _driven.isNotEmpty &&
                              _enginePosition.isNotEmpty &&
                              _fuelCapacityController.text.isNotEmpty &&
                              _engineCapacityController.text.isNotEmpty &&
                              _topSpeedController.text.isNotEmpty &&
                              _seatsController.text.isNotEmpty &&
                              _doorsController.text.isNotEmpty &&
                              _priceController.text.isNotEmpty &&
                              _commentsController.text.isNotEmpty) {
                            await uploadFiles(images).then((value) async {
                              await DatabaseService(uid: currentUser!.uid)
                                  .addCar(
                                      images: value,
                                      model: _modelController.text,
                                      brand: _brand,
                                      bodyType: _bodyType,
                                      condition: _condition,
                                      fuelType: _fuelType,
                                      engineType: _engineType,
                                      drivenWheels: _driven,
                                      enginePosition: _enginePosition,
                                      engineCapacity: double.parse(
                                          _engineCapacityController.text),
                                      fuelCapacity: double.parse(
                                          _fuelCapacityController.text),
                                      topSpeed:
                                          int.parse(_topSpeedController.text),
                                      seats: int.parse(_seatsController.text),
                                      doors: int.parse(_doorsController.text),
                                      price:
                                          double.parse(_priceController.text),
                                      comment: _commentsController.text)
                                  .then((value) {
                                setState(() {
                                  _loading = false;
                                });
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(new SnackBar(
                                  content: Text('Car Added Successful'),
                                ));
                                Navigator.pop(context);
                              });
                            });
                          } else {
                            setState(() {
                              _loading = false;
                            });
                            showDialog(
                                context: context,
                                builder: (_) => okAlertDialog(
                                    context: context,
                                    message:
                                        'Please enter all required car details'));
                          }
                        },
                        child: Text(
                          'Sell Your Car',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          );
  }
}
