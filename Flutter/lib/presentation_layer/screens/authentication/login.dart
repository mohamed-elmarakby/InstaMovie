import 'package:insta_movie_app/business_logic_layer/cubit/home/cubit/home_cubit.dart';
import 'package:insta_movie_app/data_layer/models/route_model.dart';
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

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future putInMemory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('in', 1);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
          appBar: appBarWidget(
            backAllowed: false,
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
                        AppStrings.welcomeBack,
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
                    InstaButton(
                        loading: false,
                        title: AppStrings.login,
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            Routes.homePageRoute,
                          );
                        }),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.only(top: AppSize.s12),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, Routes.registerRoute);
                        },
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: AppStrings.dontHaveAnAccount,
                                style: getMediumStyle(
                                  color: ColorManager.grey,
                                  fontSize: 14,
                                ),
                              ),
                              TextSpan(
                                text: AppStrings.registerNow,
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
