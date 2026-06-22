import 'package:flutter/material.dart';
import 'package:bizplugins_skillup/utils/app_theme.dart';
import 'package:bizplugins_skillup/utils/colors.dart';


class QuestionWidget extends StatelessWidget {
  const QuestionWidget({
    super.key,
    required this.question,
    required this.indexAction,
    required this.totalQuestions,
  });

  final String question;
  final int indexAction;
  final int totalQuestions;

  @override
  Widget build(BuildContext context) {
    final dashboardTheme = Theme.of(context).extension<DashboardCardTheme>();

    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: dashboardTheme?.gradient ??
            const LinearGradient(
              colors: [Colors.deepPurple, Colors.purple],
            ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            blurRadius: 15,
            color: Colors.black.withOpacity(0.15),
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Progress Badge
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: primaryColor.withOpacity(0.4),
              ),
            ),
            child: Text(
              "${indexAction + 1} / $totalQuestions",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                // color: primaryColor,
              ),
            ),
          ),

          const SizedBox(height: 20),

          /// Question Text
          Text(
            question,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              // color: primaryColor,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
