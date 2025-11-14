import 'package:catalago_colecionadores/src/ui/core/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/ui/core/theme/resource.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor:
          Colors.blueGrey, // <-- cor de fundo preta para toda a tela
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // --- CAPA SUPERIOR ---
              Container(
                width: double.infinity,
                height: 250,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(R.ASSETS_IMAGES_CAPA_START_PNG),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // --- TÍTULO ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: const Text(
                  'Colecionador de Miniaturas',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color:
                        CatalagoColecionadorTheme.whiteColor, // texto em branco
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // --- DESCRIÇÃO ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: const Text(
                  'Acompanhe, gerencie e exiba sua coleção de miniaturas com facilidade. Descubra novos modelos, conecte-se com outros colecionadores e mantenha-se atualizado sobre os últimos lançamentos.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white, // descrição em branco translúcido
                  ),
                ),
              ),

              const SizedBox(height: 22),

              Column(
                children: [
                  SizedBox(
                    width: sizeOf.width * .84,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(
                          color: CatalagoColecionadorTheme.blueColor,
                        ), // contorno branco
                      ),
                      child: const Text('Começar'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: sizeOf.width * .84,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor:
                            CatalagoColecionadorTheme.blackClaroColor,
                        side: const BorderSide(
                          color: CatalagoColecionadorTheme.blackClaroColor,
                        ), // contorno branco
                      ),
                      child: const Text('Enter'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
