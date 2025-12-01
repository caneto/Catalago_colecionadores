import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/resource.dart';
import 'package:catalago_colecionadores/src/core/ui/widgets/app_default_especial_button.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor:
          CatalagoColecionadorTheme.blackGround, // <-- cor de fundo preta para toda a tela
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'Colecionador de Miniaturas',
                  textAlign: TextAlign.center,
                  style: CatalagoColecionadorTheme.titleStyle.copyWith(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color:
                        CatalagoColecionadorTheme.whiteColor, // texto em branco
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'Acompanhe, gerencie e exiba sua coleção de miniaturas com facilidade. Descubra novos modelos, conecte-se com outros colecionadores e mantenha-se atualizado sobre os últimos lançamentos.',
                  textAlign: TextAlign.center,
                  style: CatalagoColecionadorTheme.titleStyle.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: CatalagoColecionadorTheme.whiteColor, // descrição em branco translúcido
                  ),
                ),
              ),

              const SizedBox(height: 22),
              Column(
                children: [
                  AppDefaultEspecialButton(
                    onPressed: () async {
                      Navigator.of(context).pushReplacementNamed('/pos_start');
                    },
                    label: "Entrar",
                    width: sizeOf.width * .84,
                    height: 48,
                    widget: const Text('Começar'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: CatalagoColecionadorTheme.whiteColor,
                      side: const BorderSide(
                        color: CatalagoColecionadorTheme.blueColor,
                      ), 
                    ),
                  ),
                  const SizedBox(height: 12),
                  AppDefaultEspecialButton(
                    onPressed: () async {
                      Navigator.of(context).pushReplacementNamed('/login');
                    },
                    label: "Entrar",
                    width: sizeOf.width * .84,
                    height: 48,
                    widget: const Text('Entrar'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: CatalagoColecionadorTheme.whiteColor,
                      backgroundColor:
                          CatalagoColecionadorTheme.blackClaroColor,
                      side: const BorderSide(
                        color: CatalagoColecionadorTheme.blackClaroColor,
                      ),
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
