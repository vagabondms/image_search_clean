import 'package:image_search/domain/model/response/photo_response.dart';

abstract class ImageRepository {
  Future<PhotoResponse> searchImages(
    String key,
    String q,
    String imageType,
    String page,
  );
}
