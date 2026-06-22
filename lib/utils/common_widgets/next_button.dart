import 'package:flutter/material.dart';
import 'package:bizplugins_skillup/utils/colors.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    Key? key,
    required this.nextQuestion,
    required this.index,
    required this.totalQuestions,
  }) : super(key: key);

  final VoidCallback nextQuestion;
  final int index;
  final int totalQuestions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: nextQuestion,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black.withOpacity(0.15),
              offset: const Offset(0, 5),
            ),
          ],
          border: Border.all(
            color: theme.dividerColor,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              index == totalQuestions - 1 ? "SUBMIT" : "NEXT",
              style: const TextStyle(
                color: primaryPurple,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 10),
            const Icon(
              Icons.arrow_forward,
              color: primaryPurple,
            ),
          ],
        ),
      ),
    );
  }
}
