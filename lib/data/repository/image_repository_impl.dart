import 'package:dio/dio.dart';
import 'package:image_search/data/api/photo_api.dart';
import 'package:image_search/domain/model/response/photo_response.dart';
import 'package:image_search/domain/repositories/image_repository.dart';

class ImageRepositoryImpl implements ImageRepository {
  final Dio photoDio = Dio();

  @override
  Future<PhotoResponse> searchImages(
    String key,
    String q,
    String imageType,
  ) async {
    return PhotoApi(photoDio).searchImages(key, q, imageType);
  }
}
