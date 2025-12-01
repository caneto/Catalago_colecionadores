import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:flutter/material.dart';

class MiniatureInfoSection extends StatelessWidget {
  const MiniatureInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(24, 20, 24, 18),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16)),
          border: Border(bottom: BorderSide(color: CatalagoColecionadorTheme.cardItemAndImageColor)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Semantics(
              label: "Titulo",
              child: Text(
                "Ford Mustang",
                style: CatalagoColecionadorTheme.textExtraBold.copyWith(
                  fontSize: 18,
                  letterSpacing: -0.5,
                ),
              ),
            ),
            SizedBox(height: 12),
            Semantics(
              label: "Categoria:",
              child: Row(
                children: [
                  Text(
                    "Categoria: ",
                    style: CatalagoColecionadorTheme.titleStyleNormal.copyWith(
                      color: CatalagoColecionadorTheme.blackClaroColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "Carrinhos",
                    style: CatalagoColecionadorTheme.titleStyleNormal.copyWith(
                      color: CatalagoColecionadorTheme.blackClaroColor,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            Semantics(
              label: "Marca:",
              child: Row(
                children: [
                  Text(
                    "Marca: ",
                    style: CatalagoColecionadorTheme.titleStyleNormal.copyWith(
                      color: CatalagoColecionadorTheme.blackClaroColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "Hot Wheels",
                    style: CatalagoColecionadorTheme.titleStyleNormal.copyWith(
                      color: CatalagoColecionadorTheme.blackClaroColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Semantics(
              label: "Modelo:",
              child: Row(
                children: [
                  Text(
                    "Modelo: ",
                    style: CatalagoColecionadorTheme.titleStyleNormal.copyWith(
                      color: CatalagoColecionadorTheme.blackClaroColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "Ford Mustang",
                    style: CatalagoColecionadorTheme.titleStyleNormal.copyWith(
                      color: CatalagoColecionadorTheme.blackClaroColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Semantics(
              label: "Ano: ",
              child: Row(
                children: [
                  Text(
                    "Ano: ",
                    style: CatalagoColecionadorTheme.titleStyleNormal.copyWith(
                      color: CatalagoColecionadorTheme.blackClaroColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "1967",
                    style: CatalagoColecionadorTheme.titleStyleNormal.copyWith(
                      color: CatalagoColecionadorTheme.blackClaroColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Semantics(
              label: "Escala:",
              child: Row(
                children: [
                  Text(
                    "Escala: ",
                    style: CatalagoColecionadorTheme.titleStyleNormal.copyWith(
                      color: CatalagoColecionadorTheme.blackClaroColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "1:64",
                    style: CatalagoColecionadorTheme.titleStyleNormal.copyWith(
                      color: CatalagoColecionadorTheme.blackClaroColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Semantics(
              label: "Condições:",
              child: Row(
                children: [
                  Text(
                    "Condições: ",
                    style: CatalagoColecionadorTheme.titleStyleNormal.copyWith(
                      color: CatalagoColecionadorTheme.blackClaroColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "Novo",
                    style: CatalagoColecionadorTheme.titleStyleNormal.copyWith(
                      color: CatalagoColecionadorTheme.blackClaroColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Semantics(
              label: "Notas:",
              child: Row(
                children: [
                  Text(
                    "Notas: ",
                    style: CatalagoColecionadorTheme.titleStyleNormal.copyWith(
                      color: CatalagoColecionadorTheme.blackClaroColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "Edição limitada, pintura original",
                    style: CatalagoColecionadorTheme.titleStyleNormal.copyWith(
                      color: CatalagoColecionadorTheme.blackClaroColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}