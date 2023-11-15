import 'package:biblio_tech_hub/presentation/widgets/app_logo.dart';
import 'package:flutter/material.dart';

class LoanView extends StatelessWidget {
  const LoanView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppLogo(),
            Text('Loan View'),],
        )
      ),
    );
  }
}