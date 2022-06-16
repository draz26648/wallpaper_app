import 'package:flutter/material.dart';

import '../../../view_model/helpers/shared_helper.dart';
import '../../widgets/photo_item.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<String> photos = [];
  @override
  void initState() {
    SharedHelper().readFavorites(CachingKey.favorite).then((value) {
      setState(() {
        photos.addAll(value);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    photos.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: GridView.builder(
        shrinkWrap: true,
        itemCount: photos.length,
        padding: const EdgeInsets.all(15),
        itemBuilder: (context, index) => PhotoItem(
          url: photos[index],
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
