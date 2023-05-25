import 'package:flutter/material.dart';

class SplashScren extends StatelessWidget {
  const SplashScren({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // SvgPicture.asset(IconAssets.logo),
                const SizedBox(height: 28),
                Flexible(
                  child: Text(
                    'Blood Donation',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
