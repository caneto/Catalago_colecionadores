import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:flutter/material.dart';

class SearchResultCard extends StatelessWidget {
  final String title;
  final String? imageUrl;
  final String year;
  final String series;
  final String colorName;
  final Color colorValue;
  final bool isNew;
  final bool isInCollection;
  final bool isFavorite;
  final VoidCallback onCollectionTap;
  final VoidCallback onFavoriteTap;
  final VoidCallback onDetailsTap;

  const SearchResultCard({
    super.key,
    required this.title,
    this.imageUrl,
    required this.year,
    required this.series,
    required this.colorName,
    required this.colorValue,
    this.isNew = false,
    this.isInCollection = false,
    this.isFavorite = false,
    required this.onCollectionTap,
    required this.onFavoriteTap,
    required this.onDetailsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2430), // Dark card background from image
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                if (isNew)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E3A5F),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'Novo',
                      style: TextStyle(
                        color: Color(0xFF42A5F5),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Image
          Container(
            height: 150,
            width: double.infinity,
            color: Colors.white.withValues(alpha: 0.05), // Placeholder bg
            child: imageUrl != null
                ? Image.network(
                    imageUrl!,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(
                          Icons.image_not_supported,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ) // In real app, might want to use cached network image or memory image
                : const Center(
                    child: Icon(
                      Icons.directions_car,
                      size: 64,
                      color: Colors.grey,
                    ),
                  ),
          ),

          // Details
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildInfoRow(Icons.calendar_today, 'Ano:', year),
                const SizedBox(height: 8),
                _buildInfoRow(Icons.category, 'Série:', series),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.palette, size: 16, color: Colors.grey),
                    const SizedBox(width: 8),
                    const Text(
                      'Cor:',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      colorName,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: colorValue,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Divider
          const Divider(height: 1, color: Colors.white10),

          // Actions
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  icon: isInCollection ? Icons.check_circle : Icons.library_add,
                  label: isInCollection ? 'Na Coleção' : 'Colecionar',
                  color: isInCollection
                      ? CatalagoColecionadorTheme.bgInputAccent
                      : Colors.grey,
                  onTap: onCollectionTap,
                ),
              ),
              Container(width: 1, height: 40, color: Colors.white10),
              Expanded(
                child: _buildActionButton(
                  icon: isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border, // Using heart icon as per image
                  label: 'Favoritar',
                  color: isFavorite ? Colors.red : Colors.grey,
                  onTap: onFavoriteTap,
                ),
              ),
              Container(width: 1, height: 40, color: Colors.white10),
              Expanded(
                child: _buildActionButton(
                  icon: Icons.remove_red_eye,
                  label: 'Detalhes',
                  color: Colors.grey,
                  onTap: onDetailsTap,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
        const SizedBox(width: 8),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 14)),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Column(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
