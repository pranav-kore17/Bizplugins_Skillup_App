import 'package:flutter/material.dart';
import 'package:bizplugins_skillup/models/question_model.dart';

class ReviewScreen extends StatelessWidget {
  final List<Question> questions;
  final Map<int, int> selectedAnswers;

  const ReviewScreen({
    super.key,
    required this.questions,
    required this.selectedAnswers,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: questions.length,
      itemBuilder: (context, i) {
        final question = questions[i];
        final options = question.options.keys.toList();
        final values = question.options.values.toList();

        final userAnswer = selectedAnswers[i];
        final correctIndex = values.indexOf(true);

        bool isCorrect = userAnswer == correctIndex;

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isCorrect ? Colors.green : Colors.red,
              width: 1.5,
            ),
            color: isCorrect
                ? Colors.green.withOpacity(0.05)
                : Colors.red.withOpacity(0.05),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// Q Badge + Result
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: isCorrect ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "Q${i + 1}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Icon(
                    isCorrect ? Icons.check_circle : Icons.cancel,
                    color: isCorrect ? Colors.green : Colors.red,
                  ),

                  const SizedBox(width: 6),

                  Text(
                    isCorrect ? "Correct" : "Wrong",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isCorrect ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              /// Question
              Text(
                question.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 12),

              /// User Answer (if wrong)
              if (!isCorrect)
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.close, color: Colors.red),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          "Your answer: ${options[userAnswer!]}",
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),

              /// Correct Answer
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.check, color: Colors.green),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        "Correct answer: ${options[correctIndex]}",
                        style: const TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}