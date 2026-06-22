import 'package:flutter/material.dart';
import 'package:bizplugins_skillup/utils/common_widgets/no_record_found.dart';

class Awardscreen extends StatelessWidget {
  const Awardscreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Example data list
    final List awards = []; // empty → no record

    return Scaffold(
      body: awards.isEmpty
          ? const NoRecordFound()
          : ListView.builder(
              itemCount: awards.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(awards[index]),
                );
              },
            ),
    );
  }
}
