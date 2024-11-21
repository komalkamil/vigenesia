import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_vigenesia/ui/Createpage/create.dart';
import 'package:new_vigenesia/ui/Homepage/homepage.dart';
import 'package:new_vigenesia/ui/Profilepage/profilepage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> _children = [const HomePage(), const ProfilePage()];
  int currentIndex = 0;
  void onTapTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[currentIndex],
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFFF3C623),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          IconButton(
              onPressed: () {
                onTapTapped(0);
              },
              icon: const Icon(Icons.home)),
          const SizedBox(
            width: 20,
          ),
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(
                        MaterialPageRoute(builder: (context) => const Create()))
                    .then((value) {
                  setState(() {});
                });
              },
              icon: const Icon(Icons.add)),
          const SizedBox(
            width: 20,
          ),
          IconButton(
              onPressed: () {
                onTapTapped(1);
              },
              icon: const Icon(Icons.list))
        ]),
      ),
    );
  }
}
