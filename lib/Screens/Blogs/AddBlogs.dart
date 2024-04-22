// ignore_for_file: use_build_context_synchronously, file_names

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:Pathogen/FirebaseServices/FireStore.dart';
import 'package:Pathogen/commonUtils/Constancts.dart';
import 'package:Pathogen/commonUtils/InputField.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:image_picker/image_picker.dart';
import "package:Pathogen/commonUtils/SnakBar.dart";
import "package:Pathogen/Extensions/Extension.dart";

class AddBlogs extends StatefulWidget {
  const AddBlogs({super.key});

  @override
  State<AddBlogs> createState() => _BlogsState();
}

class _BlogsState extends State<AddBlogs> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirestoreMethods _firestore = FirestoreMethods();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  File? selectedImage;
  Uint8List? image;
  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  uploadBlogData() async {
    try {
      setState(() {
        _isLoading = true;
      });
      if (image != null) {
        String res = await _firestore.uploadBlogs(
          _descriptionController.text.capitalize(),
          image!,
          _titleController.text.capitalize(),
        );
        ShowSnackBar(res, context);
        Navigator.pop(context);
      } else {
        setState(() {
          _isLoading = false;
        });
        ShowSnackBar("Please Select Image", context);
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ShowSnackBar(e.toString(), context);
    }
  }

  // ignore: non_constant_identifier_names
  SelectImage() async {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text("Create a Blog"),
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Choose from gallery"),
              onPressed: () async {
                Navigator.of(context).pop();
                final returnImage =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (returnImage != null) {
                  setState(() {
                    selectedImage = File(returnImage.path);
                    image = selectedImage!.readAsBytesSync();
                  });
                }
              },
            ),
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Take a photo"),
                onPressed: () async {
                  Navigator.of(context).pop();

                  final returnImage =
                      await ImagePicker().pickImage(source: ImageSource.camera);
                  if (returnImage != null) {
                    setState(() {
                      selectedImage = File(returnImage.path);
                      image = selectedImage!.readAsBytesSync();
                    });
                  }
                }),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                FontAwesomeIcons.arrowLeft,
                size: 24,
                color: primaryColor,
              )),
          title: const Text(
            "Blogs",
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: primaryColor),
          ),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(12),
                child: Form(
                    key: _formKey,
                    child: Column(children: [
                      image != null
                          ? Container(
                              width: MediaQuery.sizeOf(context).width,
                              height: 300,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: MemoryImage(image!),
                                      fit: BoxFit.fitWidth),
                                  border: Border.all(),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                            )
                          : Container(
                              width: MediaQuery.sizeOf(context).width,
                              height: 300,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  border: Border.all(),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              child: Center(
                                  child: ShaderMask(
                                      blendMode: BlendMode.srcIn,
                                      shaderCallback: (Rect bounds) {
                                        return const LinearGradient(
                                          colors: <Color>[
                                            primaryColor,
                                            secondaryColor
                                          ],
                                        ).createShader(bounds);
                                      },
                                      child: IconButton(
                                          onPressed: () => {
                                                SelectImage(),
                                              },
                                          icon: const Icon(
                                            Icons.upload,
                                            size: 40,
                                          ))))),
                      const SizedBox(height: 40),
                      InputField(
                        controller: _titleController,
                        lbltxt: 'Title',
                        hnttxt: 'Enter Title ',
                        kybrdtype: TextInputType.text,
                        isBlogsTextField: true,
                      ),
                      const SizedBox(height: 20),
                      InputField(
                        controller: _descriptionController,
                        lbltxt: 'Description',
                        hnttxt: 'Enter Description ',
                        kybrdtype: TextInputType.multiline,
                        isBlogsTextField: true,
                      ),
                      const SizedBox(height: 40),
                      InkWell(
                        onTap: () => {uploadBlogData()},
                        child: Container(
                          height: 55,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: const LinearGradient(colors: [
                              primaryColor,
                              secondaryColor,
                            ]),
                          ),
                          child: Center(
                              child: _isLoading
                                  ? LoadingAnimationWidget.staggeredDotsWave(
                                      color: Colors.white,
                                      size: 20,
                                    )
                                  : const Text(
                                      'Upload',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.white),
                                    )),
                        ),
                      ),
                    ])))));
  }
}
