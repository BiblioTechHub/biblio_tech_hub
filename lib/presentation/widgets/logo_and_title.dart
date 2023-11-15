import 'package:flutter/material.dart';

class LogoAndTitle extends StatelessWidget {
  const LogoAndTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 2.5)
      ),
      // child: Text('Hola'),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(right: BorderSide(width: 2.5))
            ),
            child: Image.asset(
              'assets/logo.png',
              height: MediaQuery.of(context).size.height * 0.2,
            ),
          ),
          SizedBox(width: size.width * 0.02),
          Column(
            children: [
              Text('Biblio', style: TextStyle(fontFamily: 'Bangers', fontSize: size.height * 0.04)),
              Text('Tech', style: TextStyle(fontFamily: 'Bangers', fontSize: size.height * 0.04)),
              Text('Hub', style: TextStyle(fontFamily: 'Bangers', fontSize: size.height * 0.04))
            ],
          ),
          SizedBox(width: size.width * 0.02)
          
        ],
      ),
    );
  }

  TextStyle _textStyle(BuildContext context, Size size){ 
    return TextStyle(
      fontFamily: 'Bangers', 
      fontSize: size.height * 0.04
    );
  }
}