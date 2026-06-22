import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bizplugins_skillup/utils/colors.dart';

class CustomerRegistrationSteps extends StatelessWidget {
  List<int> currentSteps = [];
  CustomerRegistrationSteps({super.key, required this.currentSteps});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 0, right: 0, top: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          circle(0),
          const Expanded(
              child: Divider(
            thickness: 2,
          )),
          circle(1),
          const Expanded(
              child: Divider(
            thickness: 2,
          )),
          circle(2),
        ],
      ),
    );
  }

  Widget circle(int step) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey[400]!),
          color: currentSteps.contains(step) ? successColor : Colors.grey[200]),
    );
  }
}
