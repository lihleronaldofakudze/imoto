import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:imoto/models/CurrentUser.dart';
import 'package:imoto/services/database.dart';
import 'package:imoto/widgets/loading_widget.dart';
import 'package:imoto/widgets/picked_images_widget.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class AddPartScreen extends StatefulWidget {
  const AddPartScreen({Key? key}) : super(key: key);

  @override
  _AddPartScreenState createState() => _AddPartScreenState();
}

class _AddPartScreenState extends State<AddPartScreen> {
  List<File> images = [];
  String _threeImages = 'No Images Selected';
  final _brandController = TextEditingController();
  final _partController = TextEditingController();
  final _priceController = TextEditingController();
  final _conditions = ['New', 'Used'];
  bool _loading = false;
  String _condition = '';

  _pickImages() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true, type: FileType.image, allowCompression: true);

    if (result!.files.length > 3) {
      setState(() {
        _threeImages = 'Only 3 Images Allowed';
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
        FirebaseStorage.instance.ref().child('parts/${basename(_image.path)}');
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
                'Sell Part',
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  images.isEmpty
                      ? Container(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                _threeImages,
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
                            primary:
                                images.isEmpty ? Colors.orange : Colors.red),
                        onPressed: () => _pickImages(),
                        child: Text(
                          images.isEmpty
                              ? 'Choose 3 Pictures'
                              : 'Change Pictures',
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                        labelText: 'Car Brand & Model Name',
                        border: OutlineInputBorder()),
                    controller: _brandController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                        labelText: 'Car Part Name',
                        border: OutlineInputBorder()),
                    controller: _partController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
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
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                        labelText: 'Part Price', border: OutlineInputBorder()),
                    controller: _priceController,
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
                              _brandController.text.isNotEmpty &&
                              _partController.text.isNotEmpty &&
                              _condition.isNotEmpty &&
                              _priceController.text.isNotEmpty) {
                            await uploadFiles(images).then((value) async {
                              await DatabaseService(uid: currentUser!.uid)
                                  .addPart(
                                      images: value,
                                      brand: _brandController.text,
                                      part: _partController.text,
                                      condition: _condition,
                                      price:
                                          double.parse(_priceController.text))
                                  .then((value) {
                                setState(() {
                                  _loading = false;
                                });
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('Car Part Added Successful'),
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
                          'Sell Your Car Part',
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
