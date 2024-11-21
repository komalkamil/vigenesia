import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_vigenesia/ui/Homepage/homepage.dart';
import 'package:new_vigenesia/ui/Regis/regis.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:new_vigenesia/ui/Regis/regis.dart';
import 'background.dart';
import 'package:new_vigenesia/constants.dart';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  // const Body({super.key});
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String? nama;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  // Fungsi Login
  Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Email dan password wajib diisi")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse(
        'http://localhost:8080/vigenesia/api/login'); // Ganti dengan URL API Anda

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print(responseData);

        // Simpan sesi user ke SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('is_logged_in', true);
        await prefs.setString('user_data', json.encode(responseData['data']));
        print(prefs);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['message'])),
        );

        // Navigasi ke halaman utama
        Navigator.pushReplacementNamed(context, '/main');
      } else {
        final errorMessage = response.body.isNotEmpty
            ? json.decode(response.body)
            : 'Login gagal. Periksa email dan password Anda.';

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Terjadi kesalahan: $error")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

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
                  const Text(
                    "LOGIN",
                    style: TextStyle(
                      fontSize: 25, // Ukuran teks
                      color: Colors.black, // Warna teks
                      fontWeight: FontWeight.w100, // Ketebalan teks
                    ),
                  ),
                  Image.asset(
                    "assets/images/log_in.png",
                    width: size.width * 0.5,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: kBlueColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                      filled: true,
                      fillColor: kWhiteColor,
                      hintText: 'Enter an email...',
                      labelText: 'Email',
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock,
                        color: kBlueColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                      filled: true,
                      fillColor: kWhiteColor,
                      hintText: 'Enter a password...',
                      labelText: 'Password',
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double
                        .infinity, // Lebar tombol akan mengikuti lebar penuh dari textfield
                    child: _isLoading
                        ? CircularProgressIndicator()
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xffffd207), // Warna tombol
                              foregroundColor: Colors.black, // Warna teks
                              padding: EdgeInsets.symmetric(
                                  vertical: 20), // Tinggi tombol
                            ),
                            onPressed: _login,
                            child: const Text('LOGIN'),
                          ),
                  ),
                  SizedBox(height: 20),
                  const Text(
                    "don't have an account yet?",
                    style: TextStyle(
                      fontSize: 10, // Ukuran teks
                      color: Colors.black, // Warna teks Ketebalan teks
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Arahkan ke halaman Registrasi ketika teks diklik
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisPage()),
                      );
                    },
                    child: const Text(
                      'Registration',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration
                            .underline, // Garis bawah teks untuk memberi kesan link
                        fontSize: 15,
                      ),
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
