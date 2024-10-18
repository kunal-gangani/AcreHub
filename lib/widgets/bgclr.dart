import 'package:flutter/material.dart';

class Bgclr extends StatefulWidget {
  const Bgclr({super.key});

  @override
  State<Bgclr> createState() => _BgclrState();
}

class _BgclrState extends State<Bgclr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE2EFFD),
              Color(0xFFD9EAFB),
              Color(0xFFCFE5F9),
              Color(0xFFC5E0F7),
              Color(0xFFBBDBF5),
              Color(0xFFB1D4F0),
              Color(0xFFA6CDEB),
              Color(0xFF9CC6E6),
              Color(0xFF90BCDD),
              Color(0xFF84B1D4),
              Color(0xFF77A7CC),
              Color(0xFF6B9DC3),
            ],
          ),
        ),
      ),
    );
  }
}
