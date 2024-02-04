// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:uuid/uuid.dart';
// import 'package:zameen_zpp/models/carousel_slider_model/product_model/categories_model.dart';
// import 'package:zameen_zpp/models/seller_model/seller_profile_model.dart';
// import 'package:zameen_zpp/widgets/custom_text_feild.dart';

// class AddAssetsScreen extends StatefulWidget {
//   static const String id = "addproduct";

//   @override
//   State<AddAssetsScreen> createState() => _AddProductScreenState();
// }

// class _AddProductScreenState extends State<AddAssetsScreen> {
//   ///controllers
//   TextEditingController categoryController = TextEditingController();

//   TextEditingController _NameController = TextEditingController();
//   TextEditingController _descriptionController = TextEditingController();

//   TextEditingController _priceController = TextEditingController();
//   TextEditingController _phoneNumberC = TextEditingController();

//   bool isOnSale = false;
//   bool isPopular = false;
//   bool isSaving = false;
//   bool isUploading = false;

//   String? selectedCategory;
//   final imagePicker = ImagePicker();
//   List<XFile> images = [];
//   List<String> imageUrls = [];
//   List<CategoriesModel> categoriess = [];
//   var uuid = Uuid();

//   clearControllers() {
//     categoryController.clear();
//     _NameController.clear();
//     _descriptionController.clear();
//     _priceController.clear();
//     _phoneNumberC.clear();
//   }

//   Widget buildLogo() {
//     return CircleAvatar(
//       radius: 100,
//       backgroundImage: AssetImage('assets/images/e_commerce_logo.png'),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: Scaffold(
//           appBar: AppBar(
//             title: Text('Add Products'),
//           ),
//           body: SingleChildScrollView(
//             child: Container(
//               child: Center(
//                 child: Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Column(
//                     children: [
//                       DropdownButtonFormField(
//                         hint: Text('Choose Category'),
//                         decoration: const InputDecoration(
//                           prefixIcon: Icon(Icons.category),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(10)),
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null) {
//                             return "category must be selected";
//                           }
//                           return null;
//                         },
//                         value: selectedCategory,
//                         items: categories
//                             .map(
//                               (e) => DropdownMenuItem<String>(
//                                 value: e.title,
//                                 child: Text(e.title!),
//                               ),
//                             )
//                             .toList(),
//                         onChanged: (value) {
//                           setState(() {
//                             selectedCategory = value.toString();
//                           });
//                         },
//                       ),
//                       SizedBox(height: 10),
//                       CustomTextField(
//                         prefixIcon: FontAwesomeIcons.productHunt,
//                         keyboardType: TextInputType.name,
//                         textEditingController: _NameController,
//                         hintText: "Enter Asset Name...",
//                         validator: (v) {
//                           if (v!.isEmpty) {
//                             return "Feild should not be empty";
//                           }
//                           return null;
//                         },
//                       ),
//                       SizedBox(height: 10),
//                       CustomTextField(
//                         prefixIcon: Icons.description,
//                         keyboardType: TextInputType.name,
//                         textEditingController: _descriptionController,
//                         hintText: "Enter Description...",
//                         validator: (v) {
//                           if (v!.isEmpty) {
//                             return "should not be empty";
//                           }
//                           return null;
//                         },
//                       ),
//                       SizedBox(height: 10),
//                       CustomTextField(
//                         prefixIcon: Icons.price_change,
//                         keyboardType: TextInputType.number,
//                         textEditingController: _phoneNumberC,
//                         hintText: "Enter phone no",
//                         validator: (v) {
//                           if (v!.isEmpty) {
//                             return "Feild should not be empty";
//                           }
//                           return null;
//                         },
//                       ),
//                       SizedBox(height: 10),
//                       CustomTextField(
//                         prefixIcon: Icons.price_change,
//                         keyboardType: TextInputType.name,
//                         textEditingController: _priceController,
//                         hintText: "Enter price",
//                         validator: (v) {
//                           if (v!.isEmpty) {
//                             return " Feild should not be empty";
//                           }
//                           return null;
//                         },
//                       ),
//                       SizedBox(height: 10),
//                       if (images.length < 2)
//                         MaterialButton(
//                           color: Theme.of(context).primaryColor,
//                           child: Text(
//                             images.length < 10
//                                 ? "Pick ${2 - images.length} more image(s) to complete"
//                                 : "Pick Images",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           onPressed: () {
//                             pickImage();
//                           },
//                         ),
//                       SizedBox(height: 10),
//                       if (images.isNotEmpty)
//                         Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             border: Border.all(),
//                           ),
//                           child: GridView.builder(
//                             shrinkWrap: true,
//                             physics: ScrollPhysics(),
//                             gridDelegate:
//                                 const SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: 5,
//                             ),
//                             itemCount: images.length,
//                             itemBuilder: (BuildContext context, int index) {
//                               return Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Stack(
//                                   children: [
//                                     Container(
//                                       decoration: BoxDecoration(
//                                         border: Border.all(color: Colors.black),
//                                       ),
//                                       child: Image.file(
//                                         File(images[index].path),
//                                         height: 200,
//                                         width: 200,
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                     IconButton(
//                                       onPressed: () {
//                                         _removeImage(index);
//                                       },
//                                       icon: Center(
//                                         child: const Icon(
//                                           Icons.cancel_outlined,
//                                           color: Colors.red,
//                                         ),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       SwitchListTile(
//                         title: Text(
//                           isOnSale == false
//                               ? 'Is this Product on Sale?'
//                               : 'Is ON SALE',
//                         ),
//                         value: isOnSale,
//                         onChanged: (v) {
//                           setState(() {
//                             isOnSale = !isOnSale;
//                           });
//                         },
//                       ),
//                       SwitchListTile(
//                         title: Text(
//                           isPopular == false
//                               ? 'Is this Product Popular?'
//                               : 'is POPULAR',
//                         ),
//                         value: isPopular,
//                         onChanged: (v) {
//                           setState(() {
//                             isPopular = !isPopular;
//                           });
//                         },
//                       ),
//                       MaterialButton(
//                         color: Theme.of(context).primaryColor,
//                         child: Text(
//                           "Save",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         onPressed: () {
//                           _saveProductsMethod();
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           )),
//     );
//   }

//   void _removeImage(int index) {
//     setState(() {
//       images.removeAt(index);
//     });
//   }

//   _saveProductsMethod() async {
//     setState(() {
//       isSaving = true;
//     });

//     try {
//       if (!validateFields()) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Please fill in all required fields")),
//         );
//         return;
//       }

//       await uploadImages();

//       DateTime createdAt = DateTime.now();

//       await FirebaseFirestore.instance.collection('products').add(
//             SellerProfileModel(
//               name:
//               productName:
//               description: 
//               imageUrls:
//               price: double.parse(_priceController.text),
//               phoneNumber: int.parse(_phoneNumberC.text),
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
//     if (selectedCategory == null || selectedCategory!.isEmpty) {
//       return false;
//     }

//     if (_NameController.text.isEmpty ||
//         _descriptionController.text.isEmpty ||
//         _priceController.text.isEmpty) {
//       return false;
//     }
//     return true;
//   }

//   pickImage() async {
//     final List<XFile>? pickImage =
//         await imagePicker.pickMultiImage(imageQuality: 100);

//     if (pickImage != null) {
//       setState(() {
//         images.addAll(pickImage);
//       });
//     } else {
//       Fluttertoast.showToast(msg: 'No Images Selected');
//     }
//   }

//   Future postImages(XFile? imageFile) async {
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
// }



// // import 'dart:io';
// // import 'dart:ui';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_storage/firebase_storage.dart';
// // import 'package:flutter/material.dart';
// // import 'package:fluttertoast/fluttertoast.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:uuid/uuid.dart';
// // import 'package:zameen_zpp/models/product_model/categories_model.dart';
// // import 'package:zameen_zpp/widgets/custom_text_feild.dart';

// // class AddAssetsScreen extends StatefulWidget {
// //   const AddAssetsScreen({Key? key}) : super(key: key);

// //   @override
// //   State<AddAssetsScreen> createState() => _AddAssetsScreenState();
// // }

// // class _AddAssetsScreenState extends State<AddAssetsScreen> {
// //   ///
// //   final TextEditingController _categoryController = TextEditingController();
// //   final TextEditingController _nameController = TextEditingController();
// //   final TextEditingController _descriptionController = TextEditingController();
// //   final TextEditingController _priceController = TextEditingController();
// //   final TextEditingController _phoneNumberC = TextEditingController();

// //   ///
// //   var globalkey = GlobalKey<FormState>();
// //   // ignore: unused_field
// //   File? _pickedImage;

// //   ///
// //   var uuid = const Uuid();

// //   ///
// //   bool isUploading = false;
// //    bool isOnSale = false;
// //   bool isPopular = false;
// //   bool isSaving = false;

// //   ///
// //   String? _selectedCategory;

// //   ///
// //   final imagePicker = ImagePicker();

// //   ///
// //   List<XFile> images = [];
// //   List<String> imageUrls = [];
// //   List<CategoriesModel> categoriess = [];
// //    var uuid = Uuid();

// //   ///
// //   clearControllers() {
// //     _categoryController.clear();
// //     _nameController.clear();
// //     _descriptionController.clear();
// //     _priceController.clear();
// //     _phoneNumberC.clear();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final Size size = MediaQuery.of(context).size;
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Add Assets'),
// //       ),
// //       body: SizedBox(
// //         height: size.height,
// //         width: size.width,
// //         child: Center(
// //           child: BackdropFilter(
// //             filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
// //             child: Form(
// //               key: globalkey,
// //               child: SizedBox(
// //                 height: size.height * 0.90,
// //                 width: size.width,
// //                 child: Padding(
// //                   padding: const EdgeInsets.all(10.0),
// //                   child: SingleChildScrollView(
// //                     child: Column(
// //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                       children: [
// //                         const CircleAvatar(
// //                           radius: 100,
// //                           backgroundImage:
// //                               AssetImage('assets/images/logo.zameen.jpg'),
// //                         ),
// //                         sizedbox(),
// //                          DropdownButtonFormField(
// //                             hint: Text('Choose Category'),
// //                             decoration: const InputDecoration(
// //                               prefixIcon: Icon(Icons.category),
// //                               border: OutlineInputBorder(
// //                                 borderRadius:
// //                                     BorderRadius.all(Radius.circular(10)),
// //                               ),
// //                             ),
// //                             validator: (value) {
// //                               if (value == null) {
// //                                 return "category must be selected";
// //                               }
// //                               return null;
// //                             },
// //                             value: selectedCategory,
// //                             items: categories
// //                                 .map(
// //                                   (e) => DropdownMenuItem<String>(
// //                                     value: e.title,
// //                                     child: Text(e.title!),
// //                                   ),
// //                                 )
// //                                 .toList(),
// //                             onChanged: (value) {
// //                               setState(() {
// //                                 _selectedCategory = value.toString();
// //                               });
// //                             },
// //                           ),

// //                         // DropdownButtonFormField(
// //                         //   items: categories.map((value) {
// //                         //     return DropdownMenuItem(
// //                         //       value: value,
// //                         //       child: Text(value.toString()),
// //                         //     );
// //                         //   }).toList(),
// //                         //   value: _selectedCategory,
// //                         //   onChanged: (newValue) {
// //                         //     setState(() {
// //                         //       _selectedCategory = newValue.toString();
// //                         //     });
// //                         //   },
// //                         //   decoration: const InputDecoration(
// //                         //     labelText: 'Select Category',
// //                         //   ),
// //                         // ),
// //                         sizedbox(),
// //                         CustomTextField(
// //                           textEditingController: _nameController,
// //                           prefixIcon: Icons.edit,
// //                           hintText: 'Enter Product Name',
// //                           validator: (v) {
// //                             if (v!.isEmpty) {
// //                               return 'Field Should not be Empty';
// //                             } else {
// //                               return null;
// //                             }
// //                           },
// //                         ),
// //                         sizedbox(),
// //                         CustomTextField(
// //                           textEditingController: _descriptionController,
// //                           prefixIcon: Icons.description,
// //                           hintText: 'Enter Product Description',
// //                           validator: (v) {
// //                             if (v!.isEmpty) {
// //                               return 'Field Should not be Empty';
// //                             } else {
// //                               return null;
// //                             }
// //                           },
// //                         ),
// //                         sizedbox(),
// //                         CustomTextField(
// //                           textEditingController: _priceController,
// //                           prefixIcon: Icons.price_change_outlined,
// //                           hintText: 'Enter Product Price',
// //                           validator: (v) {
// //                             if (v!.isEmpty) {
// //                               return 'Field Should not be Empty';
// //                             } else {
// //                               return null;
// //                             }
// //                           },
// //                         ),
// //                         // CustomTextField(
// //                         //   textEditingController: _phoneNumberC,
// //                         //   prefixIcon: Icons.phone,
// //                         //   hintText: 'Enter Phone Number',
// //                         //   validator: (v) {
// //                         //     if (v!.isEmpty) {
// //                         //       return 'Field Should Not be Empty';
// //                         //     } else if (!RegExp(r'^[0-9]+$').hasMatch(v)) {
// //                         //       return 'Enter a valid phone number';
// //                         //     }
// //                         //     return null;
// //                         //   },
// //                         // ),
// //                         sizedbox(),
// //                         CustomTextField(
// //                           textEditingController: _phoneNumberC,
// //                           prefixIcon: Icons.phone,
// //                           hintText: 'Enter Phone Number',
// //                           keyboardType: TextInputType.number,
// //                           validator: (v) {
// //                             if (v!.isEmpty) {
// //                               return 'Field Should Not be Empty';
// //                             } else if (!RegExp(r'^[0-9]+$').hasMatch(v)) {
// //                               return 'Enter a valid phone number';
// //                             }
// //                             return null;
// //                           },
// //                         ),
// //                         sizedbox(),
// //                         // Container(
// //                         //   height: 200,
// //                         //   width: size.width,
// //                         //   decoration: BoxDecoration(
// //                         //     color: Colors.grey.withOpacity(0.2),
// //                         //     border: Border.all(),
// //                         //     borderRadius: BorderRadius.circular(10),
// //                         //   ),
// //                         //   child: _pickedImage != null
// //                         //       ? Image.file(
// //                         //           _pickedImage!,
// //                         //           height: 100,
// //                         //           width: 100,
// //                         //         )
// //                         //       : IconButton(
// //                         //           onPressed: () {
// //                         //             _showModalBottomSheetSuggestions();
// //                         //           },
// //                         //           icon: Icon(Icons.image_outlined),
// //                         //         ),
// //                         // ),

// //                         if (images.length < 10)
// //                           MaterialButton(
// //                               color: Theme.of(context).primaryColor,
// //                               child: Text(
// //                                 images.length < 10
// //                                     ? "pick ${10 - images.length}more image(s) to complete"
// //                                     : "pick image",
// //                                 style: TextStyle(color: Colors.white),
// //                               ),
// //                               onPressed: () {
// //                                 // pickImage();
// //                               }),
// //                         sizedbox(),
// //                         if (images.isEmpty) Container(
// //                           decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
// //                           border: Border.all()),
// //                          child: GridView.builder(
// //                             shrinkWrap: true,
// //                             physics: ScrollPhysics(),
// //                             gridDelegate:
// //                                 const SliverGridDelegateWithFixedCrossAxisCount(
// //                               crossAxisCount: 5,
// //                             ),
// //                             itemCount: images.length,
// //                             itemBuilder: (BuildContext context, int index) {
// //                               return Padding(
// //                                 padding: const EdgeInsets.all(8.0),
// //                                 child: Stack(
// //                                   children: [
// //                                     Container(
// //                                       decoration: BoxDecoration(
// //                                         border: Border.all(color: Colors.black),
// //                                       ),
// //                                       child: Image.file(
// //                                         File(images[index].path),
// //                                         height: 200,
// //                                         width: 200,
// //                                         fit: BoxFit.cover,
// //                                       ),
// //                                     ),
// //                                     IconButton(
// //                                       onPressed: () {
// //                                         _removeImage(index);
// //                                         // setState(() {
// //                                         //   images.removeAt(index);
// //                                         // });
// //                                       },
// //                                       icon: Center(
// //                                         child: const Icon(
// //                                           Icons.cancel_outlined,
// //                                           color: Colors.red,
// //                                         ),
// //                                       ),
// //                                     )
// //                                   ],
// //                                 ),
// //                               );
// //                             },
// //                           ),
// //                         ),
// //                        SwitchListTile(
// //                         title: Text(
// //                           isOnSale == false
// //                               ? 'Is this Product on Sale?'
// //                               : 'Is ON SALE',
// //                         ),
// //                         value: isOnSale,
// //                         onChanged: (v) {
// //                           setState(() {
// //                             isOnSale = !isOnSale;
// //                           });
// //                         },
// //                       ),

// //                       ///SwitchListTile
// //                       SwitchListTile(
// //                         title: Text(
// //                           isPopular == false
// //                               ? 'Is this Product Popular?'
// //                               : 'is POPULAR',
// //                         ),
// //                         value: isPopular,
// //                         onChanged: (v) {
// //                           setState(() {
// //                             isPopular = !isPopular;
// //                           });
// //                         },
// //                       ),

// //                       ///save button
// //                       MaterialButton(
// //                         color: Theme.of(context).primaryColor,
// //                         child: Text(
// //                           "Save",
// //                           style: TextStyle(color: Colors.white),
// //                         ),
// //                         onPressed: () {
// //                           _saveProductsMethod();
// //                         },
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           )),
// //         ),
// //      ), );
// //   }

// //   void _removeImage(int index) {
// //     setState(() {
// //       images.removeAt(index);
// //     });
// //      _saveProductsMethod() async {
// //     setState(() {
// //       isSaving = true;
// //     });

// //     try {
// //       if (!validateFields()) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           const SnackBar(content: Text("Please fill in all required fields")),
// //         );
// //         return;
// //       }

// //       await uploadImages();

// //       DateTime createdAt = DateTime.now();

// //       await FirebaseFirestore.instance.collection('products').add(
// //             ProductModel(
// //               category: _selectedCategory,
// //               id: uuid.v4(),
// //               productName: _nameController.text,
// //               productDescription:  _descriptionController.text,
// //               price: int.parse(_priceController.text),
              
// //               imageUrls: imageUrls,
// //               isSale: isOnSale,
// //               isPopular: isPopular,
// //               createdAt:
// //                   createdAt, // Ensure that createdAt is assigned a non-null value
// //             ).toJson(),
// //           );

// //       clearControllers();

// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text("Added Successfully")),
// //       );
// //     } catch (e) {
// //       print("Error: $e");
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text("An error occurred. ${e.toString()}")),
// //       );
// //     }
// //   }

// //   bool validateFields() {
// //     if (_selectedCategory == null || _selectedCategory!.isEmpty) {
// //       return false;
// //     }

// //     if (_nameController.text.isEmpty ||
// //        _descriptionController.text.isEmpty ||
// //         _priceController.text.isEmpty ||
      
// //         _phoneNumberC.text.isEmpty) {
// //       return false;
// //     }
// //     return true;
// //   }

// //   pickImage() async {
// //     final List<XFile>? pickImage =
// //         await imagePicker.pickMultiImage(imageQuality: 100);

// //     if (pickImage != null) {
// //       setState(() {
// //         images.addAll(pickImage);
// //       });
// //     } else {
// //       Fluttertoast.showToast(msg: 'No Images Selected');
// //     }
// //   }

// //   Future postImages(XFile? imageFile) async {
// //     setState(() {
// //       isUploading = true;
// //     });

// //     String? urls;
// //     Reference ref =
// //         FirebaseStorage.instance.ref().child("images").child(imageFile!.name);

// //     await ref.putData(
// //       await imageFile.readAsBytes(),
// //       SettableMetadata(contentType: "image/jpeg"),
// //     );

// //     urls = await ref.getDownloadURL();
// //     setState(() {
// //       isUploading = false;
// //     });
// //     return urls;
// //   }

// //   Future<void> uploadImages() async {
// //     for (var image in images) {
// //       try {
// //         String? downLoadUrl = await postImages(image);

// //         if (downLoadUrl != null) {
// //           setState(() {
// //             imageUrls.add(downLoadUrl);
// //           });
// //         } else {
// //           Fluttertoast.showToast(msg: "Error: Image upload failed");
// //         }
// //       } catch (e) {
// //         print("Error uploading image: $e");
// //         Fluttertoast.showToast(msg: "Error: Image upload failed");
// //       }
// //     }
// //   }
// // }
// //   }

  

// //   // void _showModalBottomSheetSuggestions() {
// //   //   showModalBottomSheet(
// //   //     shape: const RoundedRectangleBorder(
// //   //       borderRadius: BorderRadius.zero,
// //   //     ),
// //   //     context: context,
// //   //     builder: (BuildContext context) {
// //   //       return Container(
// //   //         child: Wrap(
// //   //           children: [
// //   //             ListTile(
// //   //               leading: const Icon(Icons.camera_alt_outlined),
// //   //               title: const Text('Pick From Camera'),
// //   //               onTap: () => {_pickFromCamera()},
// //   //             ),
// //   //             ListTile(
// //   //               leading: const Icon(Icons.image_search_outlined),
// //   //               title: const Text('Pick From Gallery'),
// //   //               onTap: () => {_pickFromGallery()},
// //   //             ),
// //   //           ],
// //   //         ),
// //   //       );
// //   //     },
// //   //   );
// //   // }

// //   // Future<void> _pickFromCamera() async {
// //   //   Navigator.pop(context);
// //   //   try {
// //   //     final XFile? pickedImage = await ImagePicker()
// //   //         .pickImage(source: ImageSource.camera, imageQuality: 100);
// //   //     if (pickedImage != null) {
// //   //       setState(() {
// //   //         _pickedImage = File(pickedImage.path);
// //   //       });
// //   //       Fluttertoast.showToast(msg: 'Image Picked From Camera');
// //   //     }
// //   //   } catch (e) {
// //   //     Fluttertoast.showToast(msg: e.toString());
// //   //   }
// //   // }

// //   // Future<void> _pickFromGallery() async {
// //   //   Navigator.pop(context);
// //   //   try {
// //   //     final XFile? pickedImage = await ImagePicker()
// //   //         .pickImage(source: ImageSource.gallery, imageQuality: 100);
// //   //     if (pickedImage != null) {
// //   //       setState(() {
// //   //         _pickedImage = File(pickedImage.path);
// //   //       });
// //   //       Fluttertoast.showToast(msg: 'Image Picked From Gallery');
// //   //     }
// //   //   } catch (e) {
// //   //     Fluttertoast.showToast(msg: e.toString());
// //   //   }
// //   // }

// //   // Future<void> _uploadImage() async {
// //   //   try {
// //   //     if (_pickedImage == null) {
// //   //       Fluttertoast.showToast(msg: 'No image selected');
// //   //       return;
// //   //     }

// //   //     String imageName = DateTime.now().millisecondsSinceEpoch.toString();

// //   //     Reference ref =
// //   //         FirebaseStorage.instance.ref().child('images/$imageName.jpg');

// //   //     await ref.putFile(_pickedImage!).then((taskSnapshot) async {
// //   //       String imageUrl = await taskSnapshot.ref.getDownloadURL();

// //   //       await FirebaseFirestore.instance.collection('products').add(
// //   //             AssetsModel(
// //   //               category: _categoryController.text,
// //   //               productName: _nameController.text,
// //   //               productDescription: _descriptionController.text,
// //   //               price: double.parse(_priceController.text),
// //   //               phoneNumber: int.parse(_phoneNumberC.text),
// //   //               photoURL: imageUrl,
// //   //             ).toJson(),
// //   //           );

// //   //       Fluttertoast.showToast(msg: 'Image uploaded successfully');
// //   //     });
// //   //   } catch (e) {
// //   //     Fluttertoast.showToast(msg: 'Error uploading image: $e');
// //   //   }
// //   // }

  

