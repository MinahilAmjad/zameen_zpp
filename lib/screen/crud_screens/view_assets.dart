import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zameen_zpp/constants/constants.dart';
import 'package:zameen_zpp/models/seller_model/seller_profile_model.dart';
import 'package:zameen_zpp/screen/crud_screens/detail_screen/detail_screen.dart';

class ViewAssetsScreen extends StatelessWidget {
  const ViewAssetsScreen({Key? key}) : super(key: key);

//     @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Products'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.active ||
              snapshot.hasData) {
            if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No products available'));
            } else {
              return ListView.separated(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  final productData = snapshot.data!.docs[index];
                  final product = SellerProfileModel.fromJson(
                      productData.data() as Map<String, dynamic>);

                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return AssetsDetailScreen(product: product);
                      }));
                    },
                    child: _productCard(product),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
              );
            }
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Center(child: AppUtils.customProgressIndicator());
          }
        },
      ),
    );
  }

  Card _productCard(SellerProfileModel product) {
    return Card(
      color: Colors.white,
      child: Container(
        height: 300,
        width: 300,
        child: Column(
          children: [
            if (product.imageUrls != null && product.imageUrls!.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: product.imageUrls!.length, // Added null check here
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(5.0),
                      child: Image.network(
                        product.imageUrls![index],
                        fit: BoxFit.contain,
                      ),
                    );
                  },
                ),
              ),
            Divider(),
            ListTile(
              tileColor: Colors.white,
              leading: CircleAvatar(
                child: Center(
                  child: Text(
                    product.productName ?? '',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              title: Text(product.name ?? ''),
              subtitle: Text(product.description ?? ''),
              trailing: Text("Price: ${product.price}"),
            ),
          ],
        ),
      ),
    );
  }
}
