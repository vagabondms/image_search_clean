import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_search/data/repository/image_repository_impl.dart';
import 'package:image_search/domain/repositories/image_repository.dart';
import 'package:image_search/presentation/photo/bloc/photo_bloc.dart';
import 'package:image_search/presentation/widgets/card.dart';
import 'package:image_search/presentation/widgets/search_bar.dart';

class PhotoPage extends StatelessWidget {
  const PhotoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PhotoScreen();
  }

  static Route<void> route() =>
      MaterialPageRoute<void>(builder: (_) => const PhotoPage());
}

class PhotoScreen extends StatelessWidget {
  PhotoScreen({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => PhotoScreen());
  }

  final ImageRepository _imageRepository = ImageRepositoryImpl();

  String keyword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) =>
            PhotoBloc(imageRepository: _imageRepository)..add(PhotoFetched()),
        child: CustomScrollView(
          slivers: <Widget>[
            //  search bar
            const SliverPersistentHeader(
              pinned: true,
              delegate: BackgroundHeaderDelegate(
                searchBarHeight: 100,
                backgroundHeight: 300,
                minBackgroundHeight: 50,
                background: Image(
                  image: AssetImage('assets/images/feature.png'),
                  fit: BoxFit.cover,
                ),
                child: SearchBar(),
              ),
            ),
            BlocBuilder<PhotoBloc, PhotoState>(builder: (
              BuildContext context,
              PhotoState state,
            ) {
              switch (state.status) {
                case PhotoStatus.initial:
                  return SliverToBoxAdapter(child: Container());
                case PhotoStatus.success:
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return PhotoCard(
                          imageUrl: state.hits[index].largeImageURL,
                        );
                      },
                      childCount: state.hits.length,
                    ),
                  );
                case PhotoStatus.failure:
                  return SliverToBoxAdapter(child: Container());
                default:
                  return SliverToBoxAdapter(child: Container());
              }
            }),
          ],
        ),
      ),
    );
  }
}
