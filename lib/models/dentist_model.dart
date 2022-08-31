class DentistModel {
  String name;
  String address;
  String placeId;
  String iconBackgroundColor;
  double rating;
  int totalReviews;
  // String imageUrl;

  bool isOpen;

  // double latitude;
  // double longitude;

  DentistModel({
    required this.name,
    required this.address,
    required this.placeId,
    required this.iconBackgroundColor,
    required this.rating,
    required this.totalReviews,
    required this.isOpen,
    // required this.imageUrl,
    // required this.latitude,
    // required this.longitude,
  });
}
