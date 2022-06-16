import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wallpaper/constants/colors.dart';
import 'package:wallpaper/view_model/cubit/download_cubit/download_cubit.dart';
import 'package:wallpaper/view_model/cubit/photo_details_cubit/photodetails_cubit.dart';

class PhotoDetails extends StatefulWidget {
  final String url;
  final String author;
  final String description;
  const PhotoDetails(
      {Key? key,
      required this.url,
      required this.author,
      required this.description})
      : super(key: key);

  @override
  State<PhotoDetails> createState() => _PhotoDetailsState();
}

class _PhotoDetailsState extends State<PhotoDetails> {
  int progress = 0;

  ReceivePort _receivePort = ReceivePort();

  static callBack(id, status, progress) {
    //Looking up for a send port from the isolate
    SendPort? sendPort = IsolateNameServer.lookupPortByName("downloading");

    //If the send port is not null, we can send data to the isolate
    if (sendPort != null) {
      //Sending the data to the isolate
      sendPort.send([id, status, progress]);
    }
  }

  @override
  void initState() {
    //Registering the receive port with the isolate
    _receivePort.listen((message) {
      setState(() {
        progress = message[2];
      });

      print(progress);
    });
    IsolateNameServer.registerPortWithName(
        _receivePort.sendPort, "downloading");

    FlutterDownloader.registerCallback(callBack);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Stack(
        children: [
          Image.network(
            widget.url,
            fit: BoxFit.fill,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Card(
              color: white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              elevation: 4,
              child: Container(
                padding: const EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      'Photo By: ${widget.author}',
                      style: TextStyle(
                        fontSize: 20,
                        color: black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15,
                        color: black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        BlocBuilder<DownloadCubit, DownloadState>(
                          builder: (context, state) {
                            return Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: black),
                              child: IconButton(
                                icon: const Icon(Icons.download),
                                color: white,
                                onPressed: () {
                                  DownloadCubit.get(context)
                                      .download(widget.url);
                                },
                              ),
                            );
                          },
                        ),
                        BlocBuilder<PhotodetailsCubit, PhotodetailsState>(
                          builder: (context, state) {
                            return Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: black),
                              child: IconButton(
                                icon: const Icon(Icons.favorite),
                                color: white,
                                onPressed: () {
                                  PhotodetailsCubit.get(context)
                                      .addFavorite(url: widget.url);
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
