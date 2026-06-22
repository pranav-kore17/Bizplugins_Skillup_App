import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoRecordFound extends StatelessWidget {
  const NoRecordFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        'assets/images/no-data.svg',
        height: 250,
        fit: BoxFit.contain,
      ),
    );
  }
}