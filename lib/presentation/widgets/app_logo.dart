import 'package:flutter/widgets.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: const BoxDecoration(
            border: Border(right: BorderSide(width: 2.5), bottom: BorderSide(width: 2.5), top: BorderSide(width: 2.5), left: BorderSide(width: 2.5))
          ),
          child: Image.asset(
            'assets/logo.png',
            height: size.height * 0.05,
          ),
        ),
        Column(
          children: [
            Text(' BTH', style: TextStyle(fontFamily: 'Bangers', fontSize: size.height * 0.04)),
          ],
        ),          
      ],
    );
  }
}