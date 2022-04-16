import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:imoto/models/CurrentUser.dart';
import 'package:imoto/models/Garage.dart';
import 'package:imoto/services/database.dart';
import 'package:imoto/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _usernameController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final _numberController = TextEditingController();
  String _type = '';
  bool _loading = false;

  File _image = File('');

  _pickImages() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowCompression: true);

    if (result!.files.length > 10) {
      setState(() {
        _image = File('');
      });
    } else {
      setState(() {
        _image = File(result.files.single.path!);
        ;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<CurrentUser?>(context);
    return StreamBuilder<Garage>(
      stream: DatabaseService(uid: currentUser!.uid).garage,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Garage? garage = snapshot.data;
          _usernameController.text = garage!.username;
          _addressController.text = garage.address;
          _emailController.text = garage.email;
          _numberController.text = garage.number;
          return _loading
              ? LoadingWidget()
              : Scaffold(
                  appBar: AppBar(
                    iconTheme: IconThemeData(color: Colors.white),
                    title: Text(
                      'Edit Profile',
                      style: TextStyle(color: Colors.white),
                    ),
                    centerTitle: true,
                  ),
                  body: SingleChildScrollView(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text('Select Image'),
                          trailing: IconButton(
                              onPressed: () => _pickImages(),
                              icon: FaIcon(FontAwesomeIcons.camera)),
                        ),
                        _image.path == ''
                            ? Container(
                                height: 200,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    image: DecorationImage(
                                        image: NetworkImage(garage.image),
                                        fit: BoxFit.cover)),
                              )
                            : Container(
                                height: 200,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    image: DecorationImage(
                                        image: FileImage(File(_image.path)),
                                        fit: BoxFit.cover)),
                              ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          decoration: InputDecoration(
                              labelText: 'Username / Company Name',
                              border: OutlineInputBorder()),
                          controller: _usernameController,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          decoration: InputDecoration(
                              labelText: 'Physical Address',
                              border: OutlineInputBorder()),
                          controller: _addressController,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          decoration: InputDecoration(
                              labelText: 'Email Address',
                              border: OutlineInputBorder()),
                          controller: _emailController,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: 'Phone Number',
                              border: OutlineInputBorder()),
                          controller: _numberController,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        DropdownButtonFormField<String>(
                          value: garage.type,
                          decoration: InputDecoration(
                              labelText: 'Agent Type',
                              border: OutlineInputBorder()),
                          items: [
                            DropdownMenuItem(
                                value: 'Individual', child: Text('Individual')),
                            DropdownMenuItem(
                                value: 'Company', child: Text('Company')),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _type = value.toString();
                            });
                          },
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
                                if (_image.path != '') {
                                  Reference reference = FirebaseStorage.instance
                                      .ref()
                                      .child('profiles')
                                      .child('${currentUser.uid}.png');
                                  UploadTask uploadTask =
                                      reference.putFile(File(_image.path));
                                  uploadTask.whenComplete(() async {
                                    await reference
                                        .getDownloadURL()
                                        .then((url) async {
                                      await DatabaseService(uid: currentUser.uid)
                                          .setUserProfile(
                                              image: url,
                                              username:
                                                  _usernameController.text,
                                              email: _emailController.text,
                                              address: _addressController.text,
                                              number: _numberController.text,
                                              type: _type == ''
                                                  ? garage.type
                                                  : _type,
                                              cars: garage.cars,
                                              parts: garage.parts)
                                          .then((value) {
                                        setState(() {
                                          _loading = false;
                                          Navigator.pop(context);
                                        });
                                      });
                                    });
                                  });
                                } else {
                                  print(_type);
                                  await DatabaseService(uid: currentUser.uid)
                                      .setUserProfile(
                                          image: garage.image,
                                          username: _usernameController.text,
                                          email: _emailController.text,
                                          address: _addressController.text,
                                          number: _numberController.text,
                                          type:
                                              _type == '' ? garage.type : _type,
                                          cars: garage.cars,
                                          parts: garage.parts)
                                      .then((value) {
                                    setState(() {
                                      _loading = false;
                                      Navigator.pop(context);
                                    });
                                  });
                                }
                              },
                              child: Text(
                                'Edit Profile',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              )),
                        )
                      ],
                    ),
                  ),
                );
        } else {
          return LoadingWidget();
        }
      },
    );
  }
}
