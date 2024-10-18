import 'package:acrehub/screens/Homesrn.dart';
import 'package:acrehub/screens/adddetail.dart';
import 'package:acrehub/screens/favoritesrn.dart';
import 'package:acrehub/screens/profilesrn.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  //Bottom Navigation bar start
  int cindex = 0;
  final screens = [
    const Homeesrn(),
    const Favoritesrn(),
    const Addpropertydtil(),
    const Profilesrn(),
  ];
  final items = [
    const Icon(Icons.home, size: 30),
    const Icon(Icons.favorite, size: 30),
    const Icon(Icons.add, size: 30),
    const Icon(Icons.person, size: 30),
  ];
  //Bottom end
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: ClipRect(
        child: Scaffold(
          extendBody: true,
          body: screens[cindex],
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              iconTheme: const IconThemeData(
                color: Color.fromARGB(255, 26, 166, 89),
              ),
            ),
            child: CurvedNavigationBar(
              backgroundColor: Colors.transparent,
              height: 60,
              animationCurve: Curves.easeInOut,
              animationDuration: const Duration(milliseconds: 300),
              index: cindex,
              items: items,
              // ignore: unnecessary_this
              onTap: (index) => setState(() => this.cindex = index),
            ),
          ),
        ),
      ),
    );
  }
}
