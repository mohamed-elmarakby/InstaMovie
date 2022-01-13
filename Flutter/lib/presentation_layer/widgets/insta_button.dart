import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:insta_movie_app/presentation_layer/resources/color_manager.dart';
import 'package:insta_movie_app/presentation_layer/resources/style_manager.dart';
import 'package:insta_movie_app/presentation_layer/resources/value_manager.dart';

class InstaButton extends StatefulWidget {
  void Function()? onPressed;
  String? title;
  bool loading;
  TextStyle? style;
  Color? color;
  InstaButton({
    Key? key,
    this.color,
    this.loading = false,
    this.style,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<InstaButton> createState() => _InstaButtonState();
}

class _InstaButtonState extends State<InstaButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        top: AppSize.s12,
        bottom: AppSize.s12,
      ),
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          primary: widget.color ?? ColorManager.primary,
        ),
        child: widget.loading
            ? Center(
                child:
                    SpinKitWave(color: ColorManager.black, size: AppSize.s18),
              )
            : Text(
                widget.title!,
                style: widget.style ??
                    getMediumStyle(
                      color: ColorManager.black,
                      fontSize: AppSize.s14,
                    ),
              ),
      ),
    );
  }
}
