import 'package:flutter/material.dart';
import 'package:zameen_zpp/privacy_policy/privacy_policy.dart';
import 'package:zameen_zpp/rate_app/rate_app.dart';
import 'package:zameen_zpp/screen/settings/settings.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UserProfileScreen'),
      ),
      body: Column(
        children: [
          CircleAvatar(
            radius: 90,
            backgroundImage: AssetImage('assets/images/logo.zameen.jpg'),
          ),
////////

          SizedBox(height: 10),
          Divider(),
          _listTileComponent(context, () async {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (_) {
              return RateApp();
            }), (route) => false);
          }, Icons.privacy_tip, 'Rate App'),
          Divider(),
          ////
          _listTileComponent(context, () async {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (_) {
              return PrivacyPolicy();
            }), (route) => false);
          }, Icons.rate_review, 'Privacy Policy'),

          Divider(),
          _listTileComponent(context, () async {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (_) {
              return SettingScreen();
            }), (route) => false);
          }, Icons.view_agenda, 'Setting'),
          Divider(),
        ],
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
        ),
      ],
    );
  }
}



// // import 'package:flutter/material.dart';
// // import 'package:zameen_zpp/sell_buy/buy.dart';
// // import 'package:zameen_zpp/sell_buy/seller.dart';

// // class UserProfileScreen extends StatefulWidget {
// //   const UserProfileScreen({Key? key}) : super(key: key);

// //   @override
// //   _UserProfileScreenState createState() => _UserProfileScreenState();
// // }

// // class _UserProfileScreenState extends State<UserProfileScreen> {
// //   bool isBuyer = false;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('UserProfileScreen'),
// //       ),
// //       body: Column(
// //         children: [
// //           SwitchListTile(
// //             value: isBuyer,
// //             onChanged: (value) {
// //               setState(() {
// //                 isBuyer = value;
// //               });
// //             },
// //             title: Text(
// //               isBuyer ? 'Switched to Buyer Mode' : 'Switched to Seller Mode',
// //             ),
// //           ),
// //           SizedBox(height: 20),
// //           Expanded(
// //             child: isBuyer ? BuyScreen() : SellScreen(),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // class BuyerScreen extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       color: Colors.blue,
// //       child: Center(
// //         child: Text(
// //           'Buyer Screen',
// //           style: TextStyle(color: Colors.white),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // class SellerScreen extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       color: Colors.orange,
// //       child: Center(
// //         child: Text(
// //           'Seller Screen',
// //           style: TextStyle(color: Colors.white),
// //         ),
// //       ),
// //     );
// //   }
// // }


// // // import 'package:flutter/material.dart';

// // // class UserProfileScreen extends StatelessWidget {
// // //   const UserProfileScreen({Key? key}) : super(key: key);
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     bool value = false;
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('UserProfileScreen'),
// // //       ),
// // //       body: Column(
// // //         children: [
// // //           SwitchListTile(
// // //             value: value,
// // //             onChanged: (value) {},
// // //             title: Text(
// // //               value == false
// // //                   ? 'Switched to Buyer Mode'
// // //                   : 'Switched to Seller Mode',
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }
