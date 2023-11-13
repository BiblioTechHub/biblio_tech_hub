import 'package:biblio_tech_hub/presentation/blocs/cubit/user_cubit.dart';
import 'package:biblio_tech_hub/presentation/widgets/book_background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {

    final User? user = context.watch<UserCubit>().state.user;
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      body: Stack(
        children: [
          const BookBackground(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _ImageProfile(size: size, user: user),
                SizedBox(height: size.height * 0.1),
        
                Text('¡Bienvenid@,', style: _textStyle(size)),
                Text(
                  user?.displayName ?? 'Invitad@', 
                  style: _textStyle(size)
                ),
                SizedBox(height: size.height * 0.05),
        
                _Email(user: user, size: size),
                SizedBox(height: size.height * 0.05),
        
                _Leans(user: user, size: size),
                SizedBox(height: size.height * 0.05),
        
                const _SignInButton()
              ],
            ),
          ),
        ], 
      )
    );
  }

  TextStyle _textStyle(Size size) => TextStyle(fontSize: size.height * 0.03, fontWeight: FontWeight.bold);
}

class _ImageProfile extends StatelessWidget {
  const _ImageProfile({
    super.key,
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
      child: Image.network(
        width: size.width * 0.4,
        fit: BoxFit.cover,
        user?.photoURL ?? 'https://i.pinimg.com/originals/6f/57/76/6f57760966a796644b8cfb0fbc449843.png'
      )
    );
  }
}

class _SignInButton extends StatelessWidget {
  const _SignInButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xffdd5151),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(10)
        )
      ),
      child: const Text('Cerrar Sesión', style: TextStyle(color: Colors.black),),
      onPressed: () {
        context.read<UserCubit>().signOut();
      }
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
          child: const Text('Usuario', style: TextStyle(fontWeight: FontWeight.bold)),
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
          child: Text(user?.email ?? 'invitado@gmail.com'),
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
          child: const Text('Nº Prétamos Activos', style: TextStyle(fontWeight: FontWeight.bold)),
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
          child: const Text('09'),
        )
      ],
    );
  }
}
