import 'package:app_agendamento/core/device/app_external_launcher.dart';
import 'package:app_agendamento/core/di/di.dart';
import 'package:app_agendamento/features/intro/widgets/intro_base_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MaintenancePage extends StatelessWidget {
  const MaintenancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(
            child: IntroBasePage(
              imagePath: 'assets/intro/maintenance.svg',
              title: 'App em Manutenção',
              body:
                  'Nosso app está passando por melhorias. Acompanhe nossas redes sociais para receber novidades!',
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 64),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      getIt<AppExternalLauncher>()
                          .launchUrl('https://twitter.com');
                    },
                    child: SvgPicture.asset(
                      'assets/social/twitter.svg',
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
