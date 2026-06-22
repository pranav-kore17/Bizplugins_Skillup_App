import 'package:flutter/material.dart';
import 'package:bizplugins_skillup/utils/colors.dart';

class ResultBox extends StatelessWidget {
  const ResultBox({
    super.key,
    required this.result,
    required this.questionLength,
    required this.onRestart,
    required this.onReview,
  });

  final int result;
  final int questionLength;
  final VoidCallback onRestart;
  final VoidCallback onReview;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      backgroundColor: theme.cardColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Trophy Circle
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    primaryPurple.withOpacity(0.9),
                    primaryPurple.withOpacity(0.6),
                  ],
                ),
              ),
              child: const Icon(
                Icons.emoji_events,
                size: 40,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 20),

            /// Title
            Text(
              "Quiz Completed",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            /// Score Container
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: primaryPurple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                "$result / $questionLength",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryPurple,
                ),
              ),
            ),

            const SizedBox(height: 30),

            /// Play Again Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onRestart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryPurple,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Play Again",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: onReview,
                child: const Text("Review Answers"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
