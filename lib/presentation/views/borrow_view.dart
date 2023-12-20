import 'package:biblio_tech_hub/presentation/widgets/app_logo.dart';
import 'package:flutter/material.dart';

class LoanView extends StatelessWidget {
  const LoanView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: size.height * 0.067),
          const AppLogo(),
          SizedBox(height: size.height * 0.03),
          Container(
              alignment: Alignment.topLeft,
              height: size.height * 0.77,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20,25,0,0),
                child: Row(
                  children: [
                    Text("Préstamos Activos",
                        style: TextStyle(
                            fontSize: size.height * 0.03,
                            fontFamily: 'Bangers')),
                    Icon(Icons.arrow_forward_ios_outlined, color: Colors.black, size: size.height * 0.03),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
