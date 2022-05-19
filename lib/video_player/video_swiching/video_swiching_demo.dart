import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';

class VideoSwichingDemo extends StatefulWidget {
  @override
  _VideoSwichingDemoState createState() => _VideoSwichingDemoState();
}
class _VideoSwichingDemoState extends State<VideoSwichingDemo> {

  int index = 0;
  double _position = 0;
  double _buffer = 0;
  bool _lock = true; // 영상 재생 잠금
  final Set<String> _urls = {
    'https://resources.mora.kr/static/exercise/media/507/M20/267a1d83d7d2fbf451be5573a17cd38d.mp4',
    'https://resources.mora.kr/static/exercise/media/749/M5/ba0b4e3b8503e4d7628ae599e434ac27.mp4',
    'https://resources.mora.kr/static/exercise/media/991/M20/bf886b49f48b75ec6f52a4cc4c3df8a3.mp4',
    'https://resources.mora.kr/static/exercise/media/994/M10/598171f9921f5ddbe0427e6e22cd3574.mp4',
    'https://resources.mora.kr/static/exercise/media/631/M20/e1fb9c20ccde971dc19d2713e331f71e.mp4',
    'https://resources.mora.kr/static/exercise/media/933/M15/fc8dabc115a9340fafcb58fcf89fb4da.mp4',
    'https://resources.mora.kr/static/exercise/media/1000/M15/8c1146f5460026596593ace0761426c7.mp4',
    'https://resources.mora.kr/static/exercise/media/922/M10/20f6cb7e1394be01d2eb200e392ceb79.mp4',
    'https://resources.mora.kr/static/exercise/media/908/M15/4285af1607b6b91a5b5fc52ae6e47d2a.mp4',
    'https://resources.mora.kr/static/exercise/media/907/M20/26901613dcee04449688631ea6a8d6d3.mp4',
  };

  // final List<String> urls_media = [
  //   // 'https://resources.mora.kr/static/exercise/media/749/M5/ba0b4e3b8503e4d7628ae599e434ac27.mp4', // 25초 영상
  //   // 'https://resources.mora.kr/static/exercise/media/419/M10/75f8e340956b9c2dcee18e5db30a1d87.mp4',
  //   // 'https://resources.mora.kr/static/exercise/media/337/M10/eb188e76a91f293e7834fe69e82d66ad.mp4',
  //   // 'https://resources.mora.kr/static/exercise/media/184/M10/f784c790f48791b98e7a649aa1363113.mp4',
  //   // 'https://resources.mora.kr/static/exercise/media/191/M10/b831d682465a36d463d05ab5f41c33eb.mp4',
  //   // 'https://resources.mora.kr/static/exercise/media/186/M5/6a7d12718ce08b5dd9dbc7b78dff5cbf.mp4',
  // ];
  // final List<String> urls_thumnail = [
  //   // 'https://resources.mora.kr/static/exercise/media/186/MT/3e3c6f178eb6ed427c3f5cbca77d40ee.png',
  //   // 'https://resources.mora.kr/static/exercise/media/419/MT/bf68cf2043e01be75e05483c8ad2ca4f.png',
  //   // 'https://resources.mora.kr/static/exercise/media/337/MT/9dd1eee3a24c881a6d7d86371200a784.png',
  //   // 'https://resources.mora.kr/static/exercise/media/184/MT/74a051dd6b6459f56060ffd22afa7782.png',
  //   // 'https://resources.mora.kr/static/exercise/media/191/MT/c236f6c94ab0138b24a50459402ce5d4.png',
  //   // 'https://resources.mora.kr/static/exercise/media/186/MT/3e3c6f178eb6ed427c3f5cbca77d40ee.png',
  // ];

  /// key : _urls.elementAt(index) 예를 들면 'https://resources.mora.kr/static/exercise/media/507/M20/267a1d83d7d2fbf451be5573a17cd38d.mp4' 이게 Key 가 됨.
  /// value : VideoPlayerController
  /// [todo] 예시 ------------------------------------------------
  /// { 'https://resources.mora.kr/static/exercise/media/507/M20/267a1d83d7d2fbf451be5573a17cd38d.mp4' , VideoPlayerController}
  /// { 'https://resources.mora.kr/static/exercise/media/749/M5/ba0b4e3b8503e4d7628ae599e434ac27.mp4' , VideoPlayerController}
  Map<String, VideoPlayerController> _controllers = {};
  /// key : index 값
  /// value : _listenerSpawner(index) = VoidCallback
  /// [todo] 예시 ------------------------------------------------
  /// { 0 , _listenerSpawner(0)}
  /// { 1 , _listenerSpawner(1)}
  Map<int, VoidCallback> _listeners = {};




  VoidCallback _listenerSpawner(index) {
    return () {
      int dur = _controller(index)!.value.duration.inMilliseconds;
      int pos = _controller(index)!.value.position.inMilliseconds;
      // int buf = _controller(index)!.value.buffered.last.end.inMilliseconds;
      int buf = 0;

      setState(() {
        if (dur <= pos) {
          _position = 0;
          return;
        }
        _position = pos / dur;
        _buffer = buf / dur;
      });
      // print("dur : $dur");
      // print("---------------- pos : $pos");

      /// 끝나면
      if (dur - pos < 1) {
        if (index < _urls.length - 1) {
          _nextVideo(); // 다음 비디오 재생
        }
      }
    };
  }

  @override
  void initState() {
    super.initState();

    /// [todo] 결론 : VideoContorller 초기화는 현재 재생 [index,index+1] 이렇게 2개만 설정한다.
    if (_urls.isNotEmpty) {
      // index=0 번째 컨트롤러를 초기화 한다. (시작하는 videoController 초기화)
      _initController(0).then((_) {
        _playController(0); // index=0 번째 초기화가 끝나면 영상을 재생 한다.
      });

      /// 1번째 인덱스까지 Controller 가 초기화가 완료 되면
      /// _lock = false 설정한다. (영상 재생 잠금 해제의 의미)
      _initController(1).whenComplete(
        () => _lock = false
      );
    }


    /// [todo] then vs whenComplete
    /// Then과 whenComplete는 역할이 다르다.
    /// 1. Then은 Error가 없다면 결괏값을 value로 받아서 실행한다. 하지만, Error가 Return 되면 출력이 되지 않는다.
    /// 2. WhenComplete는 Future가 끝나면 무조건 실행된다.(Error 발생 유무에 관계가 없다.)
    /// catchError는 Error가 Return이 될 때 작동하며, Error가 Return 되더라도 catchError가 있다면 Then이 실행된다.
  }

  VideoPlayerController? _controller(int index) {
    return _controllers[_urls.elementAt(index)];
  }

  Future<void> _initController(int index) async {
    var controller = VideoPlayerController.network(_urls.elementAt(index));
    // var controller = VideoPlayerController.asset('assets/video/'+_urls.elementAt(index)+'.mp4');
    // await controller.initialize();
    await controller.initialize().then((_) {
      _controllers[_urls.elementAt(index)] = controller; /// 초기화 완료 되면 _controllers 에 추가한다.
      print("키 이름 : "+_urls.elementAt(index));
      print("_controllers 사이즈 : "+_controllers.length.toString());
    });
  }

  _playController(int index) async {
    if (!_listeners.keys.contains(index)) { /// _listeners 의 key 들 중에 해당 index 값이 없는 경우
      _listeners[index] = _listenerSpawner(index); /// 추가한다.
    }
    print("_listeners 사이즈 : "+_listeners.length.toString());
    _controller(index)!.addListener(_listeners[index]!);
    await _controller(index)!.play();
    setState(() {});
  }

  _removeController(int index) {
    _controller(index)!.dispose(); // 컨트롤러 해제
    _controllers.remove(_urls.elementAt(index)); // 컨트롤러 맵에서 컨트롤러 제거
    _listeners.remove(index); // 리스너도 제거
  }

  _stopController(int index) {
    _controller(index)!.removeListener(_listeners[index]!); // 컨트롤러에서 리스너 제거
    _controller(index)!.pause();
    _controller(index)!.seekTo(Duration(milliseconds: 0));
  }

  _previousVideo() {
    if (_lock || index == 0) {
      return;
    }

    _lock = true;
    _stopController(index);

    /// 다음 인덱스의 비디오 컨트롤러 제거
    if (index + 1 < _urls.length) {
      _removeController(index + 1);
    }

    /// 이전 영상 재생 (이전 영상의 컨트롤러는 0초 상태로 세팅 된 후, 다음재생 되게끔 되어 있음.)
    _playController(--index);

    /// 이전 영상 재생을 위한 컨트롤러 초기화 세팅
    if (index == 0) {
      _lock = false;
    } else {
      _initController(index - 1).whenComplete(() => _lock = false);
    }
  }

  _nextVideo() async {
    /// 만약, _lock = true or index 가 마지막 인덱스 인경우
    if (_lock || index == _urls.length - 1) {
      return;
    }

    _lock = true;
    _stopController(index);

    /// 이전 인덱스의 비디오 컨트롤러 제거
    if (index - 1 >= 0) {
      _removeController(index - 1);
    }

    /// 다음 영상 재생 (다음영상의 컨트롤러는 이전 영상 재생될때 이미 초기화 되었음)
    _playController(++index);

    /// 다음 영상 재생을 위한 컨트롤러 초기화 세팅
    if (index == _urls.length - 1) {
      _lock = false;
    } else {
      _initController(index + 1).whenComplete(() => _lock = false);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,   // ios 상태바 텍스트 컬러 = black
        ),
        title: Text("index $index of ${_urls.length-1}"),
      ),
      body: Stack(
        children: <Widget>[
          /// 비디오 플레이어
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
          /// 버퍼 progress
          Positioned(
            child: Container(
              height: 10,
              width: MediaQuery.of(context).size.width * _buffer,
              color: Colors.grey,
            ),
          ),
          /// 재생 progress
          Positioned(
            child: Container(
              height: 10,
              width: MediaQuery.of(context).size.width * _position,
              color: Colors.greenAccent,
            ),
          ),
        ],
      ),
      /// 좌 우 이동 플로팅 버튼
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: 'previous',
              onPressed: _previousVideo, child: Icon(FontAwesomeIcons.arrowLeft)),
          SizedBox(width: 24),
          FloatingActionButton(
              heroTag: 'next',
              onPressed: _nextVideo, child: Icon(FontAwesomeIcons.arrowRight)),
        ],
      ),
    );
  }
  @override
  void dispose() {
    print("ControllerTest - dispose()");
    for(int i = 0; i < _urls.length; i++){
      _controller(i)?.dispose();
    }
    super.dispose();
  }
}