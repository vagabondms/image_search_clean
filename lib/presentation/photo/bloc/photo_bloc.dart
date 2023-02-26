import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_search/domain/model/photo.dart';
import 'package:image_search/domain/model/response/photo_response.dart';
import 'package:image_search/domain/repositories/image_repository.dart';
import 'package:meta/meta.dart';

part 'photo_event.dart';
part 'photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final ImageRepository imageRepository;

  PhotoBloc({
    required this.imageRepository,
  }) : super(PhotoState.loading()) {
    on<PhotoFetched>(_photoFetched);
  }

  _photoFetched(PhotoFetched event, Emitter<PhotoState> emit) async {
    try {
      if (state.status == PhotoStatus.initial) {
        final PhotoResponse photoResponse = await imageRepository.searchImages(
          dotenv.env['key'] ?? '',
          'apple',
          'photo',
        );
        return emit(state.copyWith(
          status: PhotoStatus.success,
          total: photoResponse.total,
          totalHits: photoResponse.totalHits,
          hits: photoResponse.hits,
        ));
      } else if (state.status == PhotoStatus.success) {
        final PhotoResponse photoResponse = await imageRepository.searchImages(
          dotenv.env['key'] ?? '',
          'apple',
          'photo',
        );
        return emit(state.copyWith(
          status: PhotoStatus.success,
          total: photoResponse.total,
          totalHits: photoResponse.totalHits,
          hits: photoResponse.hits,
        ));
      }
    } catch (e) {
      emit(state.copyWith(status: PhotoStatus.failure));
    }
  }

  /// legnth가 들어오면 loadMore;
  void _fetchPhotos([int? length]) {
    if (length != null) {
    } else {}
  }
}
