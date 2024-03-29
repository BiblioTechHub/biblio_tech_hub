import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:biblio_tech_hub/config/router/app_router.dart';
import 'package:biblio_tech_hub/config/theme/app_theme.dart';
import 'package:biblio_tech_hub/firebase_options.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Asegurar que Flutter esté inicializado
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
    );
  }
}
