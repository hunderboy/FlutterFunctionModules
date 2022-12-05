import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'images.dart';

part 'images_rest_client.g.dart';

@RestApi(baseUrl: 'https://dapi.kakao.com/v2/search')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;


  @GET('/image')
  Future<Map<String, List<KakaoImage>>> getImageDatas(
      @Query("query") String query,
      @Query("size") int size,
      @Query("page") int page,
      );
}
