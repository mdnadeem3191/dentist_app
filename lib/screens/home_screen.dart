import 'package:dentist_app/screens/detail_screen.dart';
import 'package:dentist_app/services/google_maps._service.dart';
import 'package:dentist_app/widget/star_widget.dart';
import 'package:flutter/material.dart';

import '../models/dentist_model.dart';
import '../models/lat_lng.dart';
import '../widget/app_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoogleMapsService googleMapsService = GoogleMapsService();

  List<DentistModel> nearbyDentist = [];
  bool isLoading = true;
  
  @override
// void didChangeDependencies() {

//     super.didChangeDependencies();
// }
  @override
  void initState() {
    super.initState();
    getDentistData();
  }

  Future<void> getDentistData() async {
    nearbyDentist = await googleMapsService.getDentist();
    Future.delayed(const Duration(seconds: 0), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double height50 = MediaQuery.of(context).size.height / 17.05;

    double height15 = MediaQuery.of(context).size.height / 56.838;
    double height20 = MediaQuery.of(context).size.height / 42.62;

    return isLoading
        ? Scaffold(
            backgroundColor: const Color(0xff01d8d0),
            body: Column(
              children: [
                Stack(children: [
                  const SizedBox(),
                  SizedBox(
                    height: height50 * 8,
                    child: Image.asset(
                      "images/book1.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ]),
                Container(
                  padding: EdgeInsets.symmetric(vertical: height15),
                  child: Column(
                    children: [
                      const Text(
                        "We are looking dentist near you",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: height50 + height50 / 2,
                      ),
                      const CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ],
                  ),
                )
              ],
            ))
        : Scaffold(
            backgroundColor: const Color(0xff9edcf0),
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                "Dentist near you",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              //

              backgroundColor: Colors.lightBlue[600],
            ),
            drawer: const AppDrawer(),
            body: Padding(
                padding: EdgeInsets.all(height20 / 5 * 2),
                child: ListView.builder(
                  itemCount: nearbyDentist.length,
                  itemBuilder: (context, index) {
                    // int hexColor = int.parse(nearbyDentist[index]
                    //     .iconBackgroundColor
                    //     .replaceFirst('#', '0xff${index * 875}'));
                    // print(hexColor);

                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: Colors.white,
                      // margin: const EdgeInsets.symmetric(
                      //     vertical: 10, horizontal: 10),
                      elevation: 5,
                      child: GestureDetector(
                        onTap: () async {

                          LatLngModel latlng = await googleMapsService
                              .getLatLng(nearbyDentist[index].placeId);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                      placeId: nearbyDentist[index].placeId,
                                      ratingStar: nearbyDentist[index].rating,
                                      totalReviews:
                                          nearbyDentist[index].totalReviews,
                                      name: nearbyDentist[index].name,
                                      address: nearbyDentist[index].address,
                                      phoneNumber: latlng.phoneNumber,
                                    )),
                          );
                        },
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: height15, vertical: height20 / 2),
                          leading: CircleAvatar(
                            // backgroundColor: Color(hexColor),
                            child: Text(
                                nearbyDentist[index].name[0].toUpperCase()),
                          ),
                          title: Text((nearbyDentist[index].name).length > 60
                              ? "${nearbyDentist[index].name.substring(0, 60)}..."
                              : nearbyDentist[index].name),
                          subtitle: Row(
                            children: [
                              Text(
                                nearbyDentist[index].rating.toString(),
                                style: const TextStyle(fontSize: 16),
                              ),
                              IconTheme(
                                  data: const IconThemeData(
                                      size: 22,
                                      color: Color.fromARGB(255, 241, 200, 51)),
                                  child: StarDisplay(
                                    value: nearbyDentist[index].rating,
                                  )),
                              Text(
                                ("(${nearbyDentist[index].totalReviews.toString()})"),
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          trailing: nearbyDentist[index].isOpen
                              ? const Text(
                                  "Open",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 40, 144, 44),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                )
                              : const Text(
                                  "Close",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                        ),
                      ),
                    );
                  },
                )),
          );
  }
}
