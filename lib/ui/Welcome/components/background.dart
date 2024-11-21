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
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0XFFD5DCFF), // Warna awal (biru terang)
                  Color(0XFFFFFFFF), // Warna akhir (biru muda)
                ],
              ),
            ),
          ),
          child, // Tambahkan child di sini agar tampil di atas background
        ],
      ),
    );
  }
}
