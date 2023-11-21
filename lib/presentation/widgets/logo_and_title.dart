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
              Text('Biblio', style: _textStyle(size)),
              Text('Tech', style: _textStyle(size)),
              Text('Hub', style: _textStyle(size))
            ],
          ),
          SizedBox(width: size.width * 0.02)
          
        ],
      ),
    );
  }

  TextStyle _textStyle(Size size){ 
    return TextStyle(
      fontFamily: 'Bangers', 
      fontSize: size.height * 0.04
    );
  }
}