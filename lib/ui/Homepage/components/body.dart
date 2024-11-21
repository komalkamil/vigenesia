import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_vigenesia/ui/Regis/regis.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'background.dart';
import 'package:new_vigenesia/constants.dart';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Map<String, dynamic>? userData;

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString('user_data');

    if (userString != null) {
      setState(() {
        userData = json.decode(userString);
      });
    }

    try {
      final respon = await http
          .get(Uri.parse('http://localhost:8080/vigenesia/api/Get_motivasi'));
      if (respon.statusCode == 200) {
        final data = jsonDecode(respon.body);
        setState(() {
          _listdata = data;
          _loading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Hapus semua data di SharedPreferences

    Navigator.pushReplacementNamed(context, '/login');
  }

  List _listdata = [];
  bool _loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text.rich(
          maxLines: 1,
          TextSpan(
            text: 'ViGe', // Bagian pertama teks
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  color: Color(0xFF10375c),
                  fontSize: 24,
                  fontWeight: FontWeight.w700),
            ), // Warna biru
            children: <TextSpan>[
              TextSpan(
                text: 'Nesia', // Bagian kedua teks
                style: TextStyle(
                    color: Color(0xFFF3C623), fontSize: 24), // Warna oranye
              ),
            ],
          ),
        ),
        actions: [
          Text('Halo, ${userData!['nama']}'),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _listdata.length,
              itemBuilder: ((context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.blueAccent,
                              child: Text(
                                _listdata[index]['nama'][0],
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(width: 10.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _listdata[index]['nama'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      _listdata[index]['tanggal_input'],
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Text(_listdata[index]['isi_motivasi']),
                        SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.comment, color: Colors.grey, size: 20),
                            Icon(Icons.repeat, color: Colors.grey, size: 20),
                            Icon(Icons.favorite_border,
                                color: Colors.grey, size: 20),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
    );
  }
}
