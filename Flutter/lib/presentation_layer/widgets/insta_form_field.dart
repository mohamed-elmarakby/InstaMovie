import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:insta_movie_app/presentation_layer/resources/color_manager.dart';
import 'package:insta_movie_app/presentation_layer/resources/style_manager.dart';
import 'package:insta_movie_app/presentation_layer/resources/value_manager.dart';

class InstaFormField extends StatelessWidget {
  String? label;
  String? hint;
  TextEditingController? controller;
  bool isLong;
  bool isPassword;
  bool isNumberField;
  bool readOnly;
  InstaFormField({
    Key? key,
    this.readOnly = false,
    this.isNumberField = false,
    this.isPassword = false,
    this.hint,
    this.isLong = false,
    required this.label,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        top: AppSize.s12,
        bottom: AppSize.s12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label',
            style: getMediumStyle(color: ColorManager.primaryWithOpacity40),
          ),
          TextField(
            controller: controller,
            cursorColor: ColorManager.primaryWithOpacity40,
            onEditingComplete: () {},
            readOnly: readOnly,
            enabled: !readOnly,
            keyboardType:
                isNumberField ? TextInputType.number : TextInputType.text,
            inputFormatters: isNumberField
                ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9,.-]'))]
                : [
                    FilteringTextInputFormatter.allow(
                        RegExp("[a-zA-Z0-9ا-يؤءئأإلأ -/'\"]"))
                  ],
            maxLines: isLong ? 10 : 1,
            obscureText: isPassword,
            decoration: InputDecoration(
              hintText: hint,
              border: isLong
                  ? OutlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorManager.primaryWithOpacity40,
                      ),
                    )
                  : UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorManager.primaryWithOpacity40,
                      ),
                    ),
              enabledBorder: isLong
                  ? OutlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorManager.primaryWithOpacity40,
                      ),
                    )
                  : UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorManager.primaryWithOpacity40,
                      ),
                    ),
              focusedBorder: isLong
                  ? OutlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorManager.primaryWithOpacity40,
                      ),
                    )
                  : UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorManager.primaryWithOpacity40,
                      ),
                    ),
              disabledBorder: isLong
                  ? OutlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorManager.primaryWithOpacity40,
                      ),
                    )
                  : UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorManager.primaryWithOpacity40,
                      ),
                    ),
              errorBorder: isLong
                  ? OutlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorManager.primaryWithOpacity40,
                      ),
                    )
                  : UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorManager.red,
                      ),
                    ),
              focusedErrorBorder: isLong
                  ? OutlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorManager.primaryWithOpacity40,
                      ),
                    )
                  : UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorManager.red,
                      ),
                    ),
              labelStyle: getRegularStyle(
                color: ColorManager.primaryWithOpacity40,
                fontSize: AppSize.s18,
              ),
              hintStyle: getRegularStyle(
                color: ColorManager.primaryWithOpacity40,
                fontSize: AppSize.s16,
              ),
              floatingLabelStyle: getMediumStyle(
                color: ColorManager.primaryWithOpacity40,
                fontSize: AppSize.s16,
              ),
            ),
            style: getMediumStyle(
              color: ColorManager.primary,
              fontSize: AppSize.s16,
            ),
          ),
        ],
      ),
    );
  }
}
