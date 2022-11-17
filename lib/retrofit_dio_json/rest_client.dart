import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'data.dart';

// part 'retrofit_dio_json.dart';

@RestApi(baseUrl: 'https://reqres.in/api')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/users/{id}')
  Future<User> getUser({@Path() required int id});
}