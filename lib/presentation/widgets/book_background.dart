import 'package:flutter/material.dart';

class BookBackground extends StatelessWidget {
  const BookBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Image.asset(
      'assets/book_background.png',
      opacity: const AlwaysStoppedAnimation(.3),
      fit: BoxFit.cover,
      height: size.height,
      // width: size.width,
    );
  }
}