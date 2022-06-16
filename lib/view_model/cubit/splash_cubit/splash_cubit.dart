import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:meta/meta.dart';
import 'package:wallpaper/view_model/navigator/navigator.dart';
import 'package:wallpaper/view_model/navigator/routes.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  static SplashCubit get(context) => BlocProvider.of<SplashCubit>(context);
// splash method to remove splash screen and navigate to home screen
  void splashLoaded() {
    FlutterNativeSplash.remove();

    Future.delayed(const Duration(seconds: 3), () {
      emit(SplashLoaded());
      CustomNavigator.push(Routes.home, clean: true);
    });
  }
}
