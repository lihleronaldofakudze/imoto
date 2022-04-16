import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:imoto/constants.dart';
import 'package:imoto/models/CurrentUser.dart';
import 'package:imoto/services/database.dart';
import 'package:imoto/widgets/loading_widget.dart';
import 'package:imoto/widgets/picked_images_widget.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class AddCarScreen extends StatefulWidget {
  const AddCarScreen({Key? key}) : super(key: key);

  @override
  _AddCarScreenState createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
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
        ? const LoadingWidget()
        : Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              title: const Text(
                'Add New Car',
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  images.isEmpty
                      ? Container(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                _tenImages,
                                style: const TextStyle(color: Colors.red),
                              ),
                            ),
                          ),
                        )
                      : PickedImagesWidget(
                          images: images,
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: images.isEmpty
                                ? Colors.deepOrange
                                : Colors.red),
                        onPressed: () => _pickImages(),
                        child: Text(
                          images.isEmpty
                              ? 'Choose 10 Pictures'
                              : 'Change Pictures',
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    maxLength: 16,
                    decoration: const InputDecoration(
                        labelText: 'Car Model', border: OutlineInputBorder()),
                    controller: _modelController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                        labelText: 'Car Brand', border: OutlineInputBorder()),
                    items: Constants().carBrands.map((brand) {
                      return DropdownMenuItem(value: brand, child: Text(brand));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _brand = value.toString();
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                        labelText: 'Car Body Type',
                        border: OutlineInputBorder()),
                    items: Constants().bodyTypes.map((type) {
                      return DropdownMenuItem(value: type, child: Text(type));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _bodyType = value.toString();
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                        labelText: 'Car Condition',
                        border: OutlineInputBorder()),
                    items: Constants().conditions.map((condition) {
                      return DropdownMenuItem(
                          value: condition, child: Text(condition));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _condition = value.toString();
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                        labelText: 'Car Fuel Type',
                        border: OutlineInputBorder()),
                    items: Constants().fuelTypes.map((fuel) {
                      return DropdownMenuItem(value: fuel, child: Text(fuel));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _fuelType = value.toString();
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                        labelText: 'Car Engine Type',
                        border: OutlineInputBorder()),
                    items: Constants().engineTypes.map((engine) {
                      return DropdownMenuItem(
                          value: engine, child: Text(engine));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _engineType = value.toString();
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                        labelText: 'Car Driven Wheels',
                        border: OutlineInputBorder()),
                    items: Constants().drivenWheels.map((driven) {
                      return DropdownMenuItem(
                          value: driven, child: Text(driven));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _driven = value.toString();
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                        labelText: 'Car Engine Positions',
                        border: OutlineInputBorder()),
                    items: Constants().enginePositions.map((position) {
                      return DropdownMenuItem(
                          value: position, child: Text(position));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _enginePosition = value.toString();
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                        labelText: 'Car Fuel Capacity',
                        border: OutlineInputBorder()),
                    controller: _fuelCapacityController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                        labelText: 'Car Engine Capacity',
                        border: OutlineInputBorder()),
                    controller: _engineCapacityController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: 'Top Speed', border: OutlineInputBorder()),
                    controller: _topSpeedController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: 'NO of Seats', border: OutlineInputBorder()),
                    controller: _seatsController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: 'NO of Doors', border: OutlineInputBorder()),
                    controller: _doorsController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: 'Car Price', border: OutlineInputBorder()),
                    controller: _priceController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    maxLines: 4,
                    textAlign: TextAlign.start,
                    decoration: const InputDecoration(
                        labelText: 'Seller Comments',
                        border: OutlineInputBorder()),
                    controller: _commentsController,
                  ),
                  const SizedBox(
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
                          if (images.isNotEmpty &&
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
                                    .showSnackBar(const SnackBar(
                                  content: Text('Car Added Successful'),
                                ));
                                Navigator.pop(context);
                              });
                            });
                          } else {
                            setState(() {
                              _loading = false;
                            });
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.ERROR,
                              animType: AnimType.BOTTOMSLIDE,
                              title: 'Error',
                              desc: 'Please fill all the fields',
                              btnOkOnPress: () {},
                            ).show();
                          }
                        },
                        child: const Text(
                          'Sell Your Car',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          );
  }
}
