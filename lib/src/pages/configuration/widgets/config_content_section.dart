import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'config_detail_card.dart';
import 'config_section.dart';

// --- CONFIG CONTENT ---
class ConfigContentSection extends StatelessWidget {
  const ConfigContentSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Structure as per HTML blocks
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConfigSection(
          title: 'Notificações',
          children: [
            ConfigDetailCard(
              iconUrl: 'notification_option.svg',
              title: 'Notificações de Lançamentos',
              subtitle: 'Gerenciar notificações para novos lançamentos',
              switchActivity: true,
            ),
            SizedBox(height: 4),
            ConfigDetailCard(
              iconUrl: 'notification_option.svg',
              title: 'Notificações de mudanças de preço',
              subtitle:
                  'Receba alertas sobre novos modelos e mudanças de preço',
              switchActivity: true,
            ),
          ],
        ),
        SizedBox(height: 14),
        // Conta
        ConfigSection(
          title: 'Preferencias',
          children: [
            ConfigDetailCard(
              iconUrl: 'visibilidade.svg',
              title: 'Visibilidade da coleção',
              subtitle: 'Torne sua coleção visível para outros usuários',
              switchActivity: true,
            ),
          ],
        ),
        SizedBox(height: 14),
        InkWell(
          onTap: () {},
          child: ConfigSection(
            title: 'Conta',
            children: [
              ConfigDetailCard(
                iconUrl: 'account.svg',
                title: 'Informações da conta',
                subtitle: 'Gerenciar informações da conta',
                withIcon: true,
              ),
            ],
          ),
        ),
        SizedBox(height: 14),
        // Preferências
        ConfigSection(
          title: 'Preferências',
          children: [
            ConfigDetailCard(
              iconUrl: 'idioma.svg',
              title: 'Idioma',
              subtitle: 'Escolha seu idioma preferido',
            ),
            SizedBox(height: 4),
            ConfigDetailCard(
              iconUrl: 'thema.svg',
              title: 'Tema',
              subtitle: 'Tema claro ou escuro',
            ),
            SizedBox(height: 4),
            InkWell(
              onTap: () {
                context.push('/list_category');
              },
              child: ConfigDetailCard(
                iconUrl: 'categoria.svg',
                title: 'Administrar Categorias',
                subtitle: 'Administração das Categorias',
                withIcon: true,
              ),
            ),
            SizedBox(height: 4),
            InkWell(
              onTap: () {
                context.push('/list_marca');
              },
              child: ConfigDetailCard(
                iconUrl: 'marca.svg',
                title: 'Administrar Marca',
                subtitle: 'Adiministração das Marcas',
                withIcon: true,
              ),
            ),
            SizedBox(height: 4),
            InkWell(
              onTap: () {
                context.push('/list_serie');
              },
              child: ConfigDetailCard(
                iconUrl: 'series.svg',
                title: 'Administrar Series',
                subtitle: 'Administração das Series',
                withIcon: true,
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        InkWell(
          onTap: () {
            context.push('/list_collection_base');
          },
          child: ConfigDetailCard(
            iconUrl: 'car_base.svg',
            title: 'Cadastro base de collecionaveis',
            subtitle: 'Administração da base de colecionáveis',
            withIcon: true,
          ),
        ),
        SizedBox(height: 10),
        // Legal (no subtitle)
        ConfigSection(
          title: 'Legal',
          children: [
            InkWell(
              onTap: () {
                context.push('/check_terms_screen');
              },
              child: ConfigDetailCard(
                iconUrl: 'termos_legais.svg',
                title: 'Termos de uso',
                withIcon: true,
              ),
            ),
            SizedBox(height: 4),
            InkWell(
              onTap: () {
                context.push('/check_politics_screen');
              },
              child: ConfigDetailCard(
                iconUrl: 'politica_privacidade.svg',
                title: 'Política de privacidade',
                marginBottom: 0,
                withIcon: true,
              ),
            ),
          ],
        ),
        SizedBox(height: 14),
        // Legal (no subtitle)
        ConfigSection(
          title: 'Ajuda e suporte',
          children: [
            InkWell(
              onTap: () {},
              child: ConfigDetailCard(
                iconUrl: 'suporte.svg',
                title: 'Perguntas frequentes',
                withIcon: true,
              ),
            ),
            SizedBox(height: 4),
            InkWell(
              onTap: () {},
              child: ConfigDetailCard(
                iconUrl: 'suporte.svg',
                title: 'Fale conosco',
                marginBottom: 0,
                withIcon: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
