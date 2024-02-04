import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:zameen_zpp/models/seller_model/seller_profile_model.dart';
import 'package:zameen_zpp/sell_buy/messaging_screen.dart';

class ProductDetailsScreen extends StatelessWidget {
  final SellerProfileModel product;

  const ProductDetailsScreen({Key? key, required this.product})
      : super(key: key);

  void _showImageZoomDialog(BuildContext context, int initialIndex) {
    final Size size = MediaQuery.of(context).size;
    final double maxHeight = size.height - 100.0;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: PhotoViewGallery.builder(
            scrollDirection: Axis.horizontal,
            scrollPhysics: const BouncingScrollPhysics(),
            builder: (BuildContext context, int index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(product.imageUrls![index]),
                initialScale: PhotoViewComputedScale.contained,
                maxScale: maxHeight,
                heroAttributes: PhotoViewHeroAttributes(tag: index),
              );
            },
            itemCount: product.imageUrls!.length,
            pageController: PageController(initialPage: initialIndex),
            onPageChanged: (index) {},
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (product.imageUrls != null && product.imageUrls!.isNotEmpty)
              Container(
                height: 200,
                decoration: BoxDecoration(border: Border.all()),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (int index = 0;
                          index < product.imageUrls!.length;
                          index++)
                        GestureDetector(
                          onTap: () {
                            _showImageZoomDialog(context, index);
                          },
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Image.network(
                                product.imageUrls![index],
                                height: size.height,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            Divider(),
            // Display seller information
            _listTileMethod(Icons.person, product.name!),
            _listTileMethod(Icons.phone, '+92${product.phoneNumber}'),
            _listTileMethod(
                Icons.production_quantity_limits, product.productName!),
            _listTileMethod(Icons.abc, product.description!),
            _listTileMethod(Icons.price_change, '${product.price}'),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const MessagingScreen(sellerName: 'Seller Name'),
                        ),
                      );
                    },
                    child: const Text("Message Seller"),
                  ),
                ),
                const SizedBox(width: 5.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      FlutterPhoneDirectCaller.callNumber(
                          '+92${product.phoneNumber}');
                    },
                    child: const Text("Call Seller"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _listTileMethod(IconData leading, String title) {
    return Column(
      children: [
        ListTile(leading: Icon(leading), title: Text(title)),
        Divider(),
      ],
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:zameen_zpp/models/seller_model/seller_profile_model.dart';
// import 'package:zameen_zpp/sell_buy/messaging_screen.dart';

// class ProductDetailsScreen extends StatelessWidget {
//   final SellerProfileModel product;

//   const ProductDetailsScreen({Key? key, required this.product})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Product Details'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (product.imageUrls != null && product.imageUrls!.isNotEmpty)
//               Container(
//                 height: 200,
//                 decoration: BoxDecoration(border: Border.all()),
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: product.imageUrls!.length,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Image.network(
//                         product.imageUrls![index],
//                         width: 100,
//                         height: 100,
//                         fit: BoxFit.cover,
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             Divider(),
//             // Display seller information
//             _listTileMethod(Icons.person, product.name!),
//             _listTileMethod(Icons.phone, '${product.phoneNumber}'),
//             _listTileMethod(
//                 Icons.production_quantity_limits, product.productName!),
//             _listTileMethod(Icons.abc, product.description!),
//             _listTileMethod(Icons.price_change, '${product.price}'),

//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               const MessagingScreen(sellerName: 'Seller Name'),
//                         ),
//                       );
//                     },
//                     child: const Text("Message Seller"),
//                   ),
//                 ),
//                 SizedBox(width: 5.0),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       ///call
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text("Implement phone call")),
//                       );
//                     },
//                     child: const Text("Call Seller"),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _listTileMethod(IconData leading, String title) {
//     return Column(
//       children: [
//         ListTile(leading: Icon(leading), title: Text(title)),
//         Divider(),
//       ],
//     );
//   }
// }
