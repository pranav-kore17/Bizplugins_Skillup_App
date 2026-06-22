import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:bizplugins_skillup/controllers/sales_videos_controller.dart';
import 'package:bizplugins_skillup/screens/sales/sales_video_player_page.dart';
import 'package:bizplugins_skillup/utils/app_theme.dart';
import 'package:bizplugins_skillup/utils/colors.dart';
import 'package:bizplugins_skillup/controllers/theme_controller.dart';
import 'package:bizplugins_skillup/utils/common_widgets/search_field.dart';
import 'package:bizplugins_skillup/utils/global_appbar.dart';

class SalesVideosPage extends StatefulWidget {
  const SalesVideosPage({super.key});

  @override
  State<SalesVideosPage> createState() => _SalesVideosPageState();
}

class _SalesVideosPageState extends State<SalesVideosPage> {
  final controller = Get.find<SalesVideosController>();
  final FocusNode searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    /// auto focus when screen opens
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
      body: Column(
        children: [
          /// SEARCH
          SearchField(
            controller: controller.searchController,
            searchText: controller.searchText,
            hintText: "Search Videos",
            focusNode: searchFocusNode,
          ),

          /// LIST OF CARDS
          Expanded(
            child: Obx(() {
              final list = controller.filteredVideos;

              if (list.isEmpty) {
                return const Center(child: Text('No videos found'));
              }

              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final video = list[index];
                  final realIndex = controller.videos.indexOf(video);

                  Duration remaining = video.totalDuration - video.lastPosition;

                  if (remaining.isNegative) {
                    remaining = Duration.zero;
                  }

                  return Card(
                    elevation: 1.5,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        Get.to(
                          () => SalesVideoPlayerPage(
                            videoIndex: realIndex,
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            /// LEFT: THUMBNAIL
                            Stack(
                              children: [
                                Container(
                                  width: 60,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                      image: NetworkImage(video.thumbnail),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned.fill(
                                  child: Center(
                                    child: Icon(
                                      Icons.play_circle_fill,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(width: 12),

                            /// RIGHT: TITLE + STATUS
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    video.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      if (video.isCompleted)
                                        Container(
                                          width: 18,
                                          height: 18,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: successColor,
                                              width: 2,
                                            ),
                                          ),
                                          child: const Center(
                                            child: Icon(
                                              Icons.done,
                                              size: 12,
                                              color: successColor,
                                            ),
                                          ),
                                        )
                                      else
                                        SizedBox(
                                          width: 18,
                                          height: 18,
                                          child: CircularProgressIndicator(
                                            valueColor: AlwaysStoppedAnimation(
                                                videoProgressColor),
                                            strokeWidth: 2,
                                            backgroundColor:
                                                Colors.grey.shade300,
                                            value: video.totalDuration
                                                        .inSeconds ==
                                                    0
                                                ? 0
                                                : video.lastPosition.inSeconds /
                                                    video.totalDuration
                                                        .inSeconds,
                                          ),
                                        ),
                                      const SizedBox(width: 6),
                                      Text(
                                        video.isCompleted
                                            ? "Viewed"
                                            : video.totalDuration ==
                                                    Duration.zero
                                                ? "Not started"
                                                : "${controller.formatDuration(remaining)} left",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: video.isCompleted
                                              ? successColor
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .onSurfaceVariant,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
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
