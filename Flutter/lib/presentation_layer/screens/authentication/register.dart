import 'package:insta_movie_app/presentation_layer/resources/string_manager.dart';
import 'package:insta_movie_app/presentation_layer/widgets/insta_button.dart';
import 'package:insta_movie_app/presentation_layer/widgets/insta_form_field.dart';

import '../../resources/color_manager.dart';
import '../../resources/route_manager.dart';
import '../../resources/style_manager.dart';
import '../../resources/value_manager.dart';
import '../../widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future putInMemory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('in', 1);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacementNamed(
            context,
            Routes.loginRoute,
          );
          return true;
        },
        child: Scaffold(
          appBar: appBarWidget(
            backAllowed: true,
            context: context,
            routeName: Routes.loginRoute,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: AppSize.s14,
                  top: AppSize.s28,
                  end: AppSize.s14,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSize.s28),
                      child: Text(
                        AppStrings.createAccount,
                        style: getBoldStyle(
                          color: ColorManager.primary,
                          fontSize: AppSize.s34,
                        ),
                      ),
                    ),
                    InstaFormField(
                      label: AppStrings.email,
                      controller: usernameController,
                      hint: AppStrings.emailExample,
                    ),
                    InstaFormField(
                      label: AppStrings.password,
                      controller: passwordController,
                      isPassword: true,
                      hint: AppStrings.passwordExample,
                    ),
                    InstaFormField(
                      label: AppStrings.confirmPassword,
                      controller: confirmPasswordController,
                      isPassword: true,
                      hint: AppStrings.passwordExample,
                    ),
                    InstaButton(
                        loading: false,
                        title: AppStrings.register,
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, Routes.loginRoute);
                        }),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.only(top: AppSize.s12),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, Routes.loginRoute);
                        },
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: AppStrings.haveAnAccount,
                                style: getMediumStyle(
                                  color: ColorManager.grey,
                                  fontSize: 14,
                                ),
                              ),
                              TextSpan(
                                text: AppStrings.login,
                                style: getBoldStyle(
                                  color: ColorManager.red,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // state is ErrorState
                    //     ? Center(
                    //         child: Text(
                    //         authenticationCubit.loginResponse.messageAr!,
                    //         style: getMediumStyle(
                    //           color: ColorManager.error,
                    //           fontSize: 21,
                    //         ),
                    //       ))
                    //     : Container(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
