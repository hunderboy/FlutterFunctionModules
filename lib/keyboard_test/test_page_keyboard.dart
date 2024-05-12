import 'package:flutter/material.dart';


class TestPageKeyboard extends StatelessWidget {
  const TestPageKeyboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get.put(UserJoinController());
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Keyboard Test'),
      ),
      body: Stack(
        children: [ // Riverpod 테스트 2
          SafeArea(
            child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child:
                SingleChildScrollView(
                    child: Container(
                      /// MediaQuery의 경우 값이 변경되는 경우 rebuild 하면서 UI가 새로 그려진다.
                      /// 대신 MediaQueryData.fromWindow(WidgetsBinding.instance.window) 은
                      /// top-level property인 WidgetsBinding.instance.window 사용하여 스마트폰 화면의 size 를 추출하고
                      /// MediaQueryData.size 속성을 WidgetsBinding.instance.window 할당 받음 으로써 변수가 아닌 고정값으로 할당 되게끔 하여 UI 리빌딩을 막는다.
                        height:
                        MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height
                            - AppBar().preferredSize.height //  = kToolbarHeight
                            - MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding.top // Status Bar
                            - MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding.bottom, // Bottom
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        child: Form(
                            key: _formKey,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget> [
                                  Container(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: const Text("회원가입", style: TextStyle(color: Colors.black, fontSize: 26, fontWeight: FontWeight.bold)),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(top: 12),
                                    child: const Text("비밀번호를 설정해 주세요.", style: TextStyle(color: Color(0xff747474), fontSize: 16)),
                                  ),
                                  /// 이름, 성별
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        /// 이름
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.only(top: 30),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Padding(padding: EdgeInsets.only(left: 10, bottom: 10),
                                                  child: Text("이름", style: TextStyle(color: Color(0xff545454), fontSize: 16, fontWeight: FontWeight.w500)),
                                                ),
                                                TextField(
                                                  enabled: false,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    contentPadding: const EdgeInsets.only(top: 17, bottom: 17, left: 20),
                                                    fillColor: const Color(0xffF2F2F2),
                                                    filled: true,
                                                    hintText: '홍길동',
                                                    hintStyle: const TextStyle(fontSize: 16, color: Color(0xff747474)),
                                                    disabledBorder: OutlineInputBorder(
                                                      borderSide: const BorderSide(width: 2, color: Color(0xffF2F2F2)),
                                                      borderRadius: BorderRadius.circular(14),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        // const SizedBox(width: 10),
                                        /// 성별
                                        /// todo. 나중에 다시 살릴 예정이므로 삭제 x
                                        // Expanded(
                                        //   child: Container(
                                        //     padding: const EdgeInsets.only(top: 30, left: 10),
                                        //     child: Column(
                                        //       crossAxisAlignment: CrossAxisAlignment.start,
                                        //       children: [
                                        //         const Padding(
                                        //           padding: EdgeInsets.only(left: 10, bottom: 10),
                                        //           child: Text("성별", style: TextStyle(color: Color(0xff545454), fontSize: 16, fontWeight: FontWeight.bold)),
                                        //         ),
                                        //         TextField(
                                        //           enabled: false,
                                        //           decoration: InputDecoration(
                                        //             isDense: true,
                                        //             contentPadding: const EdgeInsets.only(top: 17, bottom: 17, left: 20),
                                        //             fillColor: const Color(0xffF2F2F2),
                                        //             filled: true,
                                        //             hintText: controller.gender,
                                        //             hintStyle: const TextStyle(fontSize: 15, color: Color(0xff747474)),
                                        //             disabledBorder: OutlineInputBorder(
                                        //               borderSide: const BorderSide(width: 2, color: Color(0xffF2F2F2)),
                                        //               borderRadius: BorderRadius.circular(14),
                                        //             ),
                                        //           ),
                                        //         ),
                                        //       ],
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  /// 휴대폰 번호
                                  Container(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(left: 10, bottom: 10),
                                          child: Text("휴대폰번호(ID)", style: TextStyle(color: Color(0xff545454), fontSize: 16, fontWeight: FontWeight.w500)),
                                        ),
                                        TextField(
                                          enabled: false,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            contentPadding: const EdgeInsets.only(top: 17, bottom: 17, left: 20),
                                            fillColor: const Color(0xffF2F2F2),
                                            filled: true,
                                            hintText: '010-1234-5678',
                                            hintStyle: const TextStyle(fontSize: 16, color: Color(0xff747474)),
                                            disabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(width: 2, color: Color(0xffF2F2F2)),
                                              borderRadius: BorderRadius.circular(14),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  /// 비밀번호
                                  Container(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10, bottom: 5),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text("비밀번호", style: TextStyle(color: Color(0xff545454), fontSize: 16, fontWeight: FontWeight.w500)),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 10, bottom: 6),
                                                child: SizedBox(
                                                  height: 25,
                                                  width: 40,
                                                  child: TextButton(
                                                    style: TextButton.styleFrom(splashFactory: NoSplash.splashFactory),
                                                    onPressed: () {
                                                      // controller.togglePasswordView();
                                                    },
                                                    child: Icon(
                                                      Icons.remove_red_eye,
                                                      size: 18,
                                                      color: const Color(0xffAEAEAE),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        TextFormField(
                                          textInputAction: TextInputAction.done,
                                          onFieldSubmitted: (value) async {
                                            FocusScope.of(context).requestFocus(FocusNode());
                                          },
                                          // obscureText: controller.isActivePasswordHidden.value,
                                          // obscuringCharacter: '●',
                                          // controller: controller.passwordController,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            contentPadding: const EdgeInsets.only(top: 17, bottom: 17, left: 20),
                                            hintText: '8-12자의 영문 대소문자, 숫자, 특수문자를 조합',
                                            hintStyle: const TextStyle(fontSize: 16, color: Color(0xffAEAEAE)),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(width: 1, color: Color(0xffDDDDDD)),
                                              borderRadius: BorderRadius.circular(14),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(width: 1, color: Color(0xff07BEB8)),
                                              borderRadius: BorderRadius.circular(14),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(width: 1, color: Color(0xffE74C3C)),
                                              borderRadius: BorderRadius.circular(14),
                                            ),
                                            focusedErrorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(width: 1, color: Color(0xffE74C3C)),
                                              borderRadius: BorderRadius.circular(14),
                                            ),
                                            errorStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
                                          ),
                                          validator: (String? val) {
                                            // return controller.isValidPassword(val ?? '')
                                            //     ? null
                                            //     : '비밀번호는 8-12자의 영문 대소문자, 숫자, 특수문자를 조합해서 사용하세요.';
                                          },
                                          onChanged: (val) {
                                            // controller.passwordController.addListener(() {
                                            //   controller.isActiveJoinCompletionButton.value = controller.passwordController.text.isNotEmpty;
                                            // });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  /// 비밀번호 확인
                                  Container(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(left: 10, bottom: 10),
                                          child: Text("비밀번호 확인", style: TextStyle(color: Color(0xff545454), fontSize: 16, fontWeight: FontWeight.w500)),
                                        ),
                                        Container(
                                          child: TextFormField(
                                            textInputAction: TextInputAction.done,
                                            onFieldSubmitted: (value) async {
                                              FocusScope.of(context).requestFocus(FocusNode());
                                            },
                                            // obscureText: controller.isActivePasswordHidden.value,
                                            // obscuringCharacter: '●',
                                            // controller: controller.checkPasswordController,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding: const EdgeInsets.only(top: 17, bottom: 17, left: 20),
                                              hintText: '위의 비밀번호를 다시 입력해 주세요',
                                              hintStyle: const TextStyle(fontSize: 16, color: Color(0xffAEAEAE)),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(width: 1, color: Color(0xffDDDDDD)),
                                                borderRadius: BorderRadius.circular(14),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(width: 1, color: Color(0xff07BEB8)),
                                                borderRadius: BorderRadius.circular(14),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(width: 1, color: Color(0xffE74C3C)),
                                                borderRadius: BorderRadius.circular(14),
                                              ),
                                              focusedErrorBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(width: 1, color: Color(0xffE74C3C)),
                                                borderRadius: BorderRadius.circular(14),
                                              ),
                                              errorStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
                                            ),
                                            validator: (val) {
                                              // if (val != controller.passwordController.text) {
                                              //   return '비밀번호가 일치하지 않습니다.';
                                              // }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(child:Container()),
                                  /// 가입완료 버튼
                                  Container(
                                      margin: const EdgeInsets.only(bottom: 20),
                                      child: SizedBox(
                                          width: double.infinity,
                                          height: 60,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: const Color(0xff07beb8),
                                                elevation: 0,
                                                shadowColor: Colors.transparent,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                                              ),
                                              child: const Text('가입완료', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600)),
                                              // onPressed:
                                              // controller.isActiveJoinCompletionButton.value ?
                                              //     () async {
                                              //   /// formKey 의 현재상태가 존재 할경우 form value 의 validate 유효성 검사 실시. 통과 경우 true
                                              //   /// 각 TextFormField 의 validator 가 null 반환 할 경우 통과
                                              //   if (_formKey.currentState!.validate()) {
                                              //     _formKey.currentState!.save();
                                              //     controller.password = controller.passwordController.text;
                                              //
                                              //     print('password : '+controller.password);
                                              //     print('phoneNumber : '+controller.phoneNumber);
                                              //     print('receiptId : '+controller.receiptId);
                                              //
                                              //     /// 회원가입 요청
                                              //     controller.join(
                                              //         context,
                                              //         controller.password,
                                              //         controller.phoneNumber,
                                              //         controller.receiptId
                                              //     );
                                              //   }
                                              //
                                              // }
                                              //     : () {},
                                              onPressed: (){

                                              }

                                          )
                                      )
                                  )
                                ]
                            )
                        )
                    )
                )

            )
        ),
        // Container(
        //     child: controller.isLoading.value
        //         ? Loader(loadingTxt: 'Content is loading...')
        //         : Container())
        ]
      )
    );
  }
}