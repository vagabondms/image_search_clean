import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_search/data/repository/image_repository_impl.dart';
import 'package:image_search/domain/model/response/photo_response.dart';
import 'package:image_search/domain/repositories/image_repository.dart';
import 'package:image_search/presentation/widgets/card.dart';
import 'package:image_search/presentation/widgets/search_bar.dart';

class PhotoScreen extends StatefulWidget {
  const PhotoScreen({Key? key}) : super(key: key);

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  final ImageRepository _imageRepository = ImageRepositoryImpl();

  @override
  void initState() {
    super.initState();
  }

  String keyword = '';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PhotoResponse>(
        future: _imageRepository.searchImages(
            dotenv.env['key'] ?? '', keyword, 'photo'),
        builder: (BuildContext context, AsyncSnapshot<PhotoResponse> snapshot) {
          if (!snapshot.hasData) return Container();
          return Scaffold(
            body: CustomScrollView(
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
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return PhotoCard(
                        imageUrl: snapshot.data!.hits[index].largeImageURL,
                      );
                    },
                    childCount: snapshot.data!.hits.length,
                  ),
                ),
              ],
            ),
          );
        });
  }
}
