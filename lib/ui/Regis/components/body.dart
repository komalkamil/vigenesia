import 'package:flutter/material.dart';
import 'package:new_vigenesia/ui/Login/login.dart';
import 'background.dart';
import 'package:new_vigenesia/constants.dart';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nama = TextEditingController();
  TextEditingController profesi = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future _simpan() async {
    final respon = await http.post(
        Uri.parse('http://localhost:8080/vigenesia/api/registrasi'),
        body: {
          'nama': nama.text,
          'profesi': profesi.text,
          'email': email.text,
          'password': password.text,
        });

    if (respon.statusCode == 200) {
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Form(
        key: formKey,
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
                      "REGISTRASI",
                      style: TextStyle(
                        fontSize: 25, // Ukuran teks
                        color: Colors.black, // Warna teks
                        fontWeight: FontWeight.w100, // Ketebalan teks
                      ),
                    ),
                    SizedBox(height: 20),
                    // Image.asset(
                    //   "assets/images/log_in.png",
                    //   width: size.width * 0.5,
                    // ),
                    TextFormField(
                      controller: nama,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          color: kBlueColor,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        filled: true,
                        fillColor: kWhiteColor,
                        hintText: 'Enter a name...',
                        labelText: 'Name',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Nama tidak boleh kosong!";
                        }
                        return null;
                      },
                      maxLines: 1,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: profesi,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.computer,
                          color: kBlueColor,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        filled: true,
                        fillColor: kWhiteColor,
                        hintText: 'Enter a Profession...',
                        labelText: 'Profession',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "profesi tidak boleh kosong!";
                        }
                        return null;
                      },
                      maxLines: 1,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: email,
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "email tidak boleh kosong!";
                        }
                        return null;
                      },
                      maxLines: 1,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: password,
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "password tidak boleh kosong!";
                        }
                        return null;
                      },
                      maxLines: 1,
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double
                          .infinity, // Lebar tombol akan mengikuti lebar penuh dari textfield
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xffffd207), // Warna tombol
                          foregroundColor: Colors.black, // Warna teks
                          padding: EdgeInsets.symmetric(
                              vertical: 20), // Tinggi tombol
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            _simpan().then((value) {
                              if (value) {
                                final snackBar = const SnackBar(
                                  content: Text('Data berhasil disimpan'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else {
                                final snackBar = const SnackBar(
                                  content: Text('Data gagal disimpan'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            });
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => const LoginPage())),
                                (route) => false);
                          }
                        },
                        child: const Text('REGISTRATION'),
                      ),
                    ),
                    SizedBox(height: 20),
                    const Text(
                      'already have an account?',
                      style: TextStyle(
                        fontSize: 10, // Ukuran teks
                        color: Colors.black, // Warna teks Ketebalan teks
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Arahkan ke halaman Login ketika teks diklik
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: const Text(
                        'Login',
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
      ),
    );
  }
}
