import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:insta_movie_app/business_logic_layer/cubit/home/cubit/home_cubit.dart';
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

class NewMovieScreen extends StatefulWidget {
  HomeCubit? cubit;
  NewMovieScreen({Key? key, this.cubit}) : super(key: key);

  @override
  _NewMovieScreenState createState() => _NewMovieScreenState();
}

class _NewMovieScreenState extends State<NewMovieScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController overViewController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  PickedFile? imageFile = null;
  void _openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      imageFile = pickedFile!;
    });

    Navigator.pop(context);
  }

  void _openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    setState(() {
      imageFile = pickedFile!;
    });
    Navigator.pop(context);
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: ColorManager.black,
            title: Text(
              "Choose option",
              style: TextStyle(color: Colors.blue),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _openGallery(context);
                    },
                    title: Text("Gallery"),
                    leading: Icon(
                      Icons.account_box,
                      color: Colors.blue,
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _openCamera(context);
                    },
                    title: Text("Camera"),
                    leading: Icon(
                      Icons.camera,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacementNamed(
            context,
            Routes.myMovies,
            arguments: widget.cubit,
          );
          return true;
        },
        child: Scaffold(
          appBar: appBarWidget(
            backAllowed: true,
            context: context,
            routeName: Routes.myMovies,
            args: widget.cubit,
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
                        AppStrings.addMovie,
                        style: getBoldStyle(
                          color: ColorManager.primary,
                          fontSize: AppSize.s34,
                        ),
                      ),
                    ),
                    InstaFormField(
                      label: AppStrings.title,
                      controller: titleController,
                      hint: AppStrings.titleExample,
                    ),
                    InstaFormField(
                      label: AppStrings.overview,
                      controller: overViewController,
                      hint: AppStrings.overviewExample,
                      isLong: true,
                    ),
                    InstaFormField(
                      label: AppStrings.date,
                      controller: dateController,
                      hint: AppStrings.dateExample,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: InstaFormField(
                            label: AppStrings.poster,
                            controller: TextEditingController(
                              text: imageFile?.path ?? AppStrings.posterExample,
                            ),
                            readOnly: true,
                            hint: AppStrings.posterExample,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: InstaButton(
                              title: AppStrings.choosePoster,
                              onPressed: () async {
                                _showChoiceDialog(context);
                              }),
                        )
                      ],
                    ),
                    Card(
                      child: (imageFile == null)
                          ? Container()
                          : Image.file(File(imageFile!.path)),
                    ),
                    InstaButton(
                        loading: false,
                        title: AppStrings.save,
                        onPressed: () async {
                          if (titleController.text.isNotEmpty &&
                              overViewController.text.isNotEmpty &&
                              dateController.text.isNotEmpty &&
                              (imageFile != null ||
                                  imageFile!.path.isNotEmpty)) {
                            await widget.cubit!
                                .createMovie(
                              date: dateController.text.trim(),
                              overview: overViewController.text.trim(),
                              title: titleController.text.trim(),
                              poster: imageFile!,
                            )
                                .then((value) {
                              Navigator.pushReplacementNamed(
                                context,
                                Routes.myMovies,
                                arguments: widget.cubit,
                              );
                            });
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(AppStrings.dontLeaveEmpty),
                            ));
                          }
                        }),
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
