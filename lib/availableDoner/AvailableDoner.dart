import 'package:blood_donations/availableDoner/a_positive.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:blood_donations/AvailableDoner/a_negative.dart';
import 'package:blood_donations/AvailableDoner/ab_negative.dart';
import 'package:blood_donations/AvailableDoner/ab_positive.dart';
import 'package:blood_donations/AvailableDoner/b_negative.dart';
import 'package:blood_donations/AvailableDoner/b_positive.dart';
import 'package:blood_donations/AvailableDoner/o_negative.dart';
import 'package:blood_donations/AvailableDoner/o_positive.dart';
import 'package:blood_donations/widgets/custom_app_bar.dart';
import 'package:blood_donations/widgets/my_button.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;

class AvailableDoner extends StatefulWidget {
  const AvailableDoner({Key? key}) : super(key: key);

  @override
  State<AvailableDoner> createState() => _AvailableDonerState();
}

class _AvailableDonerState extends State<AvailableDoner> {
  void _currentLocation() async {
    /////   final GoogleMapController controller = _googleMapController!;
    loc.LocationData? currentLocation;
    var location = loc.Location();
    try {
      currentLocation = await location.getLocation();
    } on Exception {
      currentLocation = null;
    }
    final postion = LatLng(currentLocation!.latitude!.toDouble(),
        currentLocation.longitude!.toDouble());

    // await controller.animateCamera(
    //   CameraUpdate.newCameraPosition(
    //     CameraPosition(
    //       bearing: 0,
    //       target: postion as LatLng,
    //       zoom: 17.5,
    //     ),
    //   ),
    // );
    final a = Geolocator.distanceBetween(
        30.163311, 72.686029, postion.latitude, postion.longitude);
    double diameter = 4844.385653020778;
    if (diameter < a) {
      Fluttertoast.showToast(
          msg: 'You cannot add request Because You are out of Burewala');
      Navigator.of(context).pop();
    }
//     Fluttertoast.showToast(msg: msg)

    // _liveLocation = Marker(
    //   markerId: const MarkerId('Live Location'),
    //   infoWindow: const InfoWindow(title: 'Live Location'),
    //   icon: BitmapDescriptor.defaultMarkerWithHue(
    //       BitmapDescriptor.hueMagenta),
    //   position: postion as LatLng,
    // );
    // });
  }

  @override
  void initState() {
    super.initState();
    _currentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Blood Type"),
      body: Column(
        children: [
          SizedBox(height: 40),
          MyButtonWithShawdo(
            onTap: () {
              Get.to(() => APositive());
            },
            title: "A+",
          ),
          SizedBox(height: 10),
          MyButtonWithShawdo(
            onTap: () {
              Get.to(() => ANegative());
            },
            title: "A-",
          ),
          SizedBox(height: 10),
          MyButtonWithShawdo(
            onTap: () {
              Get.to((BPositive()));
            },
            title: "B+",
          ),
          SizedBox(height: 10),
          MyButtonWithShawdo(
            onTap: () {
              Get.to((BNegative()));
            },
            title: "B-",
          ),
          SizedBox(height: 10),
          MyButtonWithShawdo(
            onTap: () {
              Get.to((ABPositive()));
            },
            title: "AB+",
          ),
          SizedBox(height: 10),
          MyButtonWithShawdo(
            onTap: () {
              Get.to((ABNegative()));
            },
            title: "AB-",
          ),
          SizedBox(height: 10),
          MyButtonWithShawdo(
            onTap: () {
              Get.to((OPositive()));
            },
            title: "O+",
          ),
          SizedBox(height: 10),
          MyButtonWithShawdo(
            onTap: () {
              Get.to((ONegative()));
            },
            title: "O-",
          ),
        ],
      ),
    );
  }
}
