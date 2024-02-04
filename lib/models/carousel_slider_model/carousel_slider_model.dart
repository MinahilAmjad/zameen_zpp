import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselSliderWidget extends StatelessWidget {
  final List<String>? imagePaths;
  final List<String>? names;

  const CarouselSliderWidget({required this.imagePaths, required this.names});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 0.8,
      ),
      items: imagePaths?.asMap().entries.map((entry) {
        int index = entry.key;
        String imagePath = entry.value;
        String name = names![index];

        return Container(
          margin: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  color: Color.fromARGB(96, 45, 95, 142),
                  child: Text(
                    name,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// Example usage:
// CarouselSliderWidget(imagePaths: yourImagePathsList, names: yourNamesList);



// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';

// import 'package:zameen_zpp/widgets/carousel_slider_model.dart';

// CarouselSlider carouselSlider() {
//   return CarouselSlider(
//     items: carouselSliderModel.map((carouselModelValue) {
//       return Card(
//         child: Container(
//           width: double.infinity,
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               fit: BoxFit.cover,
//               image: CachedNetworkImageProvider(
//                   carouselModelValue.imageUrl.toString()),
//             ),
//           ),
//           child: Align(
//               alignment: Alignment.bottomLeft,
//               child: Container(
//                   width: double.infinity,
//                   color: Color.fromARGB(96, 45, 95, 142),
//                   child: Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Text(
//                       carouselModelValue.title.toString(),
//                       style: const TextStyle(
//                           color: Colors.white, fontWeight: FontWeight.bold),
//                     ),
//                   ))),
//         ),
//       );
//     }).toList(),
//     options: CarouselOptions(
//       autoPlay: true,
//       aspectRatio: 12 / 9,
//       initialPage: 0,
//     ),
//   );
// }
