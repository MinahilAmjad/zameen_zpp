import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zameen_zpp/screen/home_screen/user_screen/user_activity_life_screen.dart';
import 'package:zameen_zpp/screen/home_screen/user_profile_screen.dart';
import 'package:zameen_zpp/screen/main_screen/main_screen.dart';
import 'package:zameen_zpp/screen/search_screen/search_screen.dart';
import 'package:zameen_zpp/sell_buy/google_maps.dart';
import 'package:zameen_zpp/sell_buy/seller.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Zameen App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 20, 97, 14),
        ),
        cardTheme: const CardTheme(color: Colors.white),
        primaryColor: Colors.deepPurple,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Color.fromARGB(255, 92, 14, 38),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
        useMaterial3: true,
      ),
      routes: {
        '/home': (context) => MainScreen(
              searchQuery: '',
            ),
        '/search': (context) => SearchScreen(),
        '/sell': (context) => SellScreen(),
        '/user_profile': (context) => const UserProfileScreen(),
      },
      home: UserActivityCycleScreen(),
    );
  }
}
