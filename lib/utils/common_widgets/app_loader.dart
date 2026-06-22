import 'package:flutter/material.dart';
import 'package:bizplugins_skillup/utils/colors.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: successColor,
      ),
    );
  }
}

class AppLoader {
  static OverlayEntry? _overlayEntry;

  static void show(BuildContext context) {
    _overlayEntry = OverlayEntry(
      builder: (_) => Positioned.fill(
        child: Container(
          color: Colors.black.withOpacity(0.3),
          child: const Center(
            child: CircularProgressIndicator(
              color: primaryPurple,
            ),
          ),
        ),
      ),
    );

    Overlay.of(context, rootOverlay: true)?.insert(_overlayEntry!);
  }

  static void hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
