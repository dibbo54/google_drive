//import 'dart:html';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String url;

  AudioPlayerWidget(this.url);

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  AudioPlayer audioPlayer = AudioPlayer();
  Duration duration = Duration();
  Duration position = Duration();

  bool playing = false;
  @override
  void initState() {
    // TODO: implement initState
    handleAudio();
    super.initState();
  }

  handleAudio() async {
    if (playing) {
      var res = await audioPlayer.pause();
      if (res == 1) {
        setState(() {
          playing = false;
        });
      }
    } else {
      var res = await audioPlayer.play(widget.url, isLocal: false);
      if (res == 1) {
        setState(() {
          playing = true;
        });
      }
    }

    audioPlayer.onDurationChanged.listen(
      (Duration dd) {
        if (mounted)
          setState(
            () {
              duration = dd;
            },
          );
      },
    );

    audioPlayer.onAudioPositionChanged.listen(
      (Duration dd) {
        if (mounted)
          setState(
            () {
              position = dd;
            },
          );
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            width: 64,
            height: 64,
            image: AssetImage('images/mp3.png'),
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 40,
          ),
          Slider.adaptive(
              min: 0.0,
              value: position.inSeconds.toDouble(),
              max: duration.inSeconds.toDouble(),
              onChanged: (double value) {
                setState(() {
                  audioPlayer.seek(Duration(seconds: value.toInt()));
                });
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  audioPlayer.seek(Duration(seconds: position.inSeconds - 15));
                },
                icon: Icon(Icons.fast_rewind_rounded),
                color: Colors.white,
                iconSize: 32,
              ),
              IconButton(
                onPressed: () {
                  handleAudio();
                },
                icon: Icon(playing == false
                    ? Icons.play_circle_fill
                    : Icons.pause_circle_filled),
                color: Colors.white,
                iconSize: 56,
              ),
              IconButton(
                onPressed: () {
                  audioPlayer.seek(Duration(seconds: position.inSeconds + 15));
                },
                icon: Icon(Icons.fast_forward_rounded),
                color: Colors.white,
                iconSize: 32,
              ),
            ],
          )
        ],
      ),
    );
  }
}
