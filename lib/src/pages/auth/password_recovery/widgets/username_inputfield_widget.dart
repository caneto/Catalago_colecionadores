import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:flutter/material.dart';

class UsernameInputFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String? errorText;
  final bool enabled;
  const UsernameInputFieldWidget({
    super.key,
    required this.controller,
    required this.errorText,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(
          textField: true,
          label: 'Username',
          child: Container(
            decoration: BoxDecoration(
              color: CatalagoColecionadorTheme.blackGround,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 21),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Username',
                  style: CatalagoColecionadorTheme.textTextButtonLabel.copyWith(
                    color: CatalagoColecionadorTheme.whiteColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.1,
                  ),
                ),
                SizedBox(height: 4),
                TextField(
                  controller: controller,
                  enabled: enabled,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.username],
                  cursorColor: CatalagoColecionadorTheme.whiteColor,
                  style: CatalagoColecionadorTheme.textTextButtonLabel.copyWith(
                    color: CatalagoColecionadorTheme.yellowColor,
                    fontSize: 16,
                    letterSpacing: 0.1,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.only(top: 0, bottom: 3),
                    border: InputBorder.none,
                    hintText: 'Username',
                    hintStyle: CatalagoColecionadorTheme.textTextButtonLabel
                        .copyWith(
                          color: CatalagoColecionadorTheme.yellowColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: CatalagoColecionadorTheme.whiteColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: CatalagoColecionadorTheme.whiteColor,
                      ),
                    ),
                    errorText: null,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Text(
              errorText!,
              style: CatalagoColecionadorTheme.textTextButtonLabel.copyWith(
                color: Colors.redAccent,
              ),
            ),
          ),
        const SizedBox(height: 30),
      ],
    );
  }
}
