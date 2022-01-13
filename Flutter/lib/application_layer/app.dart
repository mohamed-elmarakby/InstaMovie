import 'package:insta_movie_app/presentation_layer/screens/details/movie_details.dart';
import 'package:insta_movie_app/presentation_layer/screens/no_internet.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import '../presentation_layer/resources/route_manager.dart';
import '../presentation_layer/resources/string_manager.dart';
import '../presentation_layer/resources/theme_manager.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getApplicationThemeData(),
      onGenerateRoute: RouterGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      title: AppStrings.englishAppName,
      builder: (BuildContext context, Widget? child) {
        return StreamBuilder(
          stream: Connectivity().onConnectivityChanged,
          builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) {
            return snapshot.data != ConnectivityResult.none
                ? Builder(
                    builder: (BuildContext context) {
                      return child!;
                    },
                  )
                : const NoInternetPage(); // another material app for showing user he is offline
          },
        );
      },
    );
  }
}
