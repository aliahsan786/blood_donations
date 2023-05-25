import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blood_donations/constant/all_controler.dart';
import 'package:blood_donations/constant/color.dart';
import 'package:blood_donations/constant/constant.dart';
import 'package:blood_donations/screens/profile/edit_profile.dart';
import 'package:blood_donations/utils/height_width.dart';
import 'package:blood_donations/widgets/custom_app_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        suffixIcon: GestureDetector(
          onTap: () => Get.to(() => EditProfile()),
          child: const Icon(Icons.edit, size: 25),
        ),
        title: "Profile",
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headerImage(),
            SizedBox(height: height(context, 0.06)),
            Obx(() {
              return Tiles(title: "${authController.userModel.value.name}");
            }),
            Obx(() {
              return Tiles(title: "${authController.userModel.value.email}");
            }),
            Obx(() {
              return Tiles(title: "${authController.userModel.value.number}");
            }),
            Obx(() {
              return Tiles(
                  title: "${authController.userModel.value.bloodGroup}");
            }),
            Obx(() {
              return Tiles(title: "${authController.userModel.value.gender}");
            }),
          ],
        ),
      ),
    );
  }

  Widget _headerImage() => Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            height: curveHeight,
            child: CustomPaint(painter: _MyPainter()),
          ),
          Hero(
            tag: 'profilePicHero',
            child: Obx(() {
              return Container(
                width: avatarDiameter,
                height: avatarDiameter,
                decoration: const BoxDecoration(
                    color: AppColors.accent, shape: BoxShape.circle),
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  (authController.userModel.value.imgUrl != null &&
                          authController.userModel.value.imgUrl != "")
                      ? "${authController.userModel.value.imgUrl}"
                      : imagePlaceHolder,
                  fit: BoxFit.cover,
                  errorBuilder: (
                    BuildContext context,
                    Object exception,
                    StackTrace? stackTrace,
                  ) =>
                      const Text(' '),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Center(
                        child: SizedBox(
                          height: 45,
                          width: 45,
                          child: CircularProgressIndicator(
                            color: kTertiaryColor,
                          ),
                        ),
                      );
                    }
                  },
                ),
              );
            }),
          ),
        ],
      );
}

class Tiles extends StatelessWidget {
  final String? title;

  const Tiles({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.16),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          title ?? "",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

const avatarRadius = 60.0;
const avatarDiameter = avatarRadius * 2;
const curveHeight = avatarRadius * 2.5;

/// Source: https://gist.github.com/tarek360/c94a82f9554caf8f6b62c4fcf140272f
class _MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..color = AppColors.primary;

    const topLeft = Offset(0, 0);
    final bottomLeft = Offset(0, size.height * 0.25);
    final topRight = Offset(size.width, 0);
    final bottomRight = Offset(size.width, size.height * 0.25);

    final leftCurveControlPoint =
        Offset(size.width * 0.2, size.height - avatarRadius * 0.8);
    final rightCurveControlPoint = Offset(size.width - leftCurveControlPoint.dx,
        size.height - avatarRadius * 0.8);

    final avatarLeftPoint =
        Offset(size.width * 0.5 - avatarRadius + 5, size.height * 0.5);
    final avatarRightPoint =
        Offset(size.width * 0.5 + avatarRadius - 5, avatarLeftPoint.dy);

    final avatarTopPoint =
        Offset(size.width / 2, size.height / 2 - avatarRadius);

    final path = Path()
      ..moveTo(topLeft.dx, topLeft.dy)
      ..lineTo(bottomLeft.dx, bottomLeft.dy)
      ..quadraticBezierTo(leftCurveControlPoint.dx, leftCurveControlPoint.dy,
          avatarLeftPoint.dx, avatarLeftPoint.dy)
      ..arcToPoint(avatarTopPoint, radius: const Radius.circular(avatarRadius))
      ..lineTo(size.width / 2, 0)
      ..close();

    final path2 = Path()
      ..moveTo(topRight.dx, topRight.dy)
      ..lineTo(bottomRight.dx, bottomRight.dy)
      ..quadraticBezierTo(rightCurveControlPoint.dx, rightCurveControlPoint.dy,
          avatarRightPoint.dx, avatarRightPoint.dy)
      ..arcToPoint(avatarTopPoint,
          radius: const Radius.circular(avatarRadius), clockwise: false)
      ..lineTo(size.width / 2, 0)
      ..close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
