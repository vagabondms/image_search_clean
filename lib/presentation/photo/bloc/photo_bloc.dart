import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_search/domain/model/photo.dart';
import 'package:image_search/domain/model/response/photo_response.dart';
import 'package:image_search/domain/repositories/image_repository.dart';
import 'package:meta/meta.dart';

part 'photo_event.dart';
part 'photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final ImageRepository imageRepository;

  final int _perPage = 20;
  String keyword = '';

  PhotoBloc({
    required this.imageRepository,
  }) : super(PhotoState.loading()) {
    on<FetchPhotos>(
      _photoFetched,
      transformer: droppable(),
    );
    on<SearchPhotos>(
      _search,
      transformer: droppable(),
    );
  }

  _search(SearchPhotos event, Emitter<PhotoState> emit) async {
    keyword = event.keyword;

    try {
      final PhotoResponse photoResponse = await _fetchPhotos();
      if (photoResponse.totalHits == 0) {
        return emit(state.copyWith(status: PhotoStatus.failure));
      }

      return emit(state.copyWith(
        status: PhotoStatus.success,
        total: photoResponse.total,
        totalHits: photoResponse.totalHits,
        hits: photoResponse.hits,
      ));
    } catch (e) {
      emit(state.copyWith(status: PhotoStatus.failure));
    }
  }

  _photoFetched(FetchPhotos event, Emitter<PhotoState> emit) async {
    try {
      final PhotoResponse photoResponse =
          await _fetchPhotos((state.hits.length ~/ _perPage) + 1);

      return emit(state.copyWith(
        status: PhotoStatus.success,
        total: photoResponse.total,
        totalHits: photoResponse.totalHits,
        hits: List.of(state.hits)..addAll(photoResponse.hits),
      ));
    } catch (e) {
      emit(state.copyWith(status: PhotoStatus.failure));
    }
  }

  /// legnth가 들어오면 loadMore;
  Future<PhotoResponse> _fetchPhotos([int? page]) async {
    print(page);
    return await imageRepository.searchImages(
      dotenv.env['key'] ?? '',
      keyword,
      'photo',
      page.toString(),
    );
  }
}
