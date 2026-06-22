import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/pdf_controller.dart';
import 'pdf_viewer_screen.dart';
import '../../utils/common_widgets/search_field.dart';
import 'package:bizplugins_skillup/utils/app_theme.dart';
import 'package:bizplugins_skillup/utils/colors.dart';
import 'package:bizplugins_skillup/controllers/theme_controller.dart';

class PdfListScreen extends StatefulWidget {
  const PdfListScreen({super.key});

  @override
  State<PdfListScreen> createState() => _PdfListScreenState();
}

class _PdfListScreenState extends State<PdfListScreen> {
  final PdfController controller = Get.put(PdfController());
  final FocusNode searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    /// auto focus search
    Future.delayed(const Duration(milliseconds: 300), () {
      searchFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: const Text("Training PDFs"),
        elevation: 0,
        actions: [
          Obx(() => IconButton(
                icon: Icon(
                  controller.isGrid.value ? Icons.view_list : Icons.grid_view,
                ),
                onPressed: () {
                  controller.isGrid.toggle();
                },
              )),
        ],
      ),
      body: Column(
        children: [
          /// SEARCH BAR
          SearchField(
            controller: controller.searchController,
            searchText: controller.searchText,
            hintText: "Search PDF",
            focusNode: searchFocusNode,
          ),

          /// PDF LIST
          Expanded(
            child: Obx(() {
              final list = controller.filteredPdfs;

              if (list.isEmpty) {
                return const Center(
                  child: Text(
                    "No PDF Found",
                    style: TextStyle(fontSize: 16),
                  ),
                );
              }

              return controller.isGrid.value
                  ? GridView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: list.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // 2 columns
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 1.2,
                      ),
                      itemBuilder: (context, index) {
                        final pdf = list[index];

                        return InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            Get.to(() => PdfViewerScreen(
                                  path: pdf.path,
                                  title: pdf.name,
                                ));
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 1.5,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: Colors.red.shade50,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(
                                      Icons.picture_as_pdf,
                                      color: Colors.red,
                                      size: 28,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    pdf.name,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        final pdf = list[index];

                        return Card(
                          elevation: 1.5,
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              Get.to(() => PdfViewerScreen(
                                    path: pdf.path,
                                    title: pdf.name,
                                  ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(14),
                              child: Row(
                                children: [
                                  Container(
                                    width: 42,
                                    height: 42,
                                    decoration: BoxDecoration(
                                      color: Colors.red.shade50,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(
                                      Icons.picture_as_pdf,
                                      color: Colors.red,
                                      size: 26,
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Text(
                                      pdf.name,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
            }),
          ),
        ],
      ),
    );
  }
}
