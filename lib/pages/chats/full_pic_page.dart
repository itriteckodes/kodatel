import 'package:flutter/material.dart';
import 'package:kodatel/constant.dart';
import 'package:photo_view/photo_view.dart';

class FullPhotoPage extends StatelessWidget {
  final String url;

  const FullPhotoPage({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
      ),
      body: PhotoView(
        customSize: Size(width(context), height(context)),
        imageProvider: NetworkImage(
          url,
        ),
      ),
    );
  }
}
