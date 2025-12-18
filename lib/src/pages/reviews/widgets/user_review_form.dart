import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:flutter/material.dart';

class UserReviewForm extends StatefulWidget {
  final Function(int stars, String comment) onSubmit;

  const UserReviewForm({super.key, required this.onSubmit});

  @override
  State<UserReviewForm> createState() => _UserReviewFormState();
}

class _UserReviewFormState extends State<UserReviewForm> {
  int _selectedStars = 5;
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sua Avaliação',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
            ),
          ),
          const SizedBox(height: 16),
          // Star Selection Chips
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(5, (index) {
              int stars = index + 1;
              bool isSelected = _selectedStars == stars;
              return _buildStarChip(stars, isSelected);
            }),
          ),
          const SizedBox(height: 16),
          // Comment Text Field
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF161C27),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white12),
            ),
            child: TextField(
              controller: _commentController,
              maxLines: 4,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Escreva seu comentário',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(16),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Submit Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                widget.onSubmit(_selectedStars, _commentController.text);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: CatalagoColecionadorTheme.bgInputAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
              child: const Text('Enviar'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStarChip(int stars, bool isSelected) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedStars = stars;
        });
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF161C27)
              : const Color(0xFF161C27).withOpacity(0.5),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.white30 : Colors.transparent,
          ),
        ),
        child: Text(
          '$stars ${stars == 1 ? "estrela" : "estrelas"}',
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
