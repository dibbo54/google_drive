import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerwidget extends StatefulWidget {
  final String url;

  const VideoPlayerwidget(this.url, {super.key});

  @override
  State<VideoPlayerwidget> createState() => _VideoPlayerwidgetState();
}

class _VideoPlayerwidgetState extends State<VideoPlayerwidget> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  bool initialized = false;

  @override
  void initState() {
    videoPlayerController = VideoPlayerController.network(widget.url);
    videoPlayerController.initialize().then(
      (value) {
        chewieController = ChewieController(
          videoPlayerController: videoPlayerController,
          autoPlay: true,
          looping: false,
        );
        initialized = true;
        setState(() {});
      },
    );
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: initialized?Chewie(controller: chewieController):Center(
        child: CircularProgressIndicator(),
      )
    );
  }
}
