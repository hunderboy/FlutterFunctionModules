import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerDemo extends StatefulWidget {
  @override
  _VideoPlayerDemoState createState() => _VideoPlayerDemoState();
}
class _VideoPlayerDemoState extends State<VideoPlayerDemo> {

  int index = 0;
  double _position = 0;
  double _buffer = 0;
  bool _lock = true;
  Map<String, VideoPlayerController> _controllers = {};
  Map<int, VoidCallback> _listeners = {};
  final Set<String> _urls = {
    // 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4#1',
    // 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4#2',
    // 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4#3',
    // 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4#4',
    // 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4#5',
    // 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4#6',
    // 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4#7',
    'https://resources.mora.kr/static/exercise/media/507/M20/267a1d83d7d2fbf451be5573a17cd38d.mp4',
    'https://resources.mora.kr/static/exercise/media/749/M5/ba0b4e3b8503e4d7628ae599e434ac27.mp4',
    'https://resources.mora.kr/static/exercise/media/991/M20/bf886b49f48b75ec6f52a4cc4c3df8a3.mp4',
    // 'https://resources.mora.kr/static/exercise/media/994/M10/598171f9921f5ddbe0427e6e22cd3574.mp4',
    // 'https://resources.mora.kr/static/exercise/media/631/M20/e1fb9c20ccde971dc19d2713e331f71e.mp4',
    // 'https://resources.mora.kr/static/exercise/media/933/M15/fc8dabc115a9340fafcb58fcf89fb4da.mp4',
    // 'https://resources.mora.kr/static/exercise/media/1000/M15/8c1146f5460026596593ace0761426c7.mp4',
    // 'https://resources.mora.kr/static/exercise/media/922/M10/20f6cb7e1394be01d2eb200e392ceb79.mp4',
    // 'https://resources.mora.kr/static/exercise/media/908/M15/4285af1607b6b91a5b5fc52ae6e47d2a.mp4',
    // 'https://resources.mora.kr/static/exercise/media/907/M20/26901613dcee04449688631ea6a8d6d3.mp4',
  };
  // final Set<String> _urls = {
  //   'countdown',
  //   'sample_abdominal_stretching_cobra',
  //   'sample_ball_squeeze',
  //   'sample_center_front_back_step',
  //   'sample_elbow_plank',
  //   'sample_kneeup_crunch_holding',
  //   'sample_superman_extension',
  // };

  @override
  void initState() {
    super.initState();
    if (_urls.length > 0) {
      _initController(0).then((_) {
        _playController(0);
      });
    }
    if (_urls.length > 1) {
      _initController(1).whenComplete(() => _lock = false);
    }
  }

  VoidCallback _listenerSpawner(index) {
    return () {
      int dur = _controller(index)!.value.duration.inMilliseconds;
      int pos = _controller(index)!.value.position.inMilliseconds;
      int buf = _controller(index)!.value.buffered.last.end.inMilliseconds;

      setState(() {
        if (dur <= pos) {
          _position = 0;
          return;
        }
        _position = pos / dur;
        _buffer = buf / dur;
      });
      print("dur : $dur");
      print("---------------- pos : $pos");

      if (dur - pos < 1) {
        if (index < _urls.length - 1) {
          _nextVideo();
        }
      }
    };
  }

  VideoPlayerController? _controller(int index) {
    return _controllers[_urls.elementAt(index)];
  }

  Future<void> _initController(int index) async {
    var controller = VideoPlayerController.network(_urls.elementAt(index));
    // var controller = VideoPlayerController.asset('assets/video/'+_urls.elementAt(index)+'.mp4');
    _controllers[_urls.elementAt(index)] = controller;
    await controller.initialize();
    print("사이즈 : "+_controllers.length.toString());
  }

  void _removeController(int index) {
    _controller(index)!.dispose();
    _controllers.remove(_urls.elementAt(index));
    _listeners.remove(index);
  }

  void _stopController(int index) {
    _controller(index)!.removeListener(_listeners[index]!);
    _controller(index)!.pause();
    _controller(index)!.seekTo(Duration(milliseconds: 0));
  }

  void _playController(int index) async {
    if (!_listeners.keys.contains(index)) { /// 리스너들에 해당 인덱스의 키를 포함하지 않고 있다면,
      _listeners[index] = _listenerSpawner(index); /// 추가한다.
    }
    _controller(index)!.addListener(_listeners[index]!);
    await _controller(index)!.play();
    setState(() {});
  }

  void _previousVideo() {
    if (_lock || index == 0) {
      return;
    }
    _lock = true;

    _stopController(index);

    if (index + 1 < _urls.length) {
      _removeController(index + 1);
    }

    _playController(--index);

    if (index == 0) {
      _lock = false;
    } else {
      _initController(index - 1).whenComplete(() => _lock = false);
    }
  }

  void _nextVideo() async {
    if (_lock || index == _urls.length - 1) {
      return;
    }
    _lock = true;

    _stopController(index);

    if (index - 1 >= 0) {
      _removeController(index - 1);
    }

    _playController(++index);

    if (index == _urls.length - 1) {
      _lock = false;
    } else {
      _initController(index + 1).whenComplete(() => _lock = false);
    }
  }







  /// 위젯 Build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,   // ios 상태바 텍스트 컬러 = black
        ),
        title: Text("Playing ${index + 1} of ${_urls.length}"),
      ),
      body: Stack(
        children: <Widget>[
          GestureDetector(
            onLongPressStart: (_) => _controller(index)!.pause(),
            onLongPressEnd: (_) => _controller(index)!.play(),
            child: Center(
              child: AspectRatio(
                aspectRatio: _controller(index)!.value.aspectRatio,
                child: Center(child: VideoPlayer(_controller(index)!)),
              ),
            ),
          ),
          Positioned(
            child: Container(
              height: 10,
              width: MediaQuery.of(context).size.width * _buffer,
              color: Colors.grey,
            ),
          ),
          Positioned(
            child: Container(
              height: 10,
              width: MediaQuery.of(context).size.width * _position,
              color: Colors.greenAccent,
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(onPressed: _previousVideo, child: Icon(FontAwesomeIcons.arrowLeft)),
          SizedBox(width: 24),
          FloatingActionButton(onPressed: _nextVideo, child: Icon(FontAwesomeIcons.arrowRight)),
        ],
      ),
    );
  }
  @override
  void dispose() {
    print("ControllerTest - onClose()");
    super.dispose();
  }
}