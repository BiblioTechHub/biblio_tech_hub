import 'package:biblio_tech_hub/presentation/blocs/cubit/user_cubit.dart';
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 3)
              ),
              child: Image.network(
                width: size.width * 0.4,
                fit: BoxFit.cover,
                user?.photoURL ?? 'https://i.pinimg.com/originals/6f/57/76/6f57760966a796644b8cfb0fbc449843.png'
              )
            ),
            SizedBox(height: size.height * 0.1),

            Text('¡Bienvenid@,', style: TextStyle(fontSize: size.height * 0.03, fontWeight: FontWeight.bold)),
            Text(
              user?.displayName ?? 'Invitad@', 
              style: TextStyle(fontSize: size.height * 0.03, fontWeight: FontWeight.bold))
          ],
        ),
      )
    );
  }
}