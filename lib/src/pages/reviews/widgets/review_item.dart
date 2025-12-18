import 'package:flutter/material.dart';

class ReviewItem extends StatelessWidget {
  final String userName;
  final String? userImageUrl;
  final String date;
  final int rating;
  final String comment;
  final int likes;
  final int dislikes;

  const ReviewItem({
    super.key,
    required this.userName,
    this.userImageUrl,
    required this.date,
    required this.rating,
    required this.comment,
    required this.likes,
    required this.dislikes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: userImageUrl != null
                    ? NetworkImage(userImageUrl!)
                    : null,
                backgroundColor: Colors.blueGrey,
                child: userImageUrl == null
                    ? Text(
                        userName.isNotEmpty ? userName[0].toUpperCase() : '?',
                        style: const TextStyle(color: Colors.white),
                      )
                    : null,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    date,
                    style: TextStyle(color: Colors.grey[500], fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: List.generate(5, (index) {
              return Icon(
                index < rating ? Icons.star : Icons.star_border,
                color: Colors.blue,
                size: 16,
              );
            }),
          ),
          const SizedBox(height: 8),
          Text(
            comment,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildInteractionButton(Icons.thumb_up_outlined, likes),
              const SizedBox(width: 24),
              _buildInteractionButton(Icons.thumb_down_outlined, dislikes),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInteractionButton(IconData icon, int count) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey, size: 16),
        const SizedBox(width: 6),
        Text(
          count.toString(),
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ],
    );
  }
}
