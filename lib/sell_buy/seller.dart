import 'dart:async';
import 'dart:io'; // Add this import for File class

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:zameen_zpp/models/seller_model/seller_profile_model.dart';
import 'package:zameen_zpp/screen/crud_screens/delete_assets.dart';
import 'package:zameen_zpp/screen/crud_screens/update_assets.dart';
import 'package:zameen_zpp/screen/crud_screens/view_assets.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({Key? key}) : super(key: key);

  @override
  _SellScreenState createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  final imagePicker = ImagePicker();
  List<XFile> images = [];
  List<String> imageUrls = [];
  var uuid = const Uuid();
  bool isSaving = false;
  bool isUploading = false;
  String selectedProductType = '';
  final TextEditingController _locationController = TextEditingController();
  Position? _currentPosition;
  String _buildLocationDivText = 'No Location Selected yet!';

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFC8291D),
      appBar: AppBar(
        backgroundColor: const Color(0xFFC8291D),
        title: const Text('Sell Screen',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        centerTitle: true,
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFFC8291D),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 200,
              child: Center(
                child: Text(
                  'Seller Screen ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 221, 216, 216),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  _listTileComponent(context, () async {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const ViewAssetsScreen()),
                      (route) => false,
                    );
                  }, Icons.view_agenda, 'View Assets'),
                  const Divider(),
                  _listTileComponent(context, () async {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const DeleteAssetsScreen()),
                      (route) => false,
                    );
                  }, Icons.delete, 'Delete assets'),
                  const Divider(),
                  _listTileComponent(context, () async {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const UpdateAssetsScreen()),
                      (route) => false,
                    );
                  }, Icons.update, 'Update assets'),
                  const Divider(),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 244, 241, 241),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 90,
                  backgroundImage: AssetImage('assets/images/logo.zameen.jpg'),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    prefixIcon: Icon(FontAwesomeIcons.productHunt),
                    hintText: 'Enter your Name...',
                  ),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Field should not be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: productNameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    prefixIcon: Icon(FontAwesomeIcons.productHunt),
                    hintText: 'Enter Product Name...',
                  ),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Field should not be empty';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: descriptionController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    prefixIcon: Icon(FontAwesomeIcons.audioDescription),
                    hintText: 'Enter Description',
                  ),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Field should not be empty';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: Icon(FontAwesomeIcons.moneyBill),
                    hintText: 'Enter price',
                  ),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Field should not be empty';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: phoneNumberController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: Icon(FontAwesomeIcons.moneyBill),
                    hintText: 'Phono no.....',
                  ),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Field should not be empty';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                _buildLocationDiv(),
                const SizedBox(height: 10),
                if (images.length < 2)
                  MaterialButton(
                    color: const Color(0xFFC8291D),
                    child: Text(
                      images.length < 5
                          ? "Pick ${4 - images.length} more image(s) to complete"
                          : "Pick Images",
                      style: const TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      pickImage();
                    },
                  ),
                const SizedBox(height: 10),
                if (images.isNotEmpty)
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(),
                    ),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                      ),
                      itemCount: images.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                ),
                                child: Image.file(
                                  File(images[index].path),
                                  height: 200,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  _removeImage(index);
                                },
                                icon: const Center(
                                  child: Icon(
                                    Icons.cancel_outlined,
                                    color: Colors.red,
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _removeImage(int index) {
    setState(() {
      images.removeAt(index);
    });
  }

  Widget _buildLocationDiv() {
    return Column(
      children: [
        Text(
          'Select Location',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(border: Border.all()),
          child: GoogleMap(
            mapType: MapType.hybrid,
            initialCameraPosition: CameraPosition(
              target: LatLng(37.43296265331129, -122.08832357078792),
            ),
          ),
        ),
        MaterialButton(
          color: const Color(0xFFC8291D),
          child: Text(
            "Save",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            _saveProductsMethod();
          },
        ),
      ],
    );
  }

  void _saveProductsMethod() async {
    try {
      if (!validateFields()) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please fill in all required fields")),
        );
        return;
      }

      await uploadImages();

      await FirebaseFirestore.instance.collection('all_products').add(
            SellerProfileModel(
              name: nameController.text,
              productName: productNameController.text,
              description: descriptionController.text,
              price: double.parse(priceController.text),
              phoneNumber: int.parse(phoneNumberController.text),
              imageUrls: imageUrls,
              productType: selectedProductType,
              latitude: _currentPosition!.latitude.toString(),
              longitude: _currentPosition!.longitude.toString(),
            ).toJson(),
          );

      clearControllers();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Added Successfully")),
      );
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred. ${e.toString()}")),
      );
    }
  }

  bool validateFields() {
    if (nameController.text.isEmpty ||
        productNameController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        priceController.text.isEmpty ||
        phoneNumberController.text.isEmpty) {
      return false;
    }
    return true;
  }

  void clearControllers() {
    nameController.clear();
    productNameController.clear();
    descriptionController.clear();
    priceController.clear();
    phoneNumberController.clear();
  }

  Widget _listTileComponent(BuildContext context, void Function()? onTap,
      IconData leadingIcon, String title) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          leading: Icon(leadingIcon),
          title: Text(title),
          trailing: const Icon(Icons.forward_outlined),
        ),
      ],
    );
  }

  Future<void> uploadImages() async {
    for (var image in images) {
      try {
        String? downLoadUrl = await postImages(image);

        if (downLoadUrl != null) {
          setState(() {
            imageUrls.add(downLoadUrl);
          });
        } else {
          Fluttertoast.showToast(msg: "Error: Image upload failed");
        }
      } catch (e) {
        print("Error uploading image: $e");
        Fluttertoast.showToast(msg: "Error: Image upload failed");
      }
    }
  }

  Future<String?> postImages(XFile? imageFile) async {
    setState(() {
      isUploading = true;
    });

    String? urls;
    Reference ref =
        FirebaseStorage.instance.ref().child("images").child(imageFile!.name);

    await ref.putData(
      await imageFile.readAsBytes(),
      SettableMetadata(contentType: "image/jpeg"),
    );

    urls = await ref.getDownloadURL();
    setState(() {
      isUploading = false;
    });
    return urls;
  }

  void pickImage() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        images.add(pickedFile);
      } else {
        print('No image selected.');
      }
    });
  }
}







// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:uuid/uuid.dart';
// import 'package:zameen_zpp/models/seller_model/seller_profile_model.dart';
// import 'package:zameen_zpp/screen/crud_screens/delete_assets.dart';
// import 'package:zameen_zpp/screen/crud_screens/update_assets.dart';
// import 'package:zameen_zpp/screen/crud_screens/view_assets.dart';

// class SellScreen extends StatefulWidget {
//   const SellScreen({Key? key}) : super(key: key);

//   @override
//   _SellScreenState createState() => _SellScreenState();
// }

// class _SellScreenState extends State<SellScreen> {
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController nameController = TextEditingController();
//   TextEditingController productNameController = TextEditingController();
//   TextEditingController descriptionController = TextEditingController();
//   TextEditingController priceController = TextEditingController();
//   TextEditingController phoneNumberController = TextEditingController();
//   final imagePicker = ImagePicker();
//   List<XFile> images = [];
//   List<String> imageUrls = [];
//   var uuid = const Uuid();
//   bool isSaving = false;
//   bool isUploading = false;
//   String selectedProductType = '';
//   final TextEditingController _locationController = TextEditingController();
//   Position? _currentPosition;
//   String _buildLocationDivText = 'No Location Selected yet!';

//   ///
//   final Completer<GoogleMapController> _controller =
//       Completer<GoogleMapController>();

//   ///this is current locaiotn
//   ///
//   static const CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );

//   static const CameraPosition _kLake = CameraPosition(
//       bearing: 192.8334901395799,
//       target: LatLng(37.43296265331129, -122.08832357078792),
//       tilt: 59.440717697143555,
//       zoom: 19.151926040649414);

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: const Color(0xFFC8291D),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFC8291D),
//         title: const Text('Sell Screen',
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
//         centerTitle: true,
//       ),
//       drawer: Drawer(
//         backgroundColor: const Color(0xFFC8291D),
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             SizedBox(
//               height: 200,
//               child: Center(
//                 child: Text(
//                   'Seller Screen ',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               width: size.width,
//               height: size.height,
//               decoration: BoxDecoration(
//                 color: const Color.fromARGB(255, 221, 216, 216),
//                 borderRadius: BorderRadius.circular(30),
//               ),
//               child: Column(
//                 children: [
//                   _listTileComponent(context, () async {
//                     Navigator.pushAndRemoveUntil(
//                       context,
//                       MaterialPageRoute(
//                           builder: (_) => const ViewAssetsScreen()),
//                       (route) => false,
//                     );
//                   }, Icons.view_agenda, 'View Assets'),
//                   const Divider(),
//                   _listTileComponent(context, () async {
//                     Navigator.pushAndRemoveUntil(
//                       context,
//                       MaterialPageRoute(
//                           builder: (_) => const DeleteAssetsScreen()),
//                       (route) => false,
//                     );
//                   }, Icons.delete, 'Delete assets'),
//                   const Divider(),
//                   _listTileComponent(context, () async {
//                     Navigator.pushAndRemoveUntil(
//                       context,
//                       MaterialPageRoute(
//                           builder: (_) => const UpdateAssetsScreen()),
//                       (route) => false,
//                     );
//                   }, Icons.update, 'Update assets'),
//                   const Divider(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: Container(
//         width: size.width,
//         height: size.height,
//         decoration: BoxDecoration(
//           color: const Color.fromARGB(255, 244, 241, 241),
//           borderRadius: BorderRadius.circular(30),
//         ),
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 CircleAvatar(
//                   radius: 90,
//                   backgroundImage: AssetImage('assets/images/logo.zameen.jpg'),
//                 ),
//                 const SizedBox(height: 20),
//                 // DropdownButton<String>(
//                 //   value: selectedProductType,
//                 //   onChanged: (String? newValue) {
//                 //     if (newValue != null) {
//                 //       setState(() {
//                 //         selectedProductType = newValue;
//                 //       });
//                 //     }
//                 //   },
//                 //   items: ['land', 'house', 'shops']
//                 //       .map<DropdownMenuItem<String>>(
//                 //         (value) => DropdownMenuItem<String>(
//                 //           value: value,
//                 //           child: Text(value),
//                 //         ),
//                 //       )
//                 //       .toList(),
//                 // ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   controller: nameController,
//                   keyboardType: TextInputType.name,
//                   decoration: InputDecoration(
//                     prefixIcon: Icon(FontAwesomeIcons.productHunt),
//                     hintText: 'Enter your Name...',
//                   ),
//                   validator: (v) {
//                     if (v!.isEmpty) {
//                       return 'Field should not be empty';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 20),
//                 TextFormField(
//                   controller: productNameController,
//                   keyboardType: TextInputType.name,
//                   decoration: InputDecoration(
//                     prefixIcon: Icon(FontAwesomeIcons.productHunt),
//                     hintText: 'Enter Product Name...',
//                   ),
//                   validator: (v) {
//                     if (v!.isEmpty) {
//                       return 'Field should not be empty';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 TextFormField(
//                   controller: descriptionController,
//                   keyboardType: TextInputType.name,
//                   decoration: InputDecoration(
//                     prefixIcon: Icon(FontAwesomeIcons.audioDescription),
//                     hintText: 'Enter Description',
//                   ),
//                   validator: (v) {
//                     if (v!.isEmpty) {
//                       return 'Field should not be empty';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 TextFormField(
//                   controller: priceController,
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration(
//                     prefixIcon: Icon(FontAwesomeIcons.moneyBill),
//                     hintText: 'Enter price',
//                   ),
//                   validator: (v) {
//                     if (v!.isEmpty) {
//                       return 'Field should not be empty';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 TextFormField(
//                   controller: phoneNumberController,
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration(
//                     prefixIcon: Icon(FontAwesomeIcons.moneyBill),
//                     hintText: 'Phono no.....',
//                   ),
//                   validator: (v) {
//                     if (v!.isEmpty) {
//                       return 'Field should not be empty';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 20),
//                     ///location div
//                 _buildLocationDiv(),

//                 ///
//                 const SizedBox(height: 10),
//                 if (images.length < 2)
//                   MaterialButton(
//                     color: const Color(0xFFC8291D),
//                     child: Text(
//                       images.length < 4
//                           ? "Pick ${4 - images.length} more image(s) to complete"
//                           : "Pick Images",
//                       style: const TextStyle(color: Colors.white),
//                     ),
//                     onPressed: () {
//                       pickImage();
//                     },
//                   ),
//                 const SizedBox(height: 10),
//                 if (images.isNotEmpty)
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       border: Border.all(),
//                     ),
//                     child: GridView.builder(
//                       shrinkWrap: true,
//                       physics: const ScrollPhysics(),
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 5,
//                       ),
//                       itemCount: images.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Stack(
//                             children: [
//                               Container(
//                                 decoration: BoxDecoration(
//                                   border: Border.all(color: Colors.black),
//                                 ),
//                                 child: Image.file(
//                                   File(images[index].path),
//                                   height: 200,
//                                   width: 200,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                               IconButton(
//                                 onPressed: () {
//                                   _removeImage(index);
//                                 },
//                                 icon: const Center(
//                                   child: Icon(
//                                     Icons.cancel_outlined,
//                                     color: Colors.red,
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 MaterialButton(
//                   color: const Color(0xFFC8291D),
//                   child:  Text(
//                     "Save",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   onPressed: () {
//                     _saveProductsMethod();
//                   },
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _removeImage(int index) {
//     setState(() {
//       images.removeAt(index);
//     });
//      Text(
//                   'Select Location',
//                   style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//                 );

//                 ///adding google maps
//                 ///AIzaSyAHlzbyilrFc9sW5MQ_JOLLkDgh-97SaKI
//                 Container(
//                   height: 200,
//                   width: double.infinity,
//                   decoration: BoxDecoration(border: Border.all()),
//                   child: GoogleMap(
//                     mapType: MapType.hybrid,
//                     initialCameraPosition: CameraPosition(
//                       target: LatLng(37.43296265331129, -122.08832357078792),
//                     ),
//                   ),
//                 );

//                 ///

//                 const SizedBox(height: 10);
//                 // Add similar TextFormField for other fields
//                 //...
//                 MaterialButton(
//                   color: const Color(0xFFC8291D),
//                   child:
//                       const Text("Save", style: TextStyle(color: Colors.white)),
//                   onPressed: () {
//                     _saveProductsMethod();
//                   },
//                 );
             
//   }
               
//   }

//   void _saveProductsMethod() async {
//     try {
//       if (!validateFields()) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Please fill in all required fields")),
//         );
//         return;
//       }

//       await uploadImages();

//       await FirebaseFirestore.instance.collection('all_products').add(
//             SellerProfileModel(
//               name: nameController.text,
//               productName: productNameController.text,
//               description: descriptionController.text,
//               price: double.parse(priceController.text),
//               phoneNumber: int.parse(phoneNumberController.text),
//               imageUrls: imageUrls,
//               productType: selectedProductType,
//               latitude: _currentPosition!.latitude.toString(),
//               longitude: _currentPosition!.longitude.toString(),
//             ).toJson(),
//           );

//       clearControllers();

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Added Successfully")),
//       );
//     } catch (e) {
//       print("Error: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("An error occurred. ${e.toString()}")),
//       );
//     }
//   }

//   bool validateFields() {
//     if (nameController.text.isEmpty ||
//         productNameController.text.isEmpty ||
//         descriptionController.text.isEmpty ||
//         priceController.text.isEmpty ||
//         phoneNumberController.text.isEmpty) {
//       return false;
//     }
//     return true;
//   }

//   void clearControllers() {
//     nameController.clear();
//     productNameController.clear();
//     descriptionController.clear();
//     priceController.clear();
//     phoneNumberController.clear();
//   }

//   Widget _listTileComponent(BuildContext context, void Function()? onTap,
//       IconData leadingIcon, String title) {
//     return Column(
//       children: [
//         ListTile(
//           onTap: onTap,
//           leading: Icon(leadingIcon),
//           title: Text(title),
//           trailing: const Icon(Icons.forward_outlined),
//         ),
//       ],
//     );
//   }

//   Future<void> uploadImages() async {
//     for (var image in images) {
//       try {
//         String? downLoadUrl = await postImages(image);

//         if (downLoadUrl != null) {
//           setState(() {
//             imageUrls.add(downLoadUrl);
//           });
//         } else {
//           Fluttertoast.showToast(msg: "Error: Image upload failed");
//         }
//       } catch (e) {
//         print("Error uploading image: $e");
//         Fluttertoast.showToast(msg: "Error: Image upload failed");
//       }
//     }
//   }

//   Future<String?> postImages(XFile? imageFile) async {
//     setState(() {
//       isUploading = true;
//     });

//     String? urls;
//     Reference ref =
//         FirebaseStorage.instance.ref().child("images").child(imageFile!.name);

//     await ref.putData(
//       await imageFile.readAsBytes(),
//       SettableMetadata(contentType: "image/jpeg"),
//     );

//     urls = await ref.getDownloadURL();
//     setState(() {
//       isUploading = false;
//     });
//     return urls;
//   }
