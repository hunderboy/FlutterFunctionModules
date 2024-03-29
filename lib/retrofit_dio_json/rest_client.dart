import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'data.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: 'https://reqres.in/api')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/users/{id}')
  Future<User> getUser({@Path() required int id});

  // @GET('/users/')
  // Future<String> namedExample(
  //     @Query("apikey") String apiKey,
  //     @Query("scope") String scope,
  //     @Query("type") String type,
  //     @Query("from") int from
  //     );


}