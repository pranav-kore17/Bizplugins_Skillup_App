import 'package:flutter/material.dart';
import 'package:bizplugins_skillup/utils/colors.dart';
import 'package:bizplugins_skillup/utils/common_widgets/app_text_field.dart';

class ApplyLeaveDialog extends StatefulWidget {
  const ApplyLeaveDialog({super.key});

  @override
  State<ApplyLeaveDialog> createState() => _ApplyLeaveDialogState();
}

class _ApplyLeaveDialogState extends State<ApplyLeaveDialog> {
  String? selectedLeaveType;
  String? selectedHalfDay;

  DateTime? startDate;
  DateTime? endDate;

  final List<String> leaveTypes = [
    "Privilege Leave",
    "Casual Leave",
    "Sick Leave",
    "Half Day Leave",
  ];

  final List<String> halfDayTypes = [
    "Yes",
    "No",
  ];

  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController leaveTypeController = TextEditingController();
  final TextEditingController halfDayController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color.fromARGB(255, 243, 247, 250),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Apply Leave",
                style: TextStyle(
                  fontSize: 28,
                  color: primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 18),
              AppTextField(
                controller: startDateController,
                placeholder: "Start Date",
                isDatePicker: true,
                onDateSelect: (value) {
                  setState(() {
                    startDateController.text = value;
                  });
                },
              ),
              const SizedBox(height: 18),
              TextFormField(
                readOnly: true,
                onTap: () => _selectDate(context, false),
                controller: TextEditingController(
                  text: endDate == null
                      ? ""
                      : "${endDate!.day}/${endDate!.month}/${endDate!.year}",
                ),
                decoration: InputDecoration(
                  hintText: "End Date",
                  prefixIcon: const Icon(Icons.calendar_month),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              DropdownButtonFormField<String>(
                value: selectedLeaveType,
                decoration: InputDecoration(
                  hintText: "Select Leave Types",
                  prefixIcon: const Icon(Icons.bookmark),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                items: leaveTypes.map((item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedLeaveType = value;
                  });
                },
              ),
              const SizedBox(height: 18),
              DropdownButtonFormField<String>(
                value: selectedHalfDay,
                decoration: InputDecoration(
                  hintText: "Select Half Day",
                  prefixIcon: const Icon(Icons.hourglass_bottom),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                items: halfDayTypes.map((item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedHalfDay = value;
                  });
                },
              ),
              const SizedBox(height: 18),
              TextFormField(
                // maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Reason",
                  prefixIcon: const Icon(Icons.question_mark),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Apply",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
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
