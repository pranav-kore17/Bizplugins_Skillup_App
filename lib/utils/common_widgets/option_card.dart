import 'package:flutter/material.dart';
import 'package:bizplugins_skillup/utils/colors.dart';
import 'package:bizplugins_skillup/utils/app_theme.dart';

class OptionCard extends StatelessWidget {
  const OptionCard({
    super.key,
    required this.option,
    required this.index,
    required this.isSelected,
  });

  final String option;
  final int index;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: isSelected ? primaryColor.withOpacity(0.15) : theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? primaryColor : Colors.grey,
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Index Number
            SizedBox(
              width: 28,
              child: Text(
                "${index + 1}.",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: isSelected
                      ? primaryColor
                      : theme.textTheme.bodyLarge?.color,
                ),
              ),
            ),

            /// Option Text
            Expanded(
              child: Text(
                option,
                style: TextStyle(
                  fontSize: 18,
                  color: isSelected
                      ? primaryColor
                      : theme.textTheme.bodyLarge?.color,
                ),
              ),
            ),

            /// Icon
            Icon(
              isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
              color: isSelected ? primaryColor : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
