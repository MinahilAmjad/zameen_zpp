class SellerProfileModel {
  final String? name;
  final String? productName;
  final String? description;
  final List<String>? imageUrls; // Assuming imageUrls is a list of strings
  final double? price;
  final int? phoneNumber;
  final String? productType;
  final String? latitude;
  final String? longitude;

  SellerProfileModel({
    this.name,
    this.productName,
    this.description,
    this.imageUrls,
    this.price,
    this.phoneNumber,
    this.productType,
    this.latitude,
    this.longitude,
  });

  factory SellerProfileModel.fromJson(Map<String, dynamic> json) {
    return SellerProfileModel(
      name: json['name'] as String?,
      productName: json['productName'] as String?,
      description: json['description'] as String?,
      imageUrls: List<String>.from(json['imageUrls'] as List<dynamic>? ?? []),
      price: (json['price'] as num?)?.toDouble(),
      phoneNumber: json['phoneNumber'] != null
          ? int.tryParse(json['phoneNumber'].toString())
          : null,
      productType: json['productType'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'productName': productName,
      'description': description,
      'imageUrls': imageUrls,
      'price': price,
      'phoneNumber': phoneNumber,
      'productType': productType,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
