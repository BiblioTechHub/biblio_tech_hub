import 'package:flutter/material.dart';


class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/book_background.png',
            opacity: const AlwaysStoppedAnimation(.5),
          ),
          const _LogoAndTitle()
        ],
      )
    );
  }
}

class _LogoAndTitle extends StatelessWidget {
  const _LogoAndTitle();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 2.5)
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(
                  border: Border(right: BorderSide(width: 2.5))
                ),
                child: Image.asset(
                  'assets/logo.jpeg',
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.009),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Biblio', style: _textStyle(context)),
                  Text('Tech', style: _textStyle(context)),
                  Text('Hub', style: _textStyle(context))
                ],
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.02)
              
            ],
          ),
        )
      ],
    );
  }

  TextStyle _textStyle(BuildContext context){
    return TextStyle(
      fontFamily: 'Bangers', 
      fontSize: MediaQuery.of(context).size.height * 0.04
    );
  }
}