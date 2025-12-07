import 'package:catalago_colecionadores/src/core/database/isar_models/car_collection.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:flutter/material.dart';

class MiniatureInfoSection extends StatelessWidget {
  final CarCollection car;

  const MiniatureInfoSection({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    String nomeMiniatura = car.nomeMiniatura.length <= 32
        ? car.nomeMiniatura
        : '${car.nomeMiniatura.substring(0, 30)}...';

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 18),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16)),
          border: Border(
            bottom: BorderSide(
              color: CatalagoColecionadorTheme.cardItemAndImageColor,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Semantics(
              label: "Titulo",
              child: Text(
                nomeMiniatura,
                style: CatalagoColecionadorTheme.textExtraBold.copyWith(
                  fontSize: 19,
                  letterSpacing: -0.5,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Semantics(
              label: "Categoria:",
              child: Row(
                children: [
                  Text(
                    "Categoria: ",
                    style: CatalagoColecionadorTheme.titleStyleNormal.copyWith(
                      color: CatalagoColecionadorTheme.blackClaroColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    car.categoria,
                    style: CatalagoColecionadorTheme.titleStyleNormal.copyWith(
                      color: CatalagoColecionadorTheme.blackClaroColor,
                      fontSize: 16,
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
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    car.marca,
                    style: CatalagoColecionadorTheme.titleStyleNormal.copyWith(
                      color: CatalagoColecionadorTheme.blackClaroColor,
                      fontSize: 16,
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
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    car.modelo,
                    style: CatalagoColecionadorTheme.titleStyleNormal.copyWith(
                      color: CatalagoColecionadorTheme.blackClaroColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            if (car.serie != null && car.serie!.isNotEmpty)
              Semantics(
                label: "Serie:",
                child: Row(
                  children: [
                    Text(
                      "Serie: ",
                      style: CatalagoColecionadorTheme.titleStyleNormal
                          .copyWith(
                            color: CatalagoColecionadorTheme.blackClaroColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                    ),
                    Text(
                      car.serie!,
                      style: CatalagoColecionadorTheme.titleStyleNormal
                          .copyWith(
                            color: CatalagoColecionadorTheme.blackClaroColor,
                            fontSize: 16,
                          ),
                    ),
                  ],
                ),
              ),
            if (car.numeroNaSerie != null && car.numeroNaSerie!.isNotEmpty)
              Semantics(
                label: "Numero na serie:",
                child: Row(
                  children: [
                    Text(
                      " - Numero na serie: ",
                      style: CatalagoColecionadorTheme.titleStyleNormal
                          .copyWith(
                            color: CatalagoColecionadorTheme.blackClaroColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                    ),
                    Text(
                      car.numeroNaSerie!,
                      style: CatalagoColecionadorTheme.titleStyleNormal
                          .copyWith(
                            color: CatalagoColecionadorTheme.blackClaroColor,
                            fontSize: 16,
                          ),
                    ),
                  ],
                ),
              ),

            if (car.anoFabricacao != null)
              Semantics(
                label: "Ano: ",
                child: Row(
                  children: [
                    Text(
                      "Ano: ",
                      style: CatalagoColecionadorTheme.titleStyleNormal
                          .copyWith(
                            color: CatalagoColecionadorTheme.blackClaroColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                    ),
                    Text(
                      car.anoFabricacao.toString(),
                      style: CatalagoColecionadorTheme.titleStyleNormal
                          .copyWith(
                            color: CatalagoColecionadorTheme.blackClaroColor,
                            fontSize: 16,
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
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    car.escala,
                    style: CatalagoColecionadorTheme.titleStyleNormal.copyWith(
                      color: CatalagoColecionadorTheme.blackClaroColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            if (car.condition != null)
              Semantics(
                label: "Condições:",
                child: Row(
                  children: [
                    Text(
                      "Condições: ",
                      style: CatalagoColecionadorTheme.titleStyleNormal
                          .copyWith(
                            color: CatalagoColecionadorTheme.blackClaroColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                    ),
                    Text(
                      car.condition!,
                      style: CatalagoColecionadorTheme.titleStyleNormal
                          .copyWith(
                            color: CatalagoColecionadorTheme.blackClaroColor,
                            fontSize: 16,
                          ),
                    ),
                  ],
                ),
              ),
            if (car.notes != null && car.notes!.isNotEmpty)
              Semantics(
                label: "Notas:",
                child: Row(
                  children: [
                    Text(
                      "Notas: ",
                      style: CatalagoColecionadorTheme.titleStyleNormal
                          .copyWith(
                            color: CatalagoColecionadorTheme.blackClaroColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                    ),
                    Expanded(
                      child: Text(
                        car.notes!,
                        style: CatalagoColecionadorTheme.titleStyleNormal
                            .copyWith(
                              color: CatalagoColecionadorTheme.blackClaroColor,
                              fontSize: 16,
                            ),
                        overflow: TextOverflow.ellipsis,
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
