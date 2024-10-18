import 'package:flutter/material.dart';

class Lrbgclr extends StatefulWidget {
  const Lrbgclr({super.key});

  @override
  State<Lrbgclr> createState() => _LrbgclrState();
}

class _LrbgclrState extends State<Lrbgclr> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFE2EFFD),
            Color(0xFFC4D7EE),
            Color(0xFFA7C0DE),
            Color(0xFF8BA9CF),
            Color(0xFF7092C0),
            Color(0xFF6185B7),
            Color(0xFF5379AF),
            Color(0xFF446CA6),
            Color(0xFF3E66A1),
            Color(0xFF395F9C),
            Color(0xFF335997),
            Color(0xFF2E5392),
            // Color(0xFFE2EFFD),
            // Color(0xFFD9EAFB),
            // Color(0xFFCFE5F9),
            // Color(0xFFC5E0F7),
            // Color(0xFFBBDBF5),
            // Color(0xFFB1D4F0),
            // Color(0xFFA6CDEB),
            // Color(0xFF9CC6E6),
            // Color(0xFF90BCDD),
            // Color(0xFF84B1D4),
            // Color(0xFF77A7CC),
            // Color(0xFF6B9DC3),
          ],
        ),
      ),
    );
  }
}
