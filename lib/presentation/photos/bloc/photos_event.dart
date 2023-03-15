part of 'photos_bloc.dart';

@immutable
abstract class PhotoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchPhotos extends PhotoEvent {}

class SearchPhotos extends PhotoEvent {
  SearchPhotos({
    required this.keyword,
  });
  final String keyword;
}
