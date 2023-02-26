import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_search/data/repository/image_repository_impl.dart';
import 'package:image_search/domain/repositories/image_repository.dart';
import 'package:image_search/presentation/photo/bloc/photo_bloc.dart';
import 'package:image_search/presentation/photo/view/bottom_loader.dart';
import 'package:image_search/presentation/widgets/card.dart';
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
        child: PhotoScreen());
  }
}

class PhotoScreen extends StatefulWidget {
  PhotoScreen({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => PhotoScreen());
  }

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  late final ScrollController _scrollController = ScrollController();
  final scrollTop = GlobalKey();

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  String keyword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          controller: _scrollController,
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
                child: SearchBar(
                  onSubmitted: (String value) {
                    if (scrollTop.currentContext != null &&
                        _isVisible(scrollTop.currentContext!)) {
                      Scrollable.ensureVisible(scrollTop.currentContext!,
                          duration: const Duration(milliseconds: 150));
                    }
                    context.read<PhotoBloc>().add(SearchPhotos(keyword: value));
                  },
                ),
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

                  ///todo:
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
            BlocSelector<PhotoBloc, PhotoState, PhotoStatus>(
              selector: (state) {
                return state.status;
              },
              builder: (BuildContext context, PhotoStatus state) {
                return SliverOffstage(
                  offstage: state != PhotoStatus.success,
                  sliver: const SliverToBoxAdapter(
                    child: BottomLoader(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  bool _isVisible(BuildContext currentContext) {
    final box = currentContext.findRenderObject();
    final yPosition = (box as RenderBox).localToGlobal(Offset.zero).dy;

    return yPosition < 0;
  }

  void _onScroll() {
    if (_isBottom) context.read<PhotoBloc>().add(FetchPhotos());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 1);
  }
}
