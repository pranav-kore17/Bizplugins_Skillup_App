import 'package:flutter/material.dart';
import 'package:bizplugins_skillup/utils/common_widgets/app_card_widget.dart';

class CompOffCard extends StatelessWidget {
  final String date;
  final String hours;
  final String status;
  final String reason;

  const CompOffCard({
    super.key,
    required this.date,
    required this.hours,
    required this.status,
    required this.reason,
  });

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "approved":
        return Colors.green;
      case "pending":
        return Colors.orange;
      case "rejected":
        return Colors.red;
      case "cancelled":
        return Colors.grey;
      case "forwarded":
        return Colors.blue;
      default:
        return Colors.black45;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = getStatusColor(status);

    return AppCardWidget(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      borderRadius: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //  Top Row
          Row(
            children: [
              Expanded(
                child: Text(
                  date,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          //  Working Hours
          Row(
            children: [
              const Icon(Icons.access_time, size: 18, color: Colors.grey),
              const SizedBox(width: 6),
              Text(
                hours,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black87,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          //  Reason
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.description, size: 18, color: Colors.grey),
              const SizedBox(width: 6),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                    children: [
                      const TextSpan(
                        text: "Reason: ",
                        style: TextStyle(fontWeight: FontWeight.w600),
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
