import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zameen_zpp/privacy_policy/privacy_policy.dart';
import 'package:zameen_zpp/rate_app/rate_app.dart';
import 'package:zameen_zpp/screen/credentials/login_screen.dart';

Widget drawerComponent(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return Scaffold(
    backgroundColor: const Color(0xFFC8291D),
    appBar: AppBar(
      backgroundColor: const Color(0xFFC8291D),
      title: const Text(
        'Drawer',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      centerTitle: true,
    ),
    drawer: Drawer(
      backgroundColor: const Color(0xFFC8291D),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const SizedBox(
            height: 200,
            child: Center(
              child: Text(
                'Drawer ',
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
                    MaterialPageRoute(builder: (_) {
                      return RateApp();
                    }),
                    (route) => false,
                  );
                }, Icons.rate_review, 'Rate App'),
                const Divider(),
                _listTileComponent(context, () async {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) {
                      return PrivacyPolicy();
                    }),
                    (route) => false,
                  );
                }, Icons.privacy_tip, 'Privacy Policy'),
                const Divider(),
                _listTileComponent(context, () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) {
                      return LogInScreen();
                    }),
                    (route) => false,
                  );
                }, Icons.logout, 'LogOut'),
                Divider(),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _listTileComponent(
  BuildContext context,
  void Function()? onTap,
  IconData leadingIcon,
  String title,
) {
  return Column(
    children: [
      ListTile(
        onTap: onTap,
        leading: Icon(leadingIcon),
        title: Text(title),
        trailing: Icon(Icons.forward_outlined),
      )
    ],
  );
}
