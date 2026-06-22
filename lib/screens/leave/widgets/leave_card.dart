import 'package:flutter/material.dart';
import 'package:bizplugins_skillup/utils/common_widgets/app_card_widget.dart';

class LeaveCard extends StatelessWidget {
  final String title;
  final String appliedOn;
  final String days;
  final String date;
  final String reason;
  final String status;

  final String employeeName;
  final String designation;
  final String employeeId;

  const LeaveCard({
    super.key,
    required this.title,
    required this.appliedOn,
    required this.days,
    required this.date,
    required this.reason,
    required this.status,
    required this.employeeName,
    required this.designation,
    required this.employeeId,
  });

  Color getStatusColor() {
    switch (status) {
      case "Approved":
        return Colors.green;
      case "Pending":
        return Colors.orange;
      case "Rejected":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppCardWidget(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(10),
      borderRadius: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //  Header
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: getStatusColor().withOpacity(0.1),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: getStatusColor(),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          //  Dates
          Text(
            "Applied On : $appliedOn",
            style: const TextStyle(color: Colors.grey, fontSize: 13),
          ),

          const SizedBox(height: 4),

          Text(
            "$days | $date",
            style: const TextStyle(color: Colors.grey, fontSize: 13),
          ),

          const SizedBox(height: 6),
          const Divider(),
          const SizedBox(height: 6),

          //  Bottom Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                      height: 1.5,
                    ),
                    children: [
                      TextSpan(
                        text: "$employeeName\n",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: "$designation\n"),
                      TextSpan(text: "ID : $employeeId"),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                    children: [
                      const TextSpan(
                        text: "Reason :\n",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: reason),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
