import 'package:get/get.dart';
import 'package:bizplugins_skillup/controllers/pdf_controller.dart';
import 'package:bizplugins_skillup/controllers/sales_videos_controller.dart';

class GlobalSearchController extends GetxController {

  /// Controllers
  final SalesVideosController videoController =
      Get.find<SalesVideosController>();

  final PdfController pdfController =
      Get.find<PdfController>();

  /// Global search text
  final RxString searchText = ''.obs;

  /// Search function
  void search(String value) {

    final query = value.trim();

    if (searchText.value == query) return;

    searchText.value = query;

    videoController.searchText.value = query;
    pdfController.searchText.value = query;
  }

  /// Clear search
  void clearSearch() {

    searchText.value = "";

    videoController.searchText.value = "";
    pdfController.searchText.value = "";
  }
}