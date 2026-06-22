import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:bizplugins_skillup/utils/text_styles.dart';

import '../colors.dart';

class AppBottomSheet extends StatelessWidget {
  final List<String> items;
  final TextEditingController searchController = TextEditingController();
  final RxList<String> filteredItems = <String>[].obs;
  final String title;
  final Function(String) onSelect;
  final bool enableSearch;
  AppBottomSheet(
      {super.key,
      required this.items,
      required this.title,
      required this.onSelect,
      required this.enableSearch}) {
    filteredItems.addAll(items);
    searchController.addListener(() {
      final query = searchController.text.toLowerCase();
      filteredItems.value =
          items.where((item) => item.toLowerCase().contains(query)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: successColor),
          ),
          enableSearch && filteredItems.isNotEmpty
              ? Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ],
                )
              : SizedBox(),
          SizedBox(height: 16.0),
          // Obx is used to reactively update the list when filteredItems changes.
          Expanded(
            child: Obx(() {
              return filteredItems.isNotEmpty
                  ? ListView.builder(
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(filteredItems[index]),
                          onTap: () {
                            // Handle item tap
                            onSelect(filteredItems[index]);
                          },
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        "No data found",
                        style: fontRegularStyle(fontSize: 15),
                      ),
                    );
            }),
          ),
        ],
      ),
    );
  }
}
