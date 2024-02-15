import 'package:flutter/material.dart';
import 'package:zameen_zpp/components/drawer_components.dart';
import 'package:zameen_zpp/models/carousel_slider_model/carousel_slider_model.dart';
import 'package:zameen_zpp/models/ui_models/carousel_slider_model.dart';
import 'package:zameen_zpp/screen/home_screen/user_profile_screen.dart';
import 'package:zameen_zpp/screen/search_screen/search_screen.dart';
import 'package:zameen_zpp/sell_buy/products_in_category.dart';
import 'package:zameen_zpp/sell_buy/seller.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0), // Adjust the height as needed
        child: ClipPath(
          clipper: AppBarClipper(),
          child: Container(
            color: Color.fromARGB(255, 12, 67, 111),
            child: AppBar(
              backgroundColor: Color(0xFFC8291D),
              title: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome To ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Zameen App',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              centerTitle: true,
              actions: [
                ///icon button
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: drawerComponent(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            CarouselSliderWidget(
              // Carousel slider widget
              imagePaths:
                  carouselSliderModel.map((value) => value.imageUrl).toList(),
              names: carouselSliderModel.map((value) => value.title).toList(),
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'SELECT THE CATEGORY',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Divider(),
                Card(
                    color: Color.fromARGB(255, 240, 228, 228),
                    child: CategoryItem(category: 'LAND')),
                Card(
                    color: Color.fromARGB(255, 240, 228, 228),
                    child: CategoryItem(category: 'HOUSE')),
                Card(
                    color: Color.fromARGB(255, 240, 228, 228),
                    child: CategoryItem(category: 'SHOPS')),
                Card(
                    color: Color.fromARGB(255, 240, 228, 228),
                    child: CategoryItem(category: 'FACTORIES')),
                Card(
                    color: Color.fromARGB(255, 240, 228, 228),
                    child: CategoryItem(category: 'BUILDINGS')),
                Card(
                    color: Color.fromARGB(255, 240, 228, 228),
                    child: CategoryItem(category: 'HOTELS')),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sell_rounded),
            label: 'Seller Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'User',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 1:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SellScreen()));
              break;
            case 2:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserProfileScreen()));

              break;
          }
        },
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String category;

  const CategoryItem({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: Text(category),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ProductsInCategoryScreen(category: category),
            ),
          );
        },
      ),
    );
  }
}

class AppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height); // Start from bottom-left
    path.quadraticBezierTo(size.width / 2, size.height * 0.7, size.width,
        size.height); // Curve to bottom-right
    path.lineTo(size.width, 0); // Line to top-right
    path.quadraticBezierTo(
        size.width / 2, size.height * 0, 0, 0); // Curve to top-left
    path.close(); // Close the path
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
