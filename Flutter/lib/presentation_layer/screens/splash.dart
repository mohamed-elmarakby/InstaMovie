import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:insta_movie_app/presentation_layer/resources/assets_manager.dart';
import 'package:insta_movie_app/presentation_layer/resources/color_manager.dart';
import 'package:insta_movie_app/presentation_layer/resources/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;

  Future<int> getFromMemory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int counter = (prefs.getInt('in') ?? 0);
    return counter;
  }

  _startDelay() {
    _timer = Timer(
      const Duration(seconds: 2),
      () async {
        await getFromMemory().then((value) => value == 0
            ? Navigator.pushReplacementNamed(
                context,
                Routes.loginRoute,
              )
            : Navigator.pushReplacementNamed(
                context,
                Routes.registerRoute,
              ));
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Image.asset(AssetsManager.splashGif),
        ),
      ),
    );
  }
}
