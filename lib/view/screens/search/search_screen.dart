import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper/model/models/photos_model.dart';
import 'package:wallpaper/view_model/cubit/search_cubit/search_cubit.dart';

import '../../../model/models/base_models/photos.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/photo_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  late List<Photo> photos;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Material(
              color: Colors.white,
              elevation: 2,
              borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(47),
                  bottomLeft: Radius.circular(47)),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.13,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(47),
                        bottomLeft: Radius.circular(47))),
                child: Padding(
                  padding:
                      const EdgeInsets.only(bottom: 15, right: 30, left: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CupertinoButton(
                          padding: const EdgeInsets.only(top: 8),
                          child: const Icon(CupertinoIcons.chevron_back,
                              color: Colors.white, size: 24),
                          onPressed: () => Navigator.pop(context)),
                      Expanded(
                        child: CustomTextField(
                          height: 40,
                          radius: 30,
                          controller: _searchController,
                          onChanged: (String value) {
                            if (value.isNotEmpty) {
                              SearchCubit.get(context)
                                  .getResult(searchText: value);
                            }
                          },
                          validate: () {},
                          icon: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Icon(Icons.search),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                margin: const EdgeInsets.only(top: 20),
                height: MediaQuery.of(context).size.height * 0.84,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(47),
                    topLeft: Radius.circular(47),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).primaryColor.withOpacity(0.4),
                        offset: const Offset(-1.0, -1.0),
                        blurRadius: 5.0)
                  ],
                ),
                child: BlocConsumer<SearchCubit, SearchState>(
                  listener: ((context, state) {
                    if (state is SearchLoaded) {
                      photos = state.photos;
                    }
                  }),
                  builder: (context, state) {
                    if (state is SearchLoaded) {
                      return GridView.builder(
                        shrinkWrap: true,
                        itemCount: state.photos.length,
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
                      );
                    } else if (state is SearchLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return Container();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    photos.clear();
    super.dispose();
  }
}
