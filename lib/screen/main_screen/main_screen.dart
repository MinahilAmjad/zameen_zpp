import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zameen_zpp/models/seller_model/seller_profile_model.dart';
import 'package:zameen_zpp/sell_buy/product_detail_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, String? searchQuery}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late TextEditingController searchController;
  TextEditingController nameController = TextEditingController();

  List<SellerProfileModel> allProducts = [];
  List<SellerProfileModel> displayedProducts = [];

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    fetchProducts();
  }

  void fetchProducts() async {
    try {
      QuerySnapshot<Object?> querySnapshot =
          await FirebaseFirestore.instance.collection('all_products').get();

      List<SellerProfileModel> products = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return SellerProfileModel.fromJson(data);
      }).toList();

      setState(() {
        allProducts = products;
        displayedProducts = allProducts;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void filterProducts(String query) {
    List<SellerProfileModel> filteredProducts = allProducts
        .where((product) =>
            product.productName?.toLowerCase().contains(query.toLowerCase()) ==
            true)
        .toList();

    setState(() {
      displayedProducts = filteredProducts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Search...',
          ),
          onChanged: (query) {
            filterProducts(query);
          },
        ),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.7,
        ),
        itemCount: displayedProducts.length,
        itemBuilder: (context, index) {
          SellerProfileModel product = displayedProducts[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(product: product),
                ),
              );
            },
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        image: product.imageUrls != null &&
                                product.imageUrls!.isNotEmpty
                            ? DecorationImage(
                                image: NetworkImage(product.imageUrls![0]),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.productName ?? 'N/A',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '${product.price ?? 'N/A'}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
