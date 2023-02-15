import 'package:image_search/domain/model/photo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'photo_response.g.dart';

@JsonSerializable()
class PhotoResponse {
  final int total;
  final int totalHits;
  final List<Photo> hits;

  PhotoResponse({
    required this.total,
    required this.totalHits,
    required this.hits,
  });

  factory PhotoResponse.fromJson(Map<String, dynamic> json) =>
      _$PhotoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PhotoResponseToJson(this);
}
