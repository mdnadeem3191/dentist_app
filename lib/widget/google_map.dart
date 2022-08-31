import 'package:dentist_app/services/google_maps._service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapWidget extends StatelessWidget {
  final double latitude;
  final double longitude;

  GoogleMapWidget({Key? key, required this.latitude, required this.longitude})
      : super(key: key);

  final GoogleMapsService googleMapsService = GoogleMapsService();

  @override
  Widget build(BuildContext context) {
    double height20 = MediaQuery.of(context).size.height / 42.62;

    return Scaffold(
        body: Stack(children: [
      GoogleMap(
        markers: {
          Marker(
            markerId: const MarkerId('value'),
            position: LatLng(latitude, longitude),
          ),
        },
        initialCameraPosition: CameraPosition(
          // bearing: 192.8334901395799,
          target: LatLng(
            latitude,
            longitude,
          ),
          // tilt: 59.440717697143555,
          zoom: 19.151926040649414,
        ),
      ),
      Positioned(
        top: 35,
        left: height20 / 2,
        child: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.black.withOpacity(0.4),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 27,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ]));
  }
}
