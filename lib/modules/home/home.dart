import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myauctionapp/routes/app_routes.dart';

import '../details/details.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  XFile? image;
  final ImagePicker _picker = ImagePicker();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;

  //this method shows a circular indicator when loading
  progressDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  //this method writes the data in the firebase database
  writeData(context) async {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Dialog(
            child: Container(
              height: 300,
              child: Column(
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.add_card_rounded,
                      ),
                      hintText: 'product name',
                    ),
                  ),
                  TextField(
                    controller: _descController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.description_rounded,
                      ),
                      hintText: 'description',
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.numberWithOptions(),
                    controller: _priceController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.price_change_rounded,
                      ),
                      hintText: 'lowest bid',
                    ),
                  ),
                  Expanded(
                    child: image == null
                        ? Center(
                            child: IconButton(
                              //on pressing the button it will access the gallery
                              // of the phone and sets the selected image on image variable
                              onPressed: () async {
                                image = await _picker.pickImage(
                                    source: ImageSource.gallery);
                                setState(() {});
                              },
                              icon: Icon(Icons.add_a_photo),
                            ),
                          )
                        : Image.file(
                            File(
                              (image!.path),
                            ),
                            fit: BoxFit.contain,
                          ),
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          // show the loading indicator
                          progressDialog();
                          File imgFile = File(image!.path);
                          // upload to stroage
                          UploadTask _uploadTask = storage
                              .ref('images')
                              .child(image!.name)
                              .putFile(imgFile);

                          TaskSnapshot snapshot = await _uploadTask;
                          // get the image download link
                          var imageUrl = await snapshot.ref.getDownloadURL();
                          // store the image & name to our database
                          print(
                              "photo uploaded on storage awaiting for firestore database");
                          firestore.collection('products').add(
                            {
                              'name': _nameController.text,
                              'description': _descController.text,
                              'price': _priceController.text,
                              'icon': imageUrl,
                            },
                          ).whenComplete(
                            () {
                              // after adding data to the database
                              Fluttertoast.showToast(msg: 'Added Successfully');
                              _nameController.clear();
                              _descController.clear();
                              _priceController.clear();
                              image = null;
                              Get.back();
                              Get.back();
                            },
                          );
                        } catch (e) {
                          // if try block doesn't work
                          print(e);
                          Get.back();
                          Get.back();
                        }
                      },
                      child: Text('Add Product'),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  //this method updates data that is already existed on the firebase database
  updateData(context, documentID) async {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Dialog(
            child: Container(
              height: 300,
              child: Column(
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.add_card_rounded,
                      ),
                      hintText: 'product name',
                    ),
                  ),
                  TextField(
                    controller: _descController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.description_rounded,
                      ),
                      hintText: 'description',
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.numberWithOptions(),
                    controller: _priceController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.price_change_rounded,
                      ),
                      hintText: 'lowest bid',
                    ),
                  ),
                  Expanded(
                    child: image == null
                        ? Center(
                            child: IconButton(
                              onPressed: () async {
                                image = await _picker.pickImage(
                                    source: ImageSource.gallery);
                                setState(() {});
                              },
                              icon: Icon(Icons.add_a_photo),
                            ),
                          )
                        : Image.file(
                            File(
                              (image!.path),
                            ),
                            fit: BoxFit.contain,
                          ),
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          // show the loading indicator
                          progressDialog();
                          File imgFile = File(image!.path);
                          // upload to stroage
                          UploadTask _uploadTask = storage
                              .ref('images')
                              .child(image!.name)
                              .putFile(imgFile);

                          TaskSnapshot snapshot = await _uploadTask;
                          // get the image download link
                          var imageUrl = await snapshot.ref.getDownloadURL();
                          // store the image & name to our database
                          firestore.collection('products').add(
                            {
                              'name': _nameController.text,
                              'description': _descController.text,
                              'price': _priceController.text,
                              'icon': imageUrl,
                            },
                          ).whenComplete(
                            () {
                              // after adding data to the database
                              Fluttertoast.showToast(msg: 'Added Successfully');
                              _nameController.clear();
                              _descController.clear();
                              _priceController.clear();
                              image = null;
                              Get.back();
                              Get.back();
                            },
                          );
                        } catch (e) {
                          // if try block doesn't work
                          print(e);
                          Get.back();
                          Get.back();
                        }
                      },
                      child: Text('Update Data'),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  //Stream is used to get the realtime updates on the UI
  final Stream<QuerySnapshot> _productStream =
      FirebaseFirestore.instance.collection('products').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xfff38484),
          title: Text('My Auction App'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xfff38484),
          onPressed: () => writeData(context),
          child: Icon(
            Icons.add,
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _productStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Text("Loading"));
            }

            return GridView(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () => Get.to(Details(name: data['name'], desc: data['description'], bidPrice: data['price'], photo: data['icon'])),
                    child: GridTile(
                      child: Image.network(
                        data['icon'],
                        height: 200,
                      ),
                      footer: GridTileBar(
                        backgroundColor: Colors.black54,
                        title: Text(data['name'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                        subtitle: Text("\$${data['price']}", style: TextStyle(fontWeight: FontWeight.w600),),
                        trailing: Row(
                          children: [
                            IconButton(
                                onPressed: ()=>updateData(context, document.id), icon: Icon(Icons.edit), iconSize: 20, padding: EdgeInsets.all(0.0),),
                            IconButton(
                                onPressed: () {
                                  firestore
                                      .collection('products')
                                      .doc(document.id)
                                      .delete()
                                      .then((value) => Fluttertoast.showToast(
                                      msg: 'deleted successfully.'))
                                      .catchError((error) =>
                                      Fluttertoast.showToast(msg: error));
                                },
                                icon: Icon(Icons.delete), iconSize: 20, padding: EdgeInsets.all(0.0),),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ));
  }
}
