import 'package:flutter/material.dart';

class PhotoScreen extends StatelessWidget {
  const PhotoScreen({Key? key, url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Scaffold(
        body: Center(
          child: Image.network(
              'https://pixabay.com/get/ga0fc42f6f5da1b40dd43db00d34bd8e92c2baa9ed487bf7f8ff9a9573bada5a9c62061aaca1a01ee50fd9acea44243d09a4e5a29b761fd8bb5f88063fc16bd39_1280.jpg'),
        ),
      ),
    );
  }
}
