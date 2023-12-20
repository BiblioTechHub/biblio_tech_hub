import 'package:biblio_tech_hub/presentation/riverpod/user_provider.dart';
import 'package:biblio_tech_hub/presentation/widgets/app_logo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final User? user = ref.watch(userProvider).user;
    //Hacer find(user.email) -> Nº préstamos
    final userName = user?.displayName ?? 'Invitad@';
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.067),
            const AppLogo(),
            SizedBox(height: size.height * 0.05),

            _ImageProfile(size: size, user: user),
            SizedBox(height: size.height * 0.05),
        
            Text('¡Bienvenid@,', style: _textStyle(size)),
            Text(
              '$userName!',
              style: _textStyle(size)
            ),
            SizedBox(height: size.height * 0.05),
        
            _Email(user: user, size: size),
            SizedBox(height: size.height * 0.03),
        
            _Leans(user: user, size: size),
            SizedBox(height: size.height * 0.07),
        
            _SignOutButton(size: size),

          ],
        ),
      )
    );
  }

  TextStyle _textStyle(Size size) => TextStyle(fontSize: size.height * 0.03, fontWeight: FontWeight.bold);
}

class _ImageProfile extends StatelessWidget {
  const _ImageProfile({
    required this.size,
    required this.user,
  });

  final Size size;
  final User? user;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 3)
      ),
      child: user?.photoURL != null
        ? Image.network(
            width: size.width * 0.4,
            fit: BoxFit.cover,
            user?.photoURL ?? ''
          )
        : Image.asset(
            width: size.width * 0.4,
            fit: BoxFit.cover,
            'assets/profile_guest.png'
          )
    );
  }
}

class _SignOutButton extends ConsumerWidget {
  const _SignOutButton({required this.size});

  final Size size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    return SizedBox(
      width: size.width * 0.4,
      height: size.height * 0.06,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          
          backgroundColor: const Color.fromARGB(255, 216, 41, 41),
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(10)
          ),
        ),
        child: const Text('Cerrar Sesión', style: TextStyle(color: Colors.black)),
        onPressed: () {
          ref.read(userProvider.notifier).signOut();
        }
      ),
    );
  }
}

class _Email extends StatelessWidget {
  const _Email({
    required this.user, required this.size,
  });

  final Size size;
  final User? user;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(size.height * 0.009),
          decoration: BoxDecoration(border: Border.all(width: 2), color: Colors.white),
          child: const Text('E-mail', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Container(
          padding: EdgeInsets.all(size.height * 0.009),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 2), 
              top: BorderSide(width: 2), 
              right: BorderSide(width: 2)
            ),
            color: Colors.white
          ),
          child: Text(user?.email ?? 'Invitad@'),
        )
      ],
    );
  }
}

class _Leans extends StatelessWidget {
  const _Leans({
    required this.user, required this.size,
  });

  final Size size;
  final User? user;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(size.height * 0.009),
          decoration: BoxDecoration(border: Border.all(width: 2), color: Colors.white),
          child: const Text('Nº Préstamos Activos', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Container(
          padding: EdgeInsets.all(size.height * 0.009),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 2), 
              top: BorderSide(width: 2), 
              right: BorderSide(width: 2)
            ),
            color: Colors.white
          ),
          //TODO: Implementar el numero de prestamos
          child: const Text('XX'),
          //Text(user?.borrows.length ?? 'XX'),
        )
      ],
    );
  }
}
