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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PhotoResponse>(
        future: _imageRepository.searchImages(
            dotenv.env['key'] ?? '', 'apple', 'photo'),
        builder: (BuildContext context, AsyncSnapshot<PhotoResponse> snapshot) {
          if (!snapshot.hasData) return Container();
          return Scaffold(
            body: CustomScrollView(
              slivers: <Widget>[
                //  search bar
                SliverPersistentHeader(
                  pinned: true,
                  delegate: MyHeaderDelegate(),
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
