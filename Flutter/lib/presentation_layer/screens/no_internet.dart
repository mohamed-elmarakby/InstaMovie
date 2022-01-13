import 'package:flutter/material.dart';
import 'package:insta_movie_app/presentation_layer/resources/color_manager.dart';
import 'package:insta_movie_app/presentation_layer/resources/string_manager.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 7,
              child: Image.asset(
                'assets/images/no-connection-transparenat.png',
                fit: BoxFit.contain,
              ),
            ),
            Expanded(
              child: Text(
                AppStrings.noConnection,
                style: TextStyle(
                  fontSize: 22,
                  color: ColorManager.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
