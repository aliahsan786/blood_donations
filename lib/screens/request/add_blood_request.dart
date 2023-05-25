import 'dart:developer';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
//03085744390
import 'package:firebase_storage/firebase_storage.dart';
import 'package:location/location.dart' as loc;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:blood_donations/constant/all_controler.dart';
import 'package:blood_donations/constant/constant.dart';
import 'package:blood_donations/model/request_model.dart';
import 'package:blood_donations/utils/height_width.dart';
import 'package:blood_donations/utils/show_loading.dart';
import 'package:blood_donations/widgets/custom_app_bar.dart';
import 'package:blood_donations/widgets/custom_date_form_field.dart';
import 'package:blood_donations/widgets/custom_drop_down_field.dart';
import 'package:blood_donations/widgets/my_button.dart';
import 'package:blood_donations/widgets/my_text_field.dart';
import 'package:velocity_x/velocity_x.dart';

class AddBloodRequest extends StatefulWidget {
  const AddBloodRequest({Key? key}) : super(key: key);

  @override
  State<AddBloodRequest> createState() => _AddBloodRequestState();
}

class _AddBloodRequestState extends State<AddBloodRequest> {
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(30.163024517394014, 72.68623016774654),
    zoom: 12,
  );
  GoogleMapController? _googleMapController;
  bool _isInBurawala = false;
  TextEditingController _addressPonits = TextEditingController();
  Marker? _origin;
  Marker? _destination;

  Marker? _liveLocation;
  LatLngBounds cityBounds = LatLngBounds(
    southwest:
        const LatLng(30.1574, 72.6751), // Southwest coordinate of Burawala
    northeast:
        const LatLng(30.1687, 72.6972), // Northeast coordinate of Burawala
  );
  LatLngBounds hasilpur = LatLngBounds(
    southwest: LatLng(29.671055, 72.522586), // Southwest coordinate of Hasilpur
    northeast: LatLng(29.721433, 72.584278), // Northeast coordinate of Hasilpur
  );

  @override
  void dispose() {
    _googleMapController!.dispose();
    super.dispose();
  }

  LatLng? postion;
  @override
  Widget build(BuildContext context) {
    authController.dateOfNeedController.value.text =
        DateFormat.yMMMd().format(DateTime.now());

    void _currentLocation() async {
      _isInBurawala = false;
      final GoogleMapController controller = _googleMapController!;
      loc.LocationData? currentLocation;
      var location = loc.Location();
      try {
        currentLocation = await location.getLocation();
      } on Exception {
        currentLocation = null;
      }
      postion = LatLng(currentLocation!.latitude!.toDouble(),
          currentLocation.longitude!.toDouble());
      if (!hasilpur.contains(postion!)) {
        print('Your are out of city $postion');
        return;
      }
      await controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            bearing: 0,
            target: postion as LatLng,
            zoom: 17.5,
          ),
        ),
      );
      final a = Geolocator.distanceBetween(
          30.163311, 72.686029, postion!.latitude, postion!.longitude);
      double diameter = 4844.385653020778;
      if (diameter < a) {
        Fluttertoast.showToast(
            msg: 'You cannot add request Because You are out of Burewala');
        _isInBurawala = true;
      }
//     Fluttertoast.showToast(msg: msg)

      setState(() {
        setState(() {
          _addressPonits.text = '${postion!.latitude} , ${postion!.longitude}';
        });

        _liveLocation = Marker(
          markerId: const MarkerId('Live Location'),
          infoWindow: const InfoWindow(title: 'Live Location'),
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueMagenta),
          position: postion as LatLng,
        );
      });
    }

    void _addMarker(LatLng pos) async {
      if (_origin == null || (_origin != null && _destination != null)) {
        //origin is not set or origin and distinaton is set
        setState(() {
          _origin = Marker(
            markerId: const MarkerId('origin'),
            infoWindow: const InfoWindow(title: 'Origin'),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen),
            position: pos,
          );
          _destination = null;
        });
      } else {
        //origin is set but no destination is set
        setState(() {
          _destination = Marker(
            markerId: const MarkerId('destination'),
            infoWindow: const InfoWindow(title: 'Destination'),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            position: pos,
          );
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Request For Blood"),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: authController.signUpKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              SizedBox(height: height(context, 0.05)),
              MyTextField(
                keyboardType: TextInputType.name,
                controller: authController.patientNameController,
                validator: (value) => validationController.noValidation(value!),
                hintText: "Patient Name",
              ),
              MyTextField(
                keyboardType: TextInputType.datetime,
                controller: authController.ageController,
                validator: (value) => validationController.noValidation(value!),
                hintText: "Age",
              ),
              MyTextField(
                controller: authController.patientPhoneController,
                keyboardType: TextInputType.phone,
                validator: (value) => validationController.noValidation(value!),
                hintText: "Number",
              ),
              MyTextField(
                controller: _addressPonits,
                keyboardType: TextInputType.url,
                validator: (value) => validationController.noValidation(value!),
                hintText: "Select address from map",
              ),
              Container(
                margin: const EdgeInsets.all(15),
                height: 200,
                decoration: BoxDecoration(border: Border.all()),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    GoogleMap(
                      myLocationEnabled: true,
                      cameraTargetBounds: CameraTargetBounds(cityBounds),
                      onMapCreated: (controller) {
                        _googleMapController = controller;
                      },
                      minMaxZoomPreference: const MinMaxZoomPreference(0, 14),
                      zoomControlsEnabled: true,
                      //     myLocationButtonEnabled: true,
                      zoomGesturesEnabled: true,
                      initialCameraPosition: _initialCameraPosition,
                      markers: {
                        // if (_origin != null) _origin as Marker,
                        // if (_destination != null) _destination as Marker,
                        if (_liveLocation != null) _liveLocation as Marker,
                      },
                      onLongPress: _addMarker,
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        foregroundColor: Theme.of(context).primaryColor,
                        // ignore: avoid_print
                        onPressed: () {
                          _currentLocation();
                          // print('hello $_info');
                          // _googleMapController!.animateCamera(
                          //   _info != null
                          //       ? CameraUpdate.newLatLngBounds(_info!.bounds, 100)
                          //       : CameraUpdate.newCameraPosition(_initialCameraPosition),
                          // );
                        },
                        child: const Icon(Icons.my_location_sharp),
                      ),
                    ),
                  ],
                ),
                // FloatingActionButton(
                //   backgroundColor: Colors.white,
                //   foregroundColor: Theme.of(context).primaryColor,
                //   // ignore: avoid_print
                //   onPressed: () {
                //     _currentLocation();
                //     // print('hello $_info');
                //     // _googleMapController!.animateCamera(
                //     //   _info != null
                //     //       ? CameraUpdate.newLatLngBounds(_info!.bounds, 100)
                //     //       : CameraUpdate.newCameraPosition(_initialCameraPosition),
                //     // );
                //   },
                //   child: const Icon(Icons.my_location_sharp),
                // ),
              ),
              //  MyTextField(
              //     controller: authController.cityController,
              //     validator: (value) =>
              //         validationController.cityValidator(value!),
              //     hintText: "City",
              //   ),
              //   MyTextField(
              //     controller: authController.addressController,
              //    validator: (value) =>
              //        validationController.addressValidator(value!),
              //    hintText: "Address",
              //   ),
              MyTextField(
                controller: authController.reasonController,
                validator: (value) =>
                    validationController.reasonValidator(value!),
                hintText: "Reason",
              ),
              MyDateFormField(
                controller: authController.dateOfNeedController.value,
                hintText: "Select Date Of Birth",
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(
                      DateTime.now().year,
                      DateTime.now().month + 1,
                      DateTime.now().day,
                    ),
                  );

                  if (pickedDate != null) {
                    authController.dateOfNeedController.value.text =
                        DateFormat.yMMMd().format(pickedDate);
                    log("Select Date Of Birth ${authController.dateOfNeedController.value.text}");
                  } else {
                    //something here
                    return "Please Select Date Of Birth ";
                  }
                },
              ),
              const SizedBox(height: 12),
              MyDropDownFormField(
                list: genderList,
                initialValue: authController.selectedGender.value,
                validator: (value) => validationController.noValidation(value),
                dropDownText: "Select Gender",
                hintText: "a",
                onChange: (value) {
                  authController.selectedGender.value = value;
                },
              ),
              MyDropDownFormField(
                list: bloodGroupList,
                initialValue: authController.selectedBloodGroup.value,
                validator: (value) => validationController.nameValidator(value),
                dropDownText: "Select Blood",
                hintText: "a",
                onChange: (value) {
                  authController.selectedBloodGroup.value = value;
                },
              ),
              MyDropDownFormField(
                list: requestType,
                initialValue: authController.selectedRequestType.value,
                validator: (value) => validationController.nameValidator(value),
                dropDownText: "Select Request Type",
                hintText: "a",
                onChange: (value) {
                  authController.selectedRequestType.value = value;
                  log("Select Request Type ${authController.selectedRequestType.value}");
                },
              ),
              25.heightBox,
              Obx(() {
                if (authController.selectedRequestType.value ==
                    "Emergency Request") {
                  return _image != null
                      ? GestureDetector(
                          onTap: () {
                            getImage();
                          },
                          child: Container(
                            height: 220,
                            width: MediaQuery.of(context).size.width - 25,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.blue,
                                width: 2,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Image.file(
                              _image!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            getImage();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.blue,
                                width: 2,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(35),
                              ),
                            ),
                            height: 220,
                            width: MediaQuery.of(context).size.width - 25,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.add_a_photo_outlined,
                                  size: 40,
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  "Add Description Image",
                                  style: GoogleFonts.laila(
                                    textStyle:
                                        Theme.of(context).textTheme.headline6,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                }

                return Container();
              }),
              20.heightBox,
              MyButton(
                title: "Submit",
                onTap: () {
                  submitBloodRequest();
                },
              ),
              const SizedBox(height: 22),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  RxString imgUrl = "".obs;
  File? _image;

  //FirstImage
  Future getImage() async {
    final pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = File(pickedFile?.path ?? "");
    });
  }

  Future uploadPhoto() async {
    try {
      showLoading();
      Reference ref = storageReference
          .child('BloodRequestImages/${DateTime.now().toString()}');
      await ref.putFile(_image!);
      await ref.getDownloadURL().then((value) {
        log('Profile Image URL $value');
        imgUrl.value = value;
      });
      dismissLoadingWidget();
    } catch (e) {
      dismissLoadingWidget();
      log("Exception $e");
    }
  }

  submitBloodRequest() async {
    if (_isInBurawala) {
      Fluttertoast.showToast(
          msg: 'You cannot add request Because You are out of Burawala');
      _isInBurawala = true;
      return;
    }

    showLoading();
    authController.selectedRequestType.value == "Emergency Request"
        ? await uploadPhoto()
        : null;
    await Future.delayed(const Duration(seconds: 1));
    RequestModel requestModel = RequestModel(
      userId: authController.userModel.value.currentUserId,
      name: authController.patientNameController.text,
      age: int.parse(authController.ageController.text),
      phone: authController.patientPhoneController.text,
      city: authController.cityController.text,
      address: _addressPonits.text,
      reason: authController.reasonController.text,
      needDate: authController.dateOfNeedController.value.text,
      gender: authController.selectedGender.value,
      bloodGroup: authController.selectedBloodGroup.value,
      description: "",
      imgUrl: authController.selectedRequestType.value == "Emergency Request"
          ? imgUrl.value
          : "",
      isAcceptedById: "",
      isAcceptedByImgUrl: "",
      isAcceptedByName: "",
      otherBlood: "",
      otherBloodList: [],
      requestedDate: DateTime.now().millisecondsSinceEpoch.toString(),
      requestType: authController.selectedRequestType.value,
    );
    await ffstore.collection(requestCollection).add(requestModel.toJson());
    dismissLoadingWidget();
    Get.back();
    showCustomSnackBar(
        title: "Success", message: "Request added successfully ");
  }
}
