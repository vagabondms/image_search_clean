import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_search/data/repository/image_repository_impl.dart';
import 'package:image_search/domain/model/response/photo_response.dart';
import 'package:image_search/domain/repositories/image_repository.dart';

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
                /// Appbar background
                SliverAppBar(
                  backgroundColor: Colors.red,
                  title: const Text('hi'),
                  elevation: 0,
                  expandedHeight: 300,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ),

                /// search bar
                const SliverAppBar(
                  title: Text('hi'),
                  pinned: true,
                  elevation: 0,
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(-10.0),
                    child: SizedBox(),
                  ),
                  flexibleSpace: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Card(
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

class Card extends StatelessWidget {
  const Card({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 200,
          child: Image.network(imageUrl, fit: BoxFit.fitWidth),
        ),
      ),
    );
  }
}
