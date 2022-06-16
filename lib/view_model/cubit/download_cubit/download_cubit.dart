import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

part 'download_state.dart';

class DownloadCubit extends Cubit<DownloadState> {
  DownloadCubit() : super(DownloadInitial());

  static DownloadCubit get(context) => BlocProvider.of<DownloadCubit>(context);

  void download(String url) async {
    emit(DownloadLoading());
    final status = await Permission.storage.request();

    if (status.isGranted) {
      final externalDir = await getExternalStorageDirectory();
      // ignore: unused_local_variable
      final id = await FlutterDownloader.enqueue(
        url: url,
        savedDir: externalDir!.path,
        fileName: "wallpaper_${DateTime.now().millisecondsSinceEpoch}",
        showNotification: true,
        openFileFromNotification: true,
      );
      emit(DownloadSuccess());
    } else {
      // ignore: avoid_print
      print('Permission Denied');
      emit(DownloadError());
    }
  }
}
