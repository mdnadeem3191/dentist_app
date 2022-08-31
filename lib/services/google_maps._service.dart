import 'dart:convert';

import 'package:dentist_app/models/dentist_model.dart';
import 'package:dentist_app/models/lat_lng.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';

class GoogleMapsService {
  String? latitude;
  String? longitude;
  String keyword = 'dentist';
  String type = 'doctor';

  List<DentistModel> nearbyDentist = [];

  String googleMapsApi = "AIzaSyBtDBN5sNOnxXi_aM6Edol3DDrBhbYcliE";

  Future<List<DentistModel>> getDentist() async {
    Position position = await getLocation();
    latitude = position.latitude.toString();
    longitude = position.longitude.toString();

    String url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?keyword=$keyword&location=$latitude%2C$longitude&radius=1500&type=$type&key=$googleMapsApi';
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    List dentistList = data['results'];

    // String imageReference = data['photos'] == null
    //     ? 'AeJbb3cH4R63ELu4Z8yocy7rfFRzbz-0rtCh9sIo0epq7Weo0ka2RZejfzpdDO_w2mP0SkgfNjhmGJmwPpgZR5_wLKhlbER52xcgpCotK79B6VfhFsS8_2xK0RlulI616nsJVHYPaDIrXL1D_mMD407Mthvuesnft90EqWQt-wX0RJwtpmr0'
    //     : data['photos']['photo_reference'];

    // String getImageUrl =
    //     "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=$imageReference&key=$googleMapsApi";

    // Response imageUrl = await get(Uri.parse(getImageUrl));

    for (Map dentist in dentistList) {
      nearbyDentist.add(DentistModel(
        name: dentist['name'],
        address: dentist['vicinity'],
        placeId: dentist['place_id'],
        iconBackgroundColor: dentist['icon_background_color'],
        rating: double.parse(dentist['rating'].toString()),
        isOpen: dentist["opening_hours"] == null
            ? true
            : dentist["opening_hours"]['open_now'],
        totalReviews: dentist['user_ratings_total'],
        // imageUrl: "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=$imageReference&key=$googleMapsApi",
      ));
      // print(dentist["opening_hours"]);

    }

    return nearbyDentist;
  }

  Future<LatLngModel> getLatLng(String placeId) async {
    String url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$googleMapsApi';

    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);

    return LatLngModel(
        latitude: data['result']['geometry']['location']['lat'],
        longitude: data['result']['geometry']['location']['lng'],
        phoneNumber: data['result']['formatted_phone_number"'] ?? "9999696969");
  }

  Future<Position> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
