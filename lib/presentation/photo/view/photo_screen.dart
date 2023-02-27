import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_search/data/repository/image_repository_impl.dart';
import 'package:image_search/domain/repositories/image_repository.dart';
import 'package:image_search/presentation/photo/bloc/photo_bloc.dart';
import 'package:image_search/presentation/widgets/background_header_delegate.dart';
import 'package:image_search/presentation/widgets/card.dart';
import 'package:image_search/presentation/widgets/load_more.dart';
import 'package:image_search/presentation/widgets/search_bar.dart';

class PhotoPage extends StatelessWidget {
  PhotoPage({super.key});

  final ImageRepository _imageRepository = ImageRepositoryImpl();

  static Route<void> route() =>
      MaterialPageRoute<void>(builder: (_) => PhotoPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PhotoBloc(imageRepository: _imageRepository),
      child: const PhotoScreen(),
    );
  }
}

class PhotoScreen extends StatefulWidget {
  const PhotoScreen({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const PhotoScreen());
  }

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  final scrollTop = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  String keyword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          controller: PrimaryScrollController.of(context),
          slivers: <Widget>[
            //  search bar
            SliverPersistentHeader(
              pinned: true,
              delegate: BackgroundHeaderDelegate(
                searchBarHeight: 100,
                backgroundHeight: 300,
                minBackgroundHeight: 50,
                background: const Image(
                  image: AssetImage('assets/images/feature.png'),
                  fit: BoxFit.cover,
                ),
                child: SearchBar(onSubmitted: handleKeywordSubmitted),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 3,
                key: scrollTop,
              ),
            ),
            BlocBuilder<PhotoBloc, PhotoState>(builder: (
              BuildContext context,
              PhotoState state,
            ) {
              switch (state.status) {
                case PhotoStatus.initial:
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Text('검색어를 입력해주세요'),
                    ),
                  );
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
                default:
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Text('검색어를 다시 입력해주세요.'),
                    ),
                  );
              }
            }),
            SliverToBoxAdapter(
              child: LoadMore(onLoadMore: () {
                context.read<PhotoBloc>().add(FetchPhotos());
              }),
            ),
          ],
        ),
      ),
    );
  }

  void handleKeywordSubmitted(String value) {
    if (scrollTop.currentContext != null &&
        _isVisible(scrollTop.currentContext!)) {
      Scrollable.ensureVisible(scrollTop.currentContext!,
          duration: const Duration(milliseconds: 150));
    }
    context.read<PhotoBloc>().add(SearchPhotos(keyword: value));
  }

  bool _isVisible(BuildContext currentContext) {
    final box = currentContext.findRenderObject();
    final yPosition = (box as RenderBox).localToGlobal(Offset.zero).dy;

    return yPosition < 0;
  }
}
