import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:wallpaper/constants/colors.dart';
import 'package:wallpaper/view/screens/wallpaper_details/photo_details.dart';
import 'package:wallpaper/view_model/cubit/download_cubit/download_cubit.dart';
import 'package:wallpaper/view_model/cubit/home_cubit/home_cubit.dart';
import 'package:wallpaper/view_model/cubit/photo_details_cubit/photodetails_cubit.dart';
import 'package:wallpaper/view_model/cubit/search_cubit/search_cubit.dart';
import 'package:wallpaper/view_model/cubit/splash_cubit/splash_cubit.dart';
import 'package:wallpaper/view_model/navigator/navigator.dart';
import 'package:wallpaper/view_model/navigator/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
    debug: true, // set false to disable printing logs to console
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light, statusBarColor: black));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashCubit>(
          create: (context) => SplashCubit(),
        ),
        BlocProvider<HomeCubit>(
          create: (context) => HomeCubit(),
        ),
        BlocProvider<PhotodetailsCubit>(
            create: (context) => PhotodetailsCubit()),
        BlocProvider<SearchCubit>(create: (context) => SearchCubit()),
        BlocProvider<DownloadCubit>(create: (context) => DownloadCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Wallpaper',
        onGenerateRoute: CustomNavigator.onGenerateRoute,
        initialRoute: Routes.splash,
        navigatorKey: CustomNavigator.navigatorState,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
              backgroundColor: black,
              actionsIconTheme: const IconThemeData(color: Colors.white),
              iconTheme: const IconThemeData(color: Colors.white)),
          brightness: Brightness.light,
          primaryColor: black,
          backgroundColor: white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
    );
  }
}
