import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';



class TestPageIndexedStack extends StatefulWidget {
  const TestPageIndexedStack({Key? key}) : super(key: key);

  @override
  State<TestPageIndexedStack> createState() => _TestPageIndexedStackState();
}

class _TestPageIndexedStackState extends State<TestPageIndexedStack> {

  int lobbyPageIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Indexed Stack'),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
            child: IndexedStack(
                index: lobbyPageIndex,
                children: const [
                  //index = 0
                  Center(child: Text('0 Page')),
                  //index = 1
                  Center(child: Text('1 Page')),
                  //index = 2
                  Center(child: Text('2 Page')),
                ]
            )
        ),
        bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 20,
                )
              ],
            ),
            child: BottomNavigationBar(
              selectedItemColor: const Color(0xFF13141A),   // Acitve 글자색 변경
              unselectedItemColor: const Color(0xFFACACAD), // Deacitve 글자색 변경
              type: BottomNavigationBarType.fixed, // 바텀네비게이션 아이템 폭 고정
              selectedFontSize: 12,
              unselectedFontSize: 12,

              currentIndex: lobbyPageIndex,
              onTap: (index){
                setState(() {
                  lobbyPageIndex = index;
                });
              },
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/svg/icon/ic_navi_home.svg',
                    colorFilter: const ColorFilter.mode(Color(0xFFACACAD), BlendMode.srcIn),
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/svg/icon/ic_navi_home.svg',
                    colorFilter: const ColorFilter.mode(Color(0xFF13141A), BlendMode.srcIn),
                  ),
                  label: '홈',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/svg/icon/ic_navi_add.svg',
                    colorFilter: const ColorFilter.mode(Color(0xFFACACAD), BlendMode.srcIn),
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/svg/icon/ic_navi_add.svg',
                    colorFilter: const ColorFilter.mode(Color(0xFF13141A), BlendMode.srcIn),
                  ),
                  label: '추가',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/svg/icon/ic_navi_search.svg',
                    colorFilter: const ColorFilter.mode(Color(0xFFACACAD), BlendMode.srcIn),
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/svg/icon/ic_navi_search.svg',
                    colorFilter: const ColorFilter.mode(Color(0xFF13141A), BlendMode.srcIn),
                  ),
                  label: '검색',
                ),
              ],
            )
        )
    );
  }
}

