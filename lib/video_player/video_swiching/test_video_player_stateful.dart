import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';



class VideoPlayerScreen extends StatefulWidget {
  VideoPlayerScreen({Key? key}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void>? _initializeVideoPlayerFuture;
  late int _playBackTime;

  //The values that are passed when changing quality
  // late Duration newCurrentPosition;

  // String defaultStream =
  //     'https://archive.org/download/Damas_BB_28F8B535_D_406/DaMaS.mp4';
  // String stream2 = 'https://archive.org/download/cCloud_20151126/cCloud.mp4';
  // String stream3 = 'https://archive.org/download/mblbhs/mblbhs.mp4';


  String defaultStream = 'assets/video/sample_elbow_plank.mp4';
  String stream2 = 'assets/video/sample_kneeup_crunch_holding.mp4';
  String stream3 = 'assets/video/sample_superman_extension.mp4';


  @override
  void initState() {
    // _controller = VideoPlayerController.network(defaultStream);
    _controller = VideoPlayerController.asset(defaultStream);
    _controller.addListener(() {
      setState(() {
        _playBackTime = _controller.value.position.inSeconds;
      });
    });
    _initializeVideoPlayerFuture = _controller.initialize();

    // _initializePlay(defaultStream);
    super.initState();
  }

  @override
  void dispose() {
    _initializeVideoPlayerFuture = null;
    _controller.pause().then((_) {
      _controller.dispose();
    });
    super.dispose();
  }

  void _getValuesAndPlay(String videoPath) {
    // newCurrentPosition = _controller.value.position; // ?? 무슨 말인가?
    _startPlay(videoPath);
  }

  Future<void> _startPlay(String videoPath) async {
    setState(() {
      _initializeVideoPlayerFuture = null;
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      _clearPrevious().then((_) {
        _initializePlay(videoPath);
      });
    });
  }

  Future<bool> _clearPrevious() async {
    await _controller.pause();
    return true;
  }

  Future<void> _initializePlay(String videoPath) async {
    // _controller = VideoPlayerController.network(videoPath);
    _controller = VideoPlayerController.asset(videoPath);
    _controller.addListener(() {
      setState(() {
        _playBackTime = _controller.value.position.inSeconds;
      });
    });
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      // _controller.seekTo(newCurrentPosition);
      _controller.play();
    });
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
              children: [

                FutureBuilder(
                    future: _initializeVideoPlayerFuture,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {

                        print("정상적으로 영상 데이터 가져옴");
                        return
                          /// 비디오 플레이어
                          Container(
                            child: AspectRatio(
                              aspectRatio: 16 / 9,
                              // Use the VideoPlayer widget to display the video.
                              child: VideoPlayer(_controller),
                            ),
                          );
                      }
                      else {
                        print("영상 데이터 불러오는중");
                        return const Center(child: CircularProgressIndicator());
                      }
                    }
                ),

                Container(
                  margin: const EdgeInsets.all(10),
                  child: FloatingActionButton(
                    onPressed: () {
                      // Wrap the play or pause in a call to `setState`. This ensures the
                      // correct icon is shown.
                      setState(() {
                        // If the video is playing, pause it.
                        if (_controller.value.isPlaying) {
                          _controller.pause();
                        } else {
                          // If the video is paused, play it.
                          _controller.play();
                        }
                      });
                    },
                    // Display the correct icon depending on the state of the player.
                    child: Icon(
                      _controller.value.isPlaying
                          ? FontAwesomeIcons.pause
                          : FontAwesomeIcons.play,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Text(
                      _controller.value.position
                          .toString()
                          .split('.')
                          .first
                          .padLeft(8, "0"),
                      style: TextStyle(fontSize: 30)
                  ),
                ),
                Container(
                  child: ElevatedButton(
                    child: const Text("Default Stream"),
                    style:
                    ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.yellow, elevation: 0,          // 글자색
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    onPressed: () {
                      _getValuesAndPlay(defaultStream);
                    },
                  ),
                ),
                Container(
                  child: ElevatedButton(
                    child: const Text("Video Stream 2"),
                    style:
                    ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.red, elevation: 0,          // 글자색
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    onPressed: () {
                      _getValuesAndPlay(stream2);
                    },
                  ),
                ),
                Container(
                  child: ElevatedButton(
                    child: const Text("Video Stream 3"),
                    style:
                    ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.green, elevation: 0,          // 글자색
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    onPressed: () {
                      _getValuesAndPlay(stream3);
                    },
                  ),
                )

              ]
          )
        )
    );

  }
}