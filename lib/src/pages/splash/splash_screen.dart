import 'dart:async';
import 'dart:math';

import 'package:catalago_colecionadores/src/core/ui/theme/resource.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    final seconds = 3 + Random().nextInt(6);
    _timer = Timer(Duration(seconds: seconds), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed('/start');
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            R.ASSETS_IMAGES_BG_MINHA_COLECAO_PNG,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            constraints: BoxConstraints.expand(),
            color: Colors.black.withAlpha(170),
          ),
          Positioned(
            top: sizeOf.height * 0.14, // ajuste a altura vertical
            left: 3, // ajuste a distância da borda esquerda
            width: sizeOf.width * 1, // largura máxima do texto
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              constraints: BoxConstraints(maxWidth: sizeOf.width * .8),
              child: Text(
                "Minha Coleção",
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.yellowAccent,
                  shadows: [
                    Shadow(
                      offset: Offset(3, 3), // deslocamento da sombra
                      blurRadius: 4.0, // suavização da sombra
                      color: Colors.white60, // cor da sombra
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Center(
            child: Image.asset(R.ASSETS_IMAGES_LOGO_CARROS_COLECIOANDOR_PNG),
          ),
        ],
      ),
    );
  }
}
