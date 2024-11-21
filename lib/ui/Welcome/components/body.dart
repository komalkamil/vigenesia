import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:new_vigenesia/constants.dart';
import 'package:new_vigenesia/ui/Login/login.dart';
import 'package:new_vigenesia/ui/Regis/regis.dart';
import 'background.dart';
// import 'package:new_vigenesia/constants.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Scrollbar(
        child: Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0), // Menambahkan padding kiri pada teks
                    child: Text(
                      "WELCOME",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ),
                  Image.asset(
                    "assets/images/vigenesia.png",
                    width: size.width * 0.63,
                  ),
                  SizedBox(height: 20),
                  const Text(
                    "Inspire the young generation of Indonesia with information and education according to their interests",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15, // Ukuran teks
                      color: Colors.grey, // Warna teks
                      fontWeight: FontWeight.w100, // Ketebalan teks
                    ),
                  ),
                  SizedBox(height: 100),
                  SizedBox(
                    width: double
                        .infinity, // Lebar tombol akan mengikuti lebar penuh dari textfield
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kYellowColor, // Warna tombol
                        foregroundColor: Colors.black, // Warna teks
                        padding:
                            EdgeInsets.symmetric(vertical: 20), // Tinggi tombol
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisPage()));
                      },
                      child: const Text('REGISTER'),
                    ),
                  ),
                  SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'I already have an account.', // Teks pertama
                          style: TextStyle(
                            color: Colors.grey[600], // Warna teks pertama
                            fontSize: 15, // Ukuran teks// Ketebalan teks
                          ),
                        ),
                        TextSpan(
                          text: ' Login', // Teks kedua
                          style: TextStyle(
                            color: Colors.grey[700], // Warna teks kedua
                            fontSize: 15, // Ukuran teks
                            fontWeight: FontWeight.bold, // Ketebalan teks
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      LoginPage(), // Ganti dengan halaman login Anda
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
