import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper/view_model/cubit/splash_cubit/splash_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SplashCubit.get(context).splashLoaded();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<SplashCubit, SplashState>(
        builder: (context, state) {
          return const Center(
            child: Image(image: AssetImage('assets/images/logo.jpg')),
          );
        },
      ),
    );
  }
}
