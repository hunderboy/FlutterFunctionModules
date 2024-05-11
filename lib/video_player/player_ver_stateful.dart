import 'package:flutter/material.dart';
import 'package:flutter_function_modules/video_player/model/exercise_item.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';


class PlayerVerStateFul extends StatefulWidget {
  const PlayerVerStateFul({Key? key}) : super(key: key);

  // @override
  // _PlayerVerStateFulState createState() => _PlayerVerStateFulState();

  @override
  PlayerVerStateFulState createState() => PlayerVerStateFulState();

  //context를 반환하는 함수 'of'를 static으로 생성한다.
  static PlayerVerStateFulState? of(BuildContext context) =>
      context.findAncestorStateOfType<PlayerVerStateFulState>();
}

class PlayerVerStateFulState extends State<PlayerVerStateFul>
  with TickerProviderStateMixin
  // with SingleTickerProviderStateMixin
{
/// Player code ------------------------------------------------------------------------------------------------
  late VideoPlayerController playerController;
  late Future<void>? _initializeVideoPlayerFuture;
  late int _playBackTime;


  void setPlayerState() {
    if (playerController.value.isPlaying) {
      stopVideo();
    } else {
      // print("playVideo()");
      playVideo();
    }
  }
  stopVideo(){
    playerController.pause();
    animationController.stop();
  }
  playVideo(){
    playerController.play();
    print("playVideo()");
    animationController.reverse(  // 애니메이션 재생
        from: animationController.value == 0 ? 1.0 : animationController.value);
  }

/// -----------------------------------------------------------------------------
  late List<ExerciseItem> exerciseList;
  late AnimationController animationController;

  /// 카운트다운 시 남아 있는 시간 정보
  late int remainMinutes; // 분
  late int remainSeconds; // 초

  /// 모든 운동 진행 데이터는 컨트롤러에서 관리
  int _playingPosiotion = 0;

  initAnimationController(){
    print("playerController.value.duration :"+playerController.value.duration.toString());
    animationController = AnimationController(vsync: this, duration: playerController.value.duration);
    print("애니메이션 초기화됨.");
  }


  List<ExerciseItem> setTodayExercise() {
    List<ExerciseItem> todayExerciseProgram = <ExerciseItem>[]; // 초기화

    // 10개의 샘플 운동을 TodayExercisePlanList_1 에 추가한다.
    for (int i=0; i<7; i++) {
      switch(i) {
        case 0:
          ExerciseItem item = ExerciseItem(
              runTime : "00:06",
              title : "카운트다운",
              fileTitle : "countdown",// countdown
              isComplete: false);
          todayExerciseProgram.add(item);
          break;
        case 1:
          ExerciseItem item = ExerciseItem(
              runTime : "00:35",
              title : "코브라 스트레칭",
              fileTitle : "sample_abdominal_stretching_cobra",// sample_abdominal_stretching_cobra
              isComplete: false);
          todayExerciseProgram.add(item);
          break;
        case 2:
          ExerciseItem item = ExerciseItem(
              runTime : "00:46",
              title : "볼 스퀴즈",
              fileTitle : "sample_ball_squeeze",// sample_ball_squeeze
              isComplete: false);
          todayExerciseProgram.add(item);
          break;
        case 3:
          ExerciseItem item = ExerciseItem(
              runTime : "00:32",
              title : "백 스탭",
              fileTitle : "sample_center_front_back_step", // sample_center_front_back_step
              isComplete: false);
          todayExerciseProgram.add(item);
          break;
        case 4:
          ExerciseItem item = ExerciseItem(
              runTime : "00:41",
              title : "팔꿈치 플랭크",
              fileTitle : "sample_elbow_plank",// sample_elbow_plank
              isComplete: false);
          todayExerciseProgram.add(item);
          break;
        case 5:
          ExerciseItem item = ExerciseItem(
              runTime : "00:30",
              title : "니 업 크런치 홀딩",
              fileTitle : "sample_kneeup_crunch_holding", // sample_knee_slide
              isComplete: false);
          todayExerciseProgram.add(item);
          break;
        case 6:
          ExerciseItem item = ExerciseItem(
              runTime : "01:01",
              title : "슈퍼맨 익스텐션",
              fileTitle : "sample_superman_extension", // sample_kneeup_crunch_holding
              isComplete: false);
          todayExerciseProgram.add(item);
          break;
      }
    }

    return todayExerciseProgram;
  }



  @override
  void initState() {
    exerciseList = setTodayExercise();
    // 운동중인 Position의 운동 데이터 진행률 초기화
    // => 다시 운동종료 후 다시 운동 플레이 화면으로 돌아오게되면 기존에 플레이하던 progress 값이 남아있는 문제 발생 해결을 위해
    exerciseList[_playingPosiotion].progress = 0.0;
    exerciseList[_playingPosiotion].remainingTimeText = exerciseList[_playingPosiotion].runTime;

    /// VideoPlayer 초기화
    playerController = VideoPlayerController.asset('assets/video/'+exerciseList[0].fileTitle+'.mp4');
    initAnimationController();
    _initializeVideoPlayerFuture = playerController.initialize().then((_) {
      // playVideo();
      initAnimationController();
    });
    playerController.addListener(() {
      setState(() {
        // _playBackTime = playerController.value.position.inSeconds;

        if(playerController.value.position == playerController.value.duration || playerController.value.position > playerController.value.duration){
          print("재생 완료");
          // 원상복귀
          exerciseList[_playingPosiotion].progress = 0.0;
          exerciseList[_playingPosiotion].remainingTimeText = exerciseList[_playingPosiotion].runTime;
          // 운동 완료 설정
          exerciseList[_playingPosiotion].isComplete = true;
          // 다음 포지션 설정
          _playingPosiotion = _playingPosiotion+1;
          _getValuesAndPlay(_playingPosiotion);
        }
        else{
          // print("비디오플레이어 재생중");
          remainMinutes = playerController.value.duration.inMinutes-playerController.value.position.inMinutes;
          remainSeconds = playerController.value.duration.inSeconds-playerController.value.position.inSeconds;
          // 카운트다운 텍스트 설정
          exerciseList[_playingPosiotion].remainingTimeText
          = '${(remainMinutes % 60).toString().padLeft(2, '0')}:${(remainSeconds % 60).toString().padLeft(2, '0')}';
        }

      });
    });

    animationController.addListener(() {
      print("애니메이팅 중");
      setState(() {
        if (animationController.isAnimating) {
          print("애니메이팅 중");
          exerciseList[_playingPosiotion].progress = 1-animationController.value;
          // exerciseList
        }
      });
    });


    super.initState();
  }

  @override
  void dispose() {
    _initializeVideoPlayerFuture = null;
    playerController.pause().then((_) {
      playerController.dispose();
    });
    animationController.dispose();
    super.dispose();
  }


/// 영상 스위칭 -----------------------------------------------------------------------------
  void _getValuesAndPlay(int positionToPlay) {
    print('재생할 포지션 : $positionToPlay');
    _startPlay(positionToPlay);
  }

  Future<void> _startPlay(int positionToPlay) async {
    setState(() {
      _initializeVideoPlayerFuture = null;
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      _clearPrevious().then((_) {
        _initializePlay(positionToPlay);
      });
    });
  }

  Future<bool> _clearPrevious() async {
    await playerController.pause();
    return true;
  }

  Future<void> _initializePlay(int positionToPlay) async {
    playerController = VideoPlayerController.asset('assets/video/'+exerciseList[positionToPlay].fileTitle+'.mp4');
    playerController.addListener(() {
      setState(() {
        _playBackTime = playerController.value.position.inSeconds;
      });
    });
    _initializeVideoPlayerFuture = playerController.initialize().then((_) {
      // playerController.seekTo(newCurrentPosition);
      playerController.play();
    });
  }







  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// 비디오 플레이어
              Container(
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      VideoPlayer(playerController),
                      _ControlsOverlay(
                          playerController: playerController,

                      ),
                    ],
                  ),),),

              Expanded(
                child: ListView.builder(
                      primary: false, // 리스트 스크롤 허용
                      itemCount: exerciseList.length,
                      shrinkWrap: true, // 아이템 수만큼 높이 설정
                      itemBuilder: (BuildContext context, int index) {  /// index 는 0 부터..
                        return _TodayPlanListItem(
                            title: exerciseList[index].title,
                            remainingTimeText: exerciseList[index].remainingTimeText,
                            progress: exerciseList[index].progress
                        );
                      },
                  ),
              ),

            ]
        ),),);
  }


}



/// 운동 아이템
class _TodayPlanListItem extends StatelessWidget {
  _TodayPlanListItem({Key? key,
    required this.title,
    required this.remainingTimeText,
    required this.progress
  }) : super(key: key);
  String title;
  String remainingTimeText;
  double progress;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
            children: <Widget>[

              Container(
                width: double.infinity,
                height: 100,
                child: LinearProgressIndicator(
                  value: progress,
                  color: Color(0x6607BEB8),
                  backgroundColor: Colors.transparent,
                ),
              ),  // 운동 progress

              Container(
                padding: const EdgeInsets.only(left: 20),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child:
                      Text(remainingTimeText, style: TextStyle(fontSize: 18)),  // 운동 타이머
                    ),  // 메인 이미지 운동 제목
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(title, style: TextStyle(fontSize: 15)), // 운동 제목
                            ),  // 메인 이미지 운동 제목
                            // Container(
                            //   child: Text("오른발", style: TextStyle(fontSize: 12)), // 운동 서브 타이틀
                            // ),  // 메인 이미지 운동 시간
                          ]
                      ),
                    ),
                  ],
                ),
              ),

            ]
        ),

        const Divider(color: Colors.black38, height: 1,),

      ],
    );
  }

}




/// 비디오플레이어 컨트롤러
class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({Key? key,
    required this.playerController,

  }) : super(key: key);
  final VideoPlayerController playerController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(right: 10),
          child: Align(
            alignment: Alignment.topRight,
            child:
            IconButton(
              onPressed: () {
                PlayerVerStateFul.of(context)?.setPlayerState();
              },
              icon: Icon(
                // getxController.isVideoPlaying.value ? Icons.pause : Icons.play_arrow,
                playerController.value.isPlaying ? FontAwesomeIcons.pause : FontAwesomeIcons.play,
                // PlayerVerStateFul.of(context)?.playerController != null ?
                // playerController.value.isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 40.0,
                semanticLabel: 'Play',
              ),
            )

          ),
        ),
      ],
    );
  }

}