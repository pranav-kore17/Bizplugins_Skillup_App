import 'package:flutter/material.dart';
import 'package:bizplugins_skillup/models/question_model.dart';
import 'package:bizplugins_skillup/screens/quiz/review_screen.dart';
import 'package:bizplugins_skillup/screens/dashboard_screeen.dart';
import 'package:bizplugins_skillup/utils/common_widgets/confirm_dialog.dart';
import 'package:bizplugins_skillup/utils/global_appbar.dart';
import 'package:bizplugins_skillup/utils/colors.dart';

class ResultScreen extends StatelessWidget {
  final List<Question> questions;
  final Map<int, int> selectedAnswers;
  final int score;

  const ResultScreen({
    super.key,
    required this.questions,
    required this.selectedAnswers,
    required this.score,
  });

  String _resultMessage(double percent) {
    if (percent >= 90) {
      return "Excellent!";
    } else if (percent >= 70) {
      return "Great Job!";
    } else if (percent >= 50) {
      return "Good Effort!";
    } else if (percent >= 30) {
      return "Keep Practicing!";
    } else {
      return "Try Again!";
    }
  }

  @override
  Widget build(BuildContext context) {
    double percent = (score / questions.length) * 100;
    int wrong = questions.length - score;

    return Scaffold(
      appBar: GlobalAppBar(
        title: const Text(
          "QUIZ RESULT",
          style: TextStyle(
            letterSpacing: 1.2,
            fontWeight: FontWeight.w600,
          ),
        ),
        showBackButton: true,
        onBack: () => _confirmGoHome(context),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 15, bottom: 35),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  /// Trophy
                  Icon(
                    Icons.emoji_events,
                    size: 70,
                    color: Colors.amberAccent,
                  ),

                  const SizedBox(height: 10),

                  Text(
                    _resultMessage(percent),
                    style: TextStyle(
                      fontSize: 26,
                      // color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    "General Knowledge Quiz",
                  ),

                  const SizedBox(height: 20),

                  /// SCORE CARD
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${percent.toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: percent >= 50 ? successColor : primaryRed,
                          ),
                        ),
                        Text(
                          "$score out of ${questions.length} correct",
                          style: TextStyle(
                            color: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.color
                                ?.withOpacity(0.7),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// SCORE SUMMARY
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: _statCard(
                      context,
                      Icons.check_circle,
                      score,
                      "Correct",
                      successColor,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _statCard(
                      context,
                      Icons.cancel,
                      wrong,
                      "Wrong",
                      primaryRed,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _statCard(
                      context,
                      Icons.list_alt,
                      questions.length,
                      "Total",
                      primaryBlue,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            /// REVIEW TITLE
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Review Answers",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            /// REVIEW LIST
            ReviewScreen(
              questions: questions,
              selectedAnswers: selectedAnswers,
            ),
          ],
        ),
      ),
    );
  }

  Widget _statCard(
    BuildContext context,
    IconData icon,
    int value,
    String title,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.black.withOpacity(0.4)
                : Colors.black.withOpacity(0.05),
            blurRadius: 6,
          )
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 6),
          Text(
            value.toString(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  void _confirmGoHome(BuildContext context) {
    ConfirmDialog.show(
      title: "Go to Home",
      message: "Are you sure you want to leave the result screen?",
      confirmText: "Home",
      confirmColor: primaryRed,
      onConfirm: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const DashboardScreen(),
          ),
          (route) => false,
        );
      },
    );
  }
}
