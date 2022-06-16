import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper/model/models/base_models/photos.dart';
import 'package:wallpaper/view_model/cubit/home_cubit/home_cubit.dart';
import 'package:wallpaper/view_model/navigator/navigator.dart';
import 'package:wallpaper/view_model/navigator/routes.dart';

import '../../widgets/photo_item.dart';

class PhotosScreen extends StatefulWidget {
  const PhotosScreen({Key? key}) : super(key: key);

  @override
  State<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  //this list will be used to store all the photos
  late List<Photo> photos;

  Future _refresh() async {
    HomeCubit.get(context).getPhotos();
  }

  @override
  void initState() {
    //get all photo when the screen is created
    HomeCubit.get(context).getPhotos(
      page: 2, // page number is 2 because we already have 1 page of photos
      perPage: 40, // per page is 40 because we want to get 40 photos
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          centerTitle: true,
          actions: [
            //this is the action button to go to the search screen
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                CustomNavigator.push(Routes.search);
              },
            ),
          ],
          elevation: 0,
        ),
        body: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            //check if state al already loaded and if it is then set the photos list to the state photos list
            if (state is HomeLoaded) {
              photos = state.photos;
            }
          },
          builder: (context, state) {
            return (state is HomeLoading)
                ? const Center(child: CircularProgressIndicator())
                :
                // we use gird view to display all the photos in the screen
                RefreshIndicator(
                    onRefresh: _refresh,
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: photos.length,
                      padding: const EdgeInsets.all(15),
                      itemBuilder: (context, index) => PhotoItem(
                        url: photos[index].src!.portrait!,
                        author: photos[index].photographer!,
                        description: photos[index].alt!,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2 / 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                    ),
                  );
          },
        ));
  }
}
