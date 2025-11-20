import 'package:catalago_colecionadores/src/ui/core/theme/catalago_colecionador_theme.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double width;
  final double height;
  final double imageHeight;

  const ItemCard({super.key, 
    required this.imageUrl,
    required this.title,
    required this.width,
    required this.height,
    required this.imageHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: title,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: CatalagoColecionadorTheme.cardItemAndImageColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              blurRadius: 0,
              spreadRadius: 0,
              color: Colors.transparent,
            ),
          ],
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.topCenter,
                child: Image.network(
                  imageUrl,
                  width: width,
                  height: imageHeight,
                  fit: BoxFit.cover,
                  errorBuilder: (ctx, _, __) => Container(
                    height: imageHeight,
                    color: const Color(0xFF332022),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.broken_image_outlined,
                      color: Colors.white24,
                      size: 38,
                    ),
                  ),
                  loadingBuilder: (ctx, child, progress) => progress == null
                      ? child
                      : Container(
                          height: imageHeight,
                          color: const Color(0xFF332022),
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white24,
                            ),
                            strokeWidth: 2.1,
                          ),
                        ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: CatalagoColecionadorTheme.cardItemAndImageColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                padding: const EdgeInsets.only(top: 12, bottom: 11),
                alignment: Alignment.center,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: CatalagoColecionadorTheme.textBold.copyWith(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.07,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}