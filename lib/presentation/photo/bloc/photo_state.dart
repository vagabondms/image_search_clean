part of 'photo_bloc.dart';

enum PhotoStatus { initial, success, failure }

@immutable
class PhotoState extends Equatable {
  const PhotoState({
    required this.total,
    required this.totalHits,
    required this.hits,
    required this.status,
  });

  final int total;
  final int totalHits;
  final List<Photo> hits;
  final PhotoStatus status;

  PhotoState copyWith({
    int? total,
    int? totalHits,
    List<Photo>? hits,
    PhotoStatus? status,
  }) {
    return PhotoState(
      total: total ?? this.total,
      totalHits: totalHits ?? this.totalHits,
      hits: hits ?? this.hits,
      status: status ?? this.status,
    );
  }

  factory PhotoState.loading() {
    return const PhotoState(
      total: 0,
      totalHits: 0,
      hits: [],
      status: PhotoStatus.initial,
    );
  }

  @override
  List<Object> get props => [total, totalHits, hits, status];
}
