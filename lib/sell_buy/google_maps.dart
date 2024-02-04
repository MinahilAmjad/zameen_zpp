import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyGoogleMapPage extends StatefulWidget {
  const MyGoogleMapPage({Key? key}) : super(key: key);

  @override
  State<MyGoogleMapPage> createState() => _MyGoogleMapPageState();
}

class _MyGoogleMapPageState extends State<MyGoogleMapPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(30.666121, 73.102013),
    zoom: 14.4746,
  );

  // Add some markers for demonstration
  Set<Marker> _markers = {
    Marker(
      markerId: MarkerId('marker1'),
      position: LatLng(30.6510, 73.1394),
      infoWindow: InfoWindow(
        title: 'Gulshan e Ali',
        snippet: 'This is Gulshan e Ali',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    ),
    Marker(
      markerId: MarkerId('marker2'),
      position: LatLng(30.628770, 73.089459),
      infoWindow: InfoWindow(
        title: 'Tech 360',
        snippet: 'This is SHAHEEN',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps'),
      ),
      body: GoogleMap(
        mapType: MapType.normal, // Change map type to normal
        initialCameraPosition: _kGooglePlex,
        markers: _markers, // Add markers to the map
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
