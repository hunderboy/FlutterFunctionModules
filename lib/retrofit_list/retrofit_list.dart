import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../retrofit_dio_json/custom_log_interceptor.dart';
import 'images_rest_client.dart';

class RetrofitList extends StatelessWidget {
  RetrofitList({Key? key}) : super(key: key);

  final dio = Dio()
    ..interceptors.add(
      CustomLogInterceptor(),
    );

  @override
  Widget build(BuildContext context) {
    final _client = RestClient(dio);

    return Scaffold(
      appBar: AppBar(
        title: const Text('RetrofitList'),
      ),
      body: Center(
        // child:  Text('RetrofitList'),
        child:
        FutureBuilder<List<KakaoImage>?>(
          future: _client.getImageDatas("안녕", 30, 1), // 데이터 요청
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const Text('RetrofitList');

              // ImageDatas? userInfo = snapshot.data;
              // if (userInfo != null) {
              //   Data userData = userInfo.data;
              //   return Text('RetrofitList');
              // }
            }
            return const CircularProgressIndicator();
          },
        )
      )
    );
  }
}