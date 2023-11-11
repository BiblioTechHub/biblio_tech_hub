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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const LogoAndTitle(),
              SizedBox(height: MediaQuery.of(context).size.width * 0.2),
              const SignInGoogleButton(),
              SizedBox(height: MediaQuery.of(context).size.width * 0.03),
              const GuestButton()
            ],
          )
        ],
      )
    );
  }
}

class GuestButton extends StatelessWidget {
  const GuestButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.fromLTRB(5, 3, 12, 3),
        backgroundColor: const Color(0xFFFAC700),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),

      ), 
      icon: const Icon(Icons.person, color: Colors.black),
      label: const Text('Continuar como invitado', style: TextStyle(color: Colors.white),),
      onPressed: () {
        //TODO 
      }, 
    );
  }
}

class SignInGoogleButton extends StatelessWidget {
  const SignInGoogleButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.fromLTRB(3, 3, 12, 3),
        backgroundColor: const Color.fromRGBO(66, 133, 244, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3.0),
        ),

      ), 
      icon: ClipRRect(
        borderRadius: BorderRadius.circular(3),
        child: Container(
          color: Colors.white,
          child: Image.asset('assets/sign_in_google.png', width: MediaQuery.of(context).size.width * 0.1)
        ),
      ), 
      label: const Text('Sign up with Google', style: TextStyle(color: Colors.white),),
      onPressed: () {
        //TODO 
      }, 
    );
  }
}

class LogoAndTitle extends StatelessWidget {
  const LogoAndTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
              'assets/logo.jpeg',
              height: MediaQuery.of(context).size.height * 0.2,
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.009),
          Column(
            children: [
              Text('Biblio', style: _textStyle(context)),
              Text('Tech', style: TextStyle(fontFamily: 'Bangers', fontSize: MediaQuery.of(context).size.height * 0.04)),
              Text('Hub', style: TextStyle(fontFamily: 'Bangers', fontSize: MediaQuery.of(context).size.height * 0.04))
            ],
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.02)
          
        ],
      ),
    );
  }

  TextStyle _textStyle(BuildContext context){ 
    return TextStyle(
      fontFamily: 'Bangers', 
      fontSize: MediaQuery.of(context).size.height * 0.04
    );
  }
}