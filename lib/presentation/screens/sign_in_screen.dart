import 'package:biblio_tech_hub/infrastructure/services/google_services.dart';
import 'package:biblio_tech_hub/presentation/riverpod/book_details_view_provider.dart';
import 'package:biblio_tech_hub/presentation/riverpod/borrows_provider.dart';
import 'package:biblio_tech_hub/presentation/riverpod/user_provider.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:biblio_tech_hub/presentation/widgets/widgets.dart';


class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; 
    
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          const Expanded(
            child: BookBackground()
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const LogoAndTitle(),
              SizedBox(height: size.width * 0.2),
              const SignInGoogleButton(),
              SizedBox(height: size.width * 0.03),
              const GuestButton()
            ],
          )
        ],
      ),
    );
  }
}

class GuestButton extends ConsumerWidget {
  const GuestButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.fromLTRB(5, 3, 12, 3),
        backgroundColor: const Color(0xFFFAC700),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),

      ), 
      icon: const Icon(Icons.person, color: Colors.black, size: 38),
      label: const Text('Continuar como invitado', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),),
      onPressed: () {
        ref.read(userProvider.notifier).signIn(null, false);
        context.go('/home/0');
      }, 
    );
  }
}

class SignInGoogleButton extends ConsumerWidget {
  const SignInGoogleButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.fromLTRB(3, 3, 12, 3),
        backgroundColor: const Color.fromRGBO(66, 133, 244, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),

      ), 
      icon: ClipRRect(
        borderRadius: BorderRadius.circular(3),
        child: Container(
          color: Colors.white,
          child: Image.asset('assets/sign_in_google.png', width: size.width * 0.1)
        ),
      ), 
      label: const Text('Inicia sesión con Google', style: TextStyle(color: Colors.white),),
      onPressed: () async {
        User? user = await GoogleServices.signIn();
        if(context.mounted && user != null){
          ref.read(userProvider.notifier).signIn(user, true);
          ref.read(borrowsProvider.notifier).getBorrows();
          print(ref.read(bookDetailsViewProvider).title);
          context.go('/home/0');
        }  
      }, 
    );
  }
}