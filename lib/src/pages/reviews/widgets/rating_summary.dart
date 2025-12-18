import 'package:flutter/material.dart';

class RatingSummary extends StatelessWidget {
  final double averageScore;
  final int totalReviews;
  final Map<int, double> percentagePerStar; // 5: 0.4, 4: 0.3 etc.

  const RatingSummary({
    super.key,
    required this.averageScore,
    required this.totalReviews,
    required this.percentagePerStar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Avaliações',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
            ),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left side: Big Score
              Column(
                children: [
                  Text(
                    averageScore.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < averageScore.floor()
                            ? Icons.star
                            : (index < averageScore
                                  ? Icons.star_half
                                  : Icons.star_border),
                        color: Colors.blue,
                        size: 20,
                      );
                    }),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$totalReviews reviews',
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(width: 24),
              // Right side: Progress bars
              Expanded(
                child: Column(
                  children: [
                    _buildProgressBar(5, percentagePerStar[5] ?? 0),
                    _buildProgressBar(4, percentagePerStar[4] ?? 0),
                    _buildProgressBar(3, percentagePerStar[3] ?? 0),
                    _buildProgressBar(2, percentagePerStar[2] ?? 0),
                    _buildProgressBar(1, percentagePerStar[1] ?? 0),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar(int star, double percentage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          SizedBox(
            width: 12,
            child: Text(
              '$star',
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: percentage,
                backgroundColor: const Color(0xFF242E47),
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                minHeight: 8,
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 30,
            child: Text(
              '${(percentage * 100).toInt()}%',
              style: const TextStyle(color: Colors.grey, fontSize: 12),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
