import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:bizplugins_skillup/controllers/sales_videos_controller.dart';
import 'package:bizplugins_skillup/utils/colors.dart';
import 'package:bizplugins_skillup/utils/global_appbar.dart';

class SalesVideoPlayerPage extends StatefulWidget {
  final int videoIndex;

  const SalesVideoPlayerPage({
    super.key,
    required this.videoIndex,
  });

  @override
  State<SalesVideoPlayerPage> createState() => _SalesVideoPlayerPageState();
}

class _SalesVideoPlayerPageState extends State<SalesVideoPlayerPage> {
  final controller = Get.find<SalesVideosController>();

  @override
  void initState() {
    super.initState();

    controller.currentVideoIndex.value = widget.videoIndex;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final index = widget.videoIndex;
      final lastPosition = controller.videos[index].lastPosition;

      if (lastPosition > Duration.zero) {
        controller.videoControllers[index].seekTo(lastPosition);
      }
    });
  }

  @override
  void dispose() {
    controller.showNextVideoOverlay.value = false;
    controller.pauseAllVideos();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          controller.pauseAllVideos();
        }
      },
      child: Scaffold(
        appBar: GlobalAppBar(
          title: const Text(
            "SALES VIDEOS",
            style: TextStyle(
              letterSpacing: 1.2,
              fontWeight: FontWeight.w600,
            ),
          ),
          showBackButton: true,
          onBack: () {
            controller.pauseAllVideos();
            Get.back();
          },
        ),
        body: Obx(() {
          final currentIndex = controller.currentVideoIndex.value;
          final video = controller.videos[currentIndex];

          return Column(
            children: [
              /// VIDEO PLAYER
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Container(
                      color: Colors.black,
                      child: Chewie(
                        controller: controller.chewieControllers[currentIndex],
                      ),
                    ),
                  ),

                  /// NEXT VIDEO COUNTDOWN OVERLAY
                  Obx(() {
                    if (!controller.showNextVideoOverlay.value) {
                      return const SizedBox();
                    }

                    return Positioned.fill(
                      child: Container(
                        color: Colors.black54,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Next video in ${controller.nextVideoCountdown.value}s",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      controller.cancelNextVideo.value = true;
                                      controller.showNextVideoOverlay.value =
                                          false;

                                      final nextIndex =
                                          controller.currentVideoIndex.value +
                                              1;
                                      if (nextIndex <
                                          controller.videos.length) {
                                        controller.changeVideo(nextIndex);
                                      }
                                    },
                                    child: const Text("Play Now"),
                                  ),
                                  const SizedBox(width: 12),
                                  OutlinedButton(
                                    onPressed: () {
                                      controller.cancelNextVideo.value = true;
                                      controller.showNextVideoOverlay.value =
                                          false;
                                    },
                                    child: const Text("Cancel"),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  })
                ],
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// TITLE
                        Text(
                          video.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        /// BADGE
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color:
                                isDark ? salesBadgeDarkBg : salesBadgeLightBg,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "Sales",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: isDark
                                  ? salesBadgeDarkText
                                  : salesBadgeLightText,
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        /// DESCRIPTION
                        Text(video.description),

                        const SizedBox(height: 24),

                        const Text(
                          "Next Videos",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        /// NEXT VIDEOS LIST
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.videos.length,
                          itemBuilder: (context, index) {
                            if (index == currentIndex) {
                              return const SizedBox();
                            }

                            final nextVideo = controller.videos[index];

                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () {
                                  controller.changeVideo(index);
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /// THUMBNAIL
                                    Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.network(
                                            nextVideo.thumbnail,
                                            width: 90,
                                            height: 55,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const Positioned.fill(
                                          child: Center(
                                            child: Icon(
                                              Icons.play_circle_fill,
                                              color: Colors.white,
                                              size: 28,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(width: 12),

                                    /// VIDEO INFO
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          /// TITLE
                                          Text(
                                            nextVideo.title,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          ),

                                          const SizedBox(height: 6),

                                          /// SALES BADGE
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 3,
                                            ),
                                            decoration: BoxDecoration(
                                              color: isDark
                                                  ? salesBadgeDarkBg
                                                  : salesBadgeLightBg,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              "Sales",
                                              style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w600,
                                                color: isDark
                                                    ? salesBadgeDarkText
                                                    : salesBadgeLightText,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
