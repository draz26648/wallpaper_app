import 'package:flutter/material.dart';
import 'package:wallpaper/view/screens/wallpaper_details/photo_details.dart';
import 'package:wallpaper/view_model/navigator/routes.dart';

import '../../view_model/navigator/navigator.dart';

// this is the code that will be used to create a photo item widget this better than widget method and better in performance
class PhotoItem extends StatelessWidget {
  final String url;
  final String author;
  final String description;
  const PhotoItem(
      {Key? key, required this.url, this.author = '', this.description = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PhotoDetails(
                      url: url,
                      author: author,
                      description: description,
                    )));
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            url,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
