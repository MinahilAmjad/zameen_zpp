// class AssetsModel {
//   final String? category;
//   final String? Name;
//   final String? Description;
//   final double? price;

//   final int? phoneNumber;
//   final List<String> imageUrls;
//   bool? isSale;
//   bool? isPopular;
//   bool? isInCart;
//   bool? isInFavorite;
//   DateTime? createdAt;

//   AssetsModel({
//     required this.category,
//     required this.Name,
//     required this.Description,
//     required this.price,
//     required this.phoneNumber,
//     required this.imageUrls,
//     this.isSale,
//     this.isPopular,
//     this.isInCart,
//     this.isInFavorite,
//     this.createdAt,
//   });

//   factory AssetsModel.fromJson(Map<String, dynamic> json) {
//     return AssetsModel(
//       category: json['category'] as String?,
//       Name: json['Name'] as String?,
//       Description: json['Description'] as String?,
//       price: (json['price'] as num?)?.toDouble(),
//       phoneNumber: json['phoneNumber'] as int?,
//       imageUrls: List<String>.from(json['imageUrls'] as List<dynamic>),
//       isSale: json['isSale'] as bool?,
//       isPopular: json['isPopular'] as bool?,
//       isInCart: json['isInCart'] as bool?,
//       isInFavorite: json['isInFavorite'] as bool?,
//       createdAt: json['createdAt'] != null
//           ? DateTime.parse(json['createdAt'] as String)
//           : null,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'category': category,
//       'Name': Name,
//       'Description': Description,
//       'price': price,
//       'phoneNumber': phoneNumber,
//       'imageUrls': imageUrls,
//       'isSale': isSale,
//       'isPopular': isPopular,
//       'isInCart': isInCart,
//       'isInFavorite': isInFavorite,
//       'createdAt': createdAt?.toIso8601String(),
//     };
//   }
// }
