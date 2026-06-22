import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:bizplugins_skillup/models/pdf_model.dart';

class PdfController extends GetxController {
  RxList<PdfModel> pdfList = <PdfModel>[].obs;
  RxString searchText = ''.obs;

  RxBool isGrid = false.obs;

  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadPdfs();

    debounce(searchText, (_) {}, time: Duration(milliseconds: 300));
  }

  void loadPdfs() {
    pdfList.clear();

    pdfList.addAll([
      PdfModel(
        name: "Integration Setting Guidelines PDF",
        path: "assets/pdfs/Integration Setting Guidelines.pdf",
      ),
      PdfModel(
        name: "ERP Ebook PDF",
        path: "assets/pdfs/ERP Ebook.pdf",
      ),
      PdfModel(
        name: "Functional Training PDF",
        path: "assets/pdfs/Functional Training PDF.pdf",
      ),
      PdfModel(
        name: "Technical Training PDF",
        path: "assets/pdfs/Technical Training PDF.pdf",
      ),
    ]);
  }

  /// Filtered PDFs
  List<PdfModel> get filteredPdfs {
    if (searchText.value.isEmpty) {
      return pdfList;
    }

    return pdfList
        .where((pdf) =>
            pdf.name.toLowerCase().contains(searchText.value.toLowerCase()))
        .toList();
  }
}
