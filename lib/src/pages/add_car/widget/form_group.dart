// Widget para agrupar label e campo do formulário
import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:flutter/material.dart';

class FormGroup extends StatelessWidget {
  final String label;
  final Widget child;

  const FormGroup({super.key, required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: label,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 6, left: 2),
              child: Text(
                label,
                style: CatalagoColecionadorTheme.textBold.copyWith(
                  color: CatalagoColecionadorTheme.textDescriptColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
