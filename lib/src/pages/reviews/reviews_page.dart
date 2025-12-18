import 'package:catalago_colecionadores/src/pages/reviews/widgets/rating_summary.dart';
import 'package:catalago_colecionadores/src/pages/reviews/widgets/review_item.dart';
import 'package:catalago_colecionadores/src/pages/reviews/widgets/user_review_form.dart';
import 'package:flutter/material.dart';

class ReviewsPage extends StatelessWidget {
  const ReviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1724),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              // Summary
              const RatingSummary(
                averageScore: 4.5,
                totalReviews: 125,
                percentagePerStar: {
                  5: 0.40,
                  4: 0.30,
                  3: 0.15,
                  2: 0.10,
                  1: 0.05,
                },
              ),
              const Divider(color: Colors.white10),
              // Comments Header
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text(
                  'Comentários',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
              // Comments List
              const ReviewItem(
                userName: 'Carlos Silva',
                // userImageUrl: 'https://i.pravatar.cc/150?u=carlos',
                date: '2023-08-15',
                rating: 5,
                comment:
                    'Esta miniatura é incrível! Os detalhes são perfeitos e a qualidade é excelente. Recomendo a todos os colecionadores.',
                likes: 20,
                dislikes: 5,
              ),
              const ReviewItem(
                userName: 'Ana Pereira',
                // userImageUrl: 'https://i.pravatar.cc/150?u=ana',
                date: '2023-07-22',
                rating: 4,
                comment:
                    'Gostei muito da miniatura, mas achei que poderia ter mais detalhes na pintura. No geral, é um bom produto.',
                likes: 15,
                dislikes: 3,
              ),
              const ReviewItem(
                userName: 'Ricardo Mendes',
                // userImageUrl: 'https://i.pravatar.cc/150?u=ricardo',
                date: '2023-06-10',
                rating: 3,
                comment:
                    'A miniatura é razoável, mas esperava mais pela marca. A pintura tem algumas falhas e os detalhes não são tão precisos.',
                likes: 10,
                dislikes: 2,
              ),
              const Divider(color: Colors.white10),
              // User Form
              UserReviewForm(
                onSubmit: (stars, comment) {
                  // Mock submission
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Avaliação enviada: $stars estrelas'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
