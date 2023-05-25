import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blood_donations/constant/all_controler.dart';
import 'package:blood_donations/constant/constant.dart';
import 'package:blood_donations/model/request_model.dart';
import 'package:blood_donations/utils/height_width.dart';
import 'package:blood_donations/utils/show_loading.dart';
import 'package:blood_donations/widgets/custom_app_bar.dart';
import 'package:blood_donations/widgets/custom_drop_down_field.dart';
import 'package:blood_donations/widgets/my_button.dart';
import 'package:blood_donations/widgets/my_text_field.dart';

class EditMyRequest extends StatefulWidget {
  final RequestModel? requestModel;
  final String? id;
  const EditMyRequest({Key? key, this.requestModel, this.id}) : super(key: key);

  @override
  State<EditMyRequest> createState() => _EditMyRequestState();
}

class _EditMyRequestState extends State<EditMyRequest> {
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  RxString selectedBloodGroup = "A+".obs;
  RxString selectedGender = "Male".obs;

  @override
  void initState() {
    cityController.text = widget.requestModel?.city ?? "";
    addressController.text = widget.requestModel?.address ?? "";
    numberController.text = widget.requestModel?.phone ?? "";
    selectedBloodGroup.value = widget.requestModel?.bloodGroup ?? "";
    selectedGender.value = widget.requestModel?.gender ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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

              MyDropDownFormField(
                list: bloodGroupList,
                initialValue: selectedBloodGroup.value,
                validator: (value) => validationController.nameValidator(value),
                dropDownText: "Select Blood",
                hintText: "a",
                onChange: (value) {
                  selectedBloodGroup.value = value;
                },
              ),
              MyDropDownFormField(
                list: genderList,
                initialValue: selectedGender.value,
                validator: (value) => validationController.nameValidator(value),
                dropDownText: "Select Gender",
                hintText: "a",
                onChange: (value) {
                  selectedGender.value = value;
                },
              ),
              // MyTextField(
              //   controller: cityController,
              //   validator: (value) => validationController.nameValidator(value!),
              //   hintText: "City",
              // ),
              MyTextField(
                controller: addressController,
                validator: (value) =>
                    validationController.nameValidator(value!),
                hintText: "Address",
              ),
              MyTextField(
                controller: numberController,
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    validationController.passwordValidatopr(value!),
                hintText: "Number",
              ),

              // MyTextField(
              //   controller: authController.patientNameController,
              //   validator: (value) => validationController.nameValidator(value!),
              //   hintText: "Patient Name",
              // ),
              // MyTextField(
              //   controller: authController.ageController,
              //   validator: (value) => validationController.noValidation(value!),
              //   hintText: "Age",
              // ),
              // MyTextField(
              //   controller: authController.reasonController,
              //   validator: (value) => validationController.nameValidator(value!),
              //   hintText: "Reason",
              // ),
              // MyDateFormField(
              //   controller: authController.dateTimeController.value,
              //   hintText: "Select Date Of Need",
              // ),
              SizedBox(height: height(context, 0.1)),

              MyButton(
                title: "Update",
                onTap: () {
                  submitBloodRequest();
                },
              ),
              const SizedBox(height: 22),
            ],
          ),
        ),
      ),
    );
  }

  submitBloodRequest() async {
    showLoading();
    await ffstore.collection(requestCollection).doc(widget.id).update({
      'bloodGroup': selectedBloodGroup.value,
      'gender': selectedGender.value,
      'address': addressController.text,
      'phone': numberController.text,
    });
    dismissLoadingWidget();
    Get.back();
    showCustomSnackBar(
      title: "Success",
      message: "Request updated successfully",
      seconds: 3,
    );
  }
}
