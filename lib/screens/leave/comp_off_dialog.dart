import 'package:flutter/material.dart';
import 'package:bizplugins_skillup/utils/colors.dart';
import 'package:bizplugins_skillup/utils/common_widgets/app_text_field.dart';

class CompOffDialog extends StatefulWidget {
  const CompOffDialog({super.key});

  @override
  State<CompOffDialog> createState() => _CompOffDialogState();
}

class _CompOffDialogState extends State<CompOffDialog> {

  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();
  final TextEditingController workingHrsController = TextEditingController();
  final TextEditingController purposeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "Apply Comp Off",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              AppTextField(
                controller: fromDateController,
                placeholder: "From Date",
                isDatePicker: true,
                onDateSelect: (val) {
                  fromDateController.text = val;
                },
              ),

              const SizedBox(height: 12),

              AppTextField(
                controller: toDateController,
                placeholder: "To Date",
                isDatePicker: true,
                onDateSelect: (val) {
                  toDateController.text = val;
                },
              ),

              const SizedBox(height: 12),

              AppTextField(
                controller: workingHrsController,
                placeholder: "Working Hrs",
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 12),

              AppTextField(
                controller: purposeController,
                placeholder: "Purpose",
                maxLines: 3,
              ),

              const SizedBox(height: 14),

              const Text(
                "* Comp Off can be applied only for non-working days.",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: BorderSide(color: Colors.grey.shade400),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel"),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Submit"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}