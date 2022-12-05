import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../retrofit_dio_json/custom_log_interceptor.dart';
import 'images_rest_client.dart';
import 'kakao_data.dart';

class RetrofitList extends StatelessWidget {
  RetrofitList({Key? key}) : super(key: key);

  final dio = Dio()
    ..interceptors.add(
      CustomLogInterceptor(),
    );

  @override
  Widget build(BuildContext context) {

    dio.options.headers["Authorization"] = "KakaoAK 53a7d75ab73902f2362333caed881270"; // config your dio headers globally
    final _client = RestClient(dio);

    return Scaffold(
      appBar: AppBar(
        title: const Text('RetrofitList'),
      ),
      body: Center(
        // child:  Text('RetrofitList'),
        child:
        FutureBuilder<KakaoData?>(
          future: _client.getImageDatas("안녕", 2, 1), // 데이터 요청
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              KakaoData? kakaoDataInfo = snapshot.data;

              if (kakaoDataInfo != null) {
                print("total_count : "+kakaoDataInfo.meta.total_count.toString());
                print("pageable_count : "+kakaoDataInfo.meta.pageable_count.toString());
                print("is_end : "+kakaoDataInfo.meta.is_end.toString());
                return const Text('is here');
              }


              return const Text('nothing');

              // List<ImageData> imageList = snapshot.documents;
              // if (imageList != null) {
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