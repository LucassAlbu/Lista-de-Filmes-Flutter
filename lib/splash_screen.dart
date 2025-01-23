import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Navega para a tela inicial após 3 segundos
    Future.delayed(Duration(seconds: 3), () {
      Get.off(HomeScreen());
    });

    return Scaffold(
      backgroundColor: Colors.black, // Fundo escuro para consistência
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(size: 100, style: FlutterLogoStyle.stacked, textColor: Colors.blueGrey), // Logo estilizado
            SizedBox(height: 20),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blueGrey), // Indicador com cor consistente
            ),
          ],
        ),
      ),
    );
  }
}
