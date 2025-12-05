import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/resource.dart';
import 'package:catalago_colecionadores/src/core/ui/widgets/app_default_especial_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PosStartScreen extends StatelessWidget {
  const PosStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: CatalagoColecionadorTheme
          .blackGround, // <-- cor de fundo preta para toda a tela
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                  style: CatalagoColecionadorTheme.titleSmallStyle.copyWith(
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
                  style: CatalagoColecionadorTheme.titleSmallStyle.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white, // descrição em branco translúcido
                  ),
                ),
              ),
              const SizedBox(height: 22),
              Column(
                children: [
                  AppDefaultEspecialButton(
                    onPressed: () async {
                      context.go('/login');
                    },
                    label: "Entrar",
                    width: sizeOf.width * .84,
                    height: 48,
                  ),
                  const SizedBox(height: 12),
                  AppDefaultEspecialButton(
                    onPressed: () {},
                    label: "",
                    width: sizeOf.width * .84,
                    height: 48,
                    widget: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          R.ASSETS_IMAGES_GOOGLE_LOGO2_PNG,
                          width: 38.0,
                          height: 38.0,
                        ),
                        const SizedBox(width: 12),
                        const Text('Entrar com Google'),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: CatalagoColecionadorTheme.whiteColor,
                      backgroundColor:
                          CatalagoColecionadorTheme.blackClaroColor,
                      side: const BorderSide(
                        color: CatalagoColecionadorTheme.blackClaroColor,
                      ), // contorno branco
                    ),
                  ),
                  const SizedBox(height: 12),
                  AppDefaultEspecialButton(
                    onPressed: () async {
                      context.go('/login');
                    },
                    label: "",
                    width: sizeOf.width * .84,
                    height: 48,
                    widget: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          R.ASSETS_IMAGES_FACEBOOK_LOGO_PNG,
                          width: 38.0,
                          height: 38.0,
                        ),
                        const SizedBox(width: 16),
                        const Text('Entrar com Facebook'),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: CatalagoColecionadorTheme.whiteColor,
                      backgroundColor:
                          CatalagoColecionadorTheme.blackClaroColor,
                      side: const BorderSide(
                        color: CatalagoColecionadorTheme.blackClaroColor,
                      ), // contorno branco
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: sizeOf.width * .84,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () async {
                        context.go('/registro');
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: CatalagoColecionadorTheme.whiteColor,
                        backgroundColor: CatalagoColecionadorTheme.bgCard,
                        side: const BorderSide(
                          color: CatalagoColecionadorTheme.bgCard,
                        ),
                      ),
                      child: Text(
                        'Criar conta',
                        style: CatalagoColecionadorTheme.titleSmallStyle
                            .copyWith(
                              color: CatalagoColecionadorTheme.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: sizeOf.width * .84,
                    height: 48,
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                          style: CatalagoColecionadorTheme.titleSmallStyle
                              .copyWith(
                                color: CatalagoColecionadorTheme.blackColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                          children: [
                            const TextSpan(text: 'Esqueceu sua senha? '),
                            TextSpan(
                              text: 'Click aqui.',
                              style: CatalagoColecionadorTheme.titleSmallStyle
                                  .copyWith(
                                    color: CatalagoColecionadorTheme.whiteColor,
                                    fontSize: 14,
                                    decoration: TextDecoration.underline,
                                  ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // launchUrl(
                                  //   Uri.parse('https://www.openai.com'),
                                  //   mode: LaunchMode.externalApplication,
                                  // );
                                },
                            ),
                          ],
                        ),
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
