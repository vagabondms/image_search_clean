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
    return Scaffold(
      body: Center(
        child: FutureBuilder<PhotoResponse>(
          future: _imageRepository.searchImages(
              dotenv.env['key'] ?? '', 'apple', 'photo'),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Container();
          },
        ),
      ),
    );
  }
}
