import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:bizplugins_skillup/models/video_model.dart';

class SalesVideosController extends GetxController {
  final GetStorage box = GetStorage();
  final TextEditingController searchController = TextEditingController();

  final RxList<VideoModel> videos = <VideoModel>[].obs;
  // late final List<FlickManager> flickManagers;
  late final List<ChewieController> chewieControllers;
  late final List<VideoPlayerController> videoControllers;

  /// UI States
  final RxBool allVideosCompleted = false.obs;
  final RxBool showNextVideoOverlay = false.obs;
  final RxInt nextVideoCountdown = 5.obs;
  final RxBool cancelNextVideo = false.obs;
  final RxBool isProcessingCompletion = false.obs;

  /// Search
  final RxString searchText = ''.obs;

  /// Current playing index
  final RxInt currentVideoIndex = 0.obs;

  static const String storageKey = "sales_videos_progress";

  /// -------------------------
  /// Getters
  /// -------------------------

  int get completedCount => videos.where((v) => v.isCompleted).length;

  int get totalCount => videos.length;

  List<VideoModel> get filteredVideos {
    if (searchText.value.isEmpty) return videos;

    return videos
        .where((v) =>
            v.title.toLowerCase().contains(searchText.value.toLowerCase()))
        .toList();
  }

  /// -------------------------
  /// Initialization
  /// -------------------------

  @override
  Future<void> onInit() async {
    super.onInit();

    final loadedVideos = await _loadVideosFromJson();

    videos.assignAll(loadedVideos);

    _restoreProgress();

    _initializeVideoPlayers();
  }

  /// -------------------------
  /// Load JSON
  /// -------------------------

  Future<List<VideoModel>> _loadVideosFromJson() async {
    final String response =
        await rootBundle.loadString('assets/data/sales_videos.json');

    final List data = json.decode(response);

    return data.map((e) => VideoModel.fromJson(e)).toList();
  }

  /// -------------------------
  /// Restore saved progress
  /// -------------------------

  void _restoreProgress() {
    // For clear local storage
    // box.remove(storageKey);
    /// Load saved progress (if exists)
    final savedData = box.read(storageKey);

    if (savedData != null && savedData is List) {
      for (int i = 0; i < videos.length && i < savedData.length; i++) {
        videos[i].isCompleted = savedData[i]['isCompleted'] ?? false;
      }
    }
  }

  /// -------------------------
  /// Video Player Initialization
  /// -------------------------

  Future<void> _initializeVideoPlayers() async {
    videoControllers = [];
    chewieControllers = [];

    for (int index = 0; index < videos.length; index++) {
      final videoController = VideoPlayerController.asset(videos[index].url);

      await videoController.initialize();

      videoController.addListener(() {
        _onVideoProgress(index, videoController);
      });

      final chewieController = ChewieController(
        videoPlayerController: videoController,
        autoPlay: false,
        looping: false,
        allowFullScreen: true,
        allowMuting: true,
        allowPlaybackSpeedChanging: true,
        showControlsOnInitialize: true,
        materialProgressColors: ChewieProgressColors(
          playedColor: Colors.red,
          handleColor: Colors.red,
          backgroundColor: Colors.white24,
          bufferedColor: Colors.white54,
        ),
        placeholder: Container(
          color: Colors.black,
        ),
      );

      videoControllers.add(videoController);
      chewieControllers.add(chewieController);
    }
  }

  /// -------------------------
  /// Format Duration
  /// -------------------------

  String formatDuration(Duration d) {
    final minutes = d.inMinutes;
    final seconds = d.inSeconds % 60;
    return '${minutes}m ${seconds}s';
  }

  /// -------------------------
  /// Track Video Progress
  /// -------------------------

  void _onVideoProgress(int index, VideoPlayerController controller) {
    if (!controller.value.isInitialized) return;
    if (index != currentVideoIndex.value) return;

    final position = controller.value.position;
    final duration = controller.value.duration;

    videos[index].lastPosition = position;
    videos[index].totalDuration = duration;

    videos.refresh();

    if (controller.value.isCompleted &&
        !videos[index].isCompleted &&
        !isProcessingCompletion.value) {
      isProcessingCompletion.value = true;

      videos[index].isCompleted = true;

      videos.refresh();

      _saveProgress();

      Future.delayed(const Duration(milliseconds: 200), () {
        _playNextVideo(index);
        isProcessingCompletion.value = false;
      });
    }
  }

  /// -------------------------
  /// Change Video
  /// -------------------------

  void changeVideo(int index) {
    cancelNextVideo.value = true;
    showNextVideoOverlay.value = false;

    pauseAllVideos();

    currentVideoIndex.value = index;

    final videoController = videoControllers[index];
    final lastPosition = videos[index].lastPosition;

    if (lastPosition > Duration.zero) {
      videoController.seekTo(lastPosition);
    }

    videoController.play();
  }

  /// -------------------------
  /// Auto Play Next Video
  /// -------------------------

  void _playNextVideo(int currentIndex) {
    if (showNextVideoOverlay.value) return;

    final nextIndex = currentIndex + 1;

    if (nextIndex >= chewieControllers.length) return;

    cancelNextVideo.value = false;

    nextVideoCountdown.value = 5;
    showNextVideoOverlay.value = true;

    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));

      if (cancelNextVideo.value) return false;

      nextVideoCountdown.value--;

      if (nextVideoCountdown.value <= 0) {
        showNextVideoOverlay.value = false;

        changeVideo(nextIndex);

        return false;
      }

      return true;
    });
  }

  /// -------------------------
  /// Save Progress
  /// -------------------------

  void _saveProgress() {
    final data = videos.map((v) => {'isCompleted': v.isCompleted}).toList();

    box.write(storageKey, data);
  }

  /// -------------------------
  /// Pause All Videos
  /// -------------------------

  void pauseAllVideos() {
    for (final controller in videoControllers) {
      if (controller.value.isPlaying) {
        controller.pause();
      }
    }
  }

  /// -------------------------
  /// Dispose
  /// -------------------------

  @override
  void onClose() {
    for (final controller in chewieControllers) {
      controller.dispose();
    }

    for (final controller in videoControllers) {
      controller.dispose();
    }

    searchController.dispose();
    super.onClose();
  }
}
