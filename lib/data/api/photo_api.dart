import 'package:dio/dio.dart';
import 'package:image_search/domain/model/photo.dart';
import 'package:image_search/domain/model/response/photo_response.dart';
import 'package:retrofit/retrofit.dart';

part 'photo_api.g.dart';

@RestApi(baseUrl: 'https://pixabay.com/api/')
abstract class PhotoApi {
  factory PhotoApi(Dio dio, {String baseUrl}) = _PhotoApi;

  @GET('/')
  Future<PhotoResponse> searchImages(
    @Query('key') String key,
    @Query('q') String q,
    @Query('image_type') String imageType,
  );
}
