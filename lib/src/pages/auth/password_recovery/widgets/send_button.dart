import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:flutter/material.dart';

class SendButton extends StatelessWidget {
  final bool isNarrow;
  final bool isSending;
  final VoidCallback? onPressed;

  const SendButton({super.key, 
    required this.isNarrow,
    required this.isSending,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Semantics(
        button: true,
        label: 'Send instructions',
        child: ElevatedButton(
          style:
              ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  vertical: isNarrow ? 13 : 15,
                  horizontal: 0,
                ),
                textStyle: CatalagoColecionadorTheme.titleStyleNormal.copyWith(
                  fontSize: isNarrow ? 17 : 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.1,
                ),
                foregroundColor: CatalagoColecionadorTheme.whiteColor,
                backgroundColor: Colors.transparent, // gradient will override
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
                shadowColor: Colors.transparent,
              ).copyWith(
                backgroundColor: WidgetStateProperty.all(Colors.transparent),
                side: WidgetStateProperty.all(BorderSide.none),
                elevation: WidgetStateProperty.all(0),
              ),
          onPressed: onPressed,
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                colors: [
                  CatalagoColecionadorTheme.bgInputAccent,
                  CatalagoColecionadorTheme.cardCategyColor,
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0x1A0958D9),
                  blurRadius: 16,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Container(
              alignment: Alignment.center,
              constraints: const BoxConstraints(minHeight: 40),
              child: isSending
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Text(
                      'Enviar',
                      style: CatalagoColecionadorTheme.titleStyleNormal
                          .copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            letterSpacing: 0.1,
                          ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
