import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bizplugins_skillup/controllers/quiz_controller.dart';
import 'package:bizplugins_skillup/utils/colors.dart';
import 'package:bizplugins_skillup/utils/common_widgets/question_widget.dart';
import 'package:bizplugins_skillup/utils/common_widgets/option_card.dart';
import 'package:bizplugins_skillup/screens/quiz/result_screen.dart';
import 'package:bizplugins_skillup/utils/common_widgets/app_snackbar.dart';
import 'package:bizplugins_skillup/utils/global_appbar.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final QuizController controller = Get.put(QuizController());

  void previousQuestion() {
    if (controller.index > 0) {
      setState(() {
        controller.index--;
      });
    }
  }

  void nextQuestion() {
    // check if option selected
    if (!controller.selectedAnswers.containsKey(controller.index)) {
      AppSnackBar.show(context, "Please select an option");
      return;
    }

    if (controller.index == controller.question.length - 1) {
      controller.score = 0;

      for (int i = 0; i < controller.question.length; i++) {
        int selectedIndex = controller.selectedAnswers[i]!;
        bool correct =
            controller.question[i].options.values.toList()[selectedIndex];

        if (correct) controller.score++;
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultScreen(
            questions: controller.question,
            selectedAnswers: controller.selectedAnswers,
            score: controller.score,
          ),
        ),
      );
    } else {
      setState(() {
        controller.index++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppBar(
        title: const Text(
          "QUIZ",
          style: TextStyle(
            letterSpacing: 1.2,
            fontWeight: FontWeight.w600,
          ),
        ),
        showBackButton: true,
        onBack: () {
          Get.back();
        },
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 5),
            QuestionWidget(
              indexAction: controller.index,
              question: controller.question[controller.index].title,
              totalQuestions: controller.question.length,
            ),
            Divider(color: Theme.of(context).dividerColor),
            const SizedBox(height: 5),
            for (int i = 0;
                i < controller.question[controller.index].options.length;
                i++)
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (controller.selectedAnswers[controller.index] == i) {
                      controller.selectedAnswers.remove(controller.index);
                    } else {
                      controller.selectedAnswers[controller.index] = i;
                    }
                  });
                },
                child: OptionCard(
                  index: i,
                  option: controller.question[controller.index].options.keys
                      .toList()[i],
                  isSelected: controller.selectedAnswers[controller.index] == i,
                ),
              ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// PREVIOUS BUTTON
            if (controller.index > 0)
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: previousQuestion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 3,
                  ),
                  child: const Text("Previous"),
                ),
              )
            else
              const SizedBox(width: 140),

            /// NEXT / SUBMIT BUTTON
            SizedBox(
              width: 100,
              child: ElevatedButton(
                onPressed: nextQuestion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 3,
                ),
                child: Text(
                  controller.index == controller.question.length - 1
                      ? "Submit"
                      : "Next",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
