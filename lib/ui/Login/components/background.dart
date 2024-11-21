import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: -70,
            left: -70,
            child: Image.asset(
              "assets/images/blue_spark.png",
              width: size.width * 0.3,
            ),
          ),
          Positioned(
            bottom: -60,
            right: -60,
            child: Image.asset(
              "assets/images/yellow_spark.png",
              width: size.width * 0.3,
            ),
          ),
          Positioned(
            bottom: -100,
            right: -100,
            child: Image.asset(
              "assets/images/blue_spark.png",
              width: size.width * 0.5,
            ),
          ),
          child, // Tambahkan child di sini agar tampil di atas background
        ],
      ),
    );
  }
}
