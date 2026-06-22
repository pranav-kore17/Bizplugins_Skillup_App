import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final RxString searchText;
  final String hintText;
  final FocusNode? focusNode;

  const SearchField({
    super.key,
    required this.controller,
    required this.searchText,
    this.hintText = "Search",
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              blurRadius: 5,
            )
          ],
        ),
        child: TextField(
          controller: controller,
          focusNode: focusNode, // 👈 add this
          onChanged: (value) => searchText.value = value,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: const Icon(Icons.search),
            suffixIcon: Obx(() {
              if (searchText.value.isEmpty) {
                return const SizedBox();
              }

              return IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  controller.clear();
                  searchText.value = "";
                  FocusScope.of(context).unfocus();
                },
              );
            }),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
    );
  }
}