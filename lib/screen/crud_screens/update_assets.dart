import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:zameen_zpp/constants/constants.dart';

class UpdateAssetsScreen extends StatelessWidget {
  const UpdateAssetsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: AppUtils.customProgressIndicator());
          }
          if (!snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No products available to Update.'),
            );
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                final productData = snapshot.data!.docs[index];
                TextEditingController nameController = TextEditingController();

                TextEditingController productNameController =
                    TextEditingController();
                TextEditingController descriptionController =
                    TextEditingController();

                TextEditingController priceController = TextEditingController();
                TextEditingController phoneNumberC = TextEditingController();

                ///
                productNameController.text =
                    productData['productName'].toString();
                nameController.text = productData['name'].toString();
                descriptionController.text =
                    productData['description'].toString();
                priceController.text = productData['price'].toString();
                phoneNumberC.text = productData['phoneNumber'].toString();

                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListTile(
                      leading: CircleAvatar(
                          child:
                              Center(child: Text(productData['productName']))),
                      title: Text(productData['name']),
                      subtitle: Text(productData['description']),
                      trailing: Text(productData['phoneNumber'].toString()),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: Text('Update Product'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    controller: productNameController,
                                    decoration: InputDecoration(
                                      hintText: "productName",
                                    ),
                                  ),
                                  TextFormField(
                                    controller: nameController,
                                    decoration: InputDecoration(
                                      hintText: " name",
                                    ),
                                  ),
                                  TextFormField(
                                    controller: descriptionController,
                                    decoration: InputDecoration(
                                      hintText: "description",
                                    ),
                                  ),
                                  TextFormField(
                                    controller: priceController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: "price",
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                MaterialButton(
                                  shape: StadiumBorder(),
                                  color: Colors.red,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    await FirebaseFirestore.instance
                                        .collection('products')
                                        .doc(productData.id)
                                        .update({
                                          'productName':
                                              productNameController.text,
                                          'name': nameController.text,
                                          'description':
                                              descriptionController.text,
                                          'price':
                                              int.parse(priceController.text),
                                          'phoneNumber': phoneNumberC.text,
                                        })
                                        .whenComplete(
                                            () => Navigator.pop(context))
                                        .then((value) => Fluttertoast.showToast(
                                            msg:
                                                'Updated ${nameController.text}'));
                                  },
                                  child: Text("Update"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: AppUtils.customProgressIndicator());
          }
        },
      ),
    );
  }
}
