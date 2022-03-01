// 04_책린지상세_피드_글쓰기
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

import 'package:onlyone/Core/color_theme.dart';
import 'package:onlyone/Core/font_theme.dart';
import 'package:onlyone/Core/network_manager.dart';

import 'package:onlyone/models/feed_request.dart';

import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:onlyone/views/components/popup_view.dart';

class ChallengeFeedWriteView extends StatefulWidget {
  final int challengeId;

  const ChallengeFeedWriteView(this.challengeId);
  @override
  _ChallengeFeedWriteViewState createState() =>
      _ChallengeFeedWriteViewState(challengeId);
}

class _ChallengeFeedWriteViewState extends State<ChallengeFeedWriteView> {
  _ChallengeFeedWriteViewState(this.challengeId);
  final int challengeId;
  List<ImageUploadModel> images = <ImageUploadModel>[];
  File? _imageFile;
  bool isButtonDisabled = false;

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? _user;

  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  String subject = "";
  final contentController = TextEditingController();
  String comment = "";
  bool spoilerValue = false;

  @override
  void initState() {
    super.initState();
    isButtonDisabled = true;
    _user = _firebaseAuth.currentUser!;
    setState(() {
      images.add(ImageUploadModel());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: new GestureDetector(
        onTap: () {
          // keyboard hide
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: _buildContent(),
      ),
      bottomNavigationBar: _saveButton(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
        leading: IconButton(
            icon: Image.asset("images/ic_32_arrow_left.png", height: 32),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          "글쓰기",
          style: FontTheme.h4_with(ColorTheme.gray900),
        ),
        backgroundColor: Colors.white,
        elevation: 0, // 그림자
        centerTitle: true,
        actions: [
          IconButton(
              icon: Image.asset("images/ic_32_close.png", height: 32),
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              }),
          Padding(padding: EdgeInsets.only(right: 20)),
        ]);
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        //autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: <Widget>[
            Container(
              child: buildGridView(),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: "제목을 입력해주세요",
                  //enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),),
                ),
                validator: (value) =>
                    value!.trim().isEmpty ? "피드 제목을 입력하세요" : null,
                onChanged: (txt) => {
                  if (_formKey.currentState!.validate() && (images.length > 1))
                    {
                      setState(() {
                        isButtonDisabled = false;
                      })
                    }
                  else
                    {
                      setState(() {
                        isButtonDisabled = true;
                      })
                    }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextFormField(
                controller: contentController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: "내용을 입력해주세요.",
                  //enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),),
                ),
                validator: (value) =>
                    value!.trim().isEmpty ? "피드 내용을 입력하세요" : null,
                onChanged: (txt) => {
                  if (_formKey.currentState!.validate() && (images.length > 1))
                    {
                      setState(() {
                        isButtonDisabled = false;
                      })
                    }
                  else
                    {
                      setState(() {
                        isButtonDisabled = true;
                      })
                    }
                },
              ),
            ),
            Padding(
                padding: EdgeInsets.all(20.0),
                child: Row(children: [
                  SizedBox(
                    width: 10,
                    child: Checkbox(
                        value: spoilerValue,
                        activeColor: Colors.orange,
                        onChanged: (value) {
                          setState(() {
                            spoilerValue = value!;
                          });
                        }),
                  ),
                  SizedBox(width: 10.0),
                  Text('스포일러가 있어요.'),
                ])),
          ],
        ),
      ),
    );
  }

  Widget buildGridView() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      height: 64,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: images.length,
          itemBuilder: (context, index) {
            if (images[index].imageFile is File) {
              ImageUploadModel uploadModel = images[index];
              return Container(
                width: 64,
                height: 64,
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    children: <Widget>[
                      Image.file(
                        uploadModel.imageFile!,
                        width: 64,
                        height: 64,
                      ),
                      Positioned(
                        right: 5,
                        top: 5,
                        child: InkWell(
                          child: Icon(
                            Icons.remove_circle,
                            size: 20,
                            color: Colors.red,
                          ),
                          onTap: () {
                            setState(() {
                              images.removeAt(index);
                              if (images.length == 0) {
                                images.add(ImageUploadModel());
                              }
                              if (images.length == 1) {
                                isButtonDisabled = true;
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Container(
                width: 64,
                height: 64,
                child: Card(
                  color: Colors.grey,
                  child: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      _onAddImageClick(index);
                    },
                  ),
                ),
              );
            }
          }),
    );
  }

  Future _onAddImageClick(int index) async {
    final _picker = ImagePicker();

    try {
      var image = await _picker.getImage(source: ImageSource.camera);

      if (image == null) return null;

      File? cropped = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 100,
        maxWidth: 1024,
        maxHeight: 1024,
        compressFormat: ImageCompressFormat.jpg,
        androidUiSettings: AndroidUiSettings(
          toolbarColor: Colors.white,
          toolbarTitle: "Image Cropper",
          statusBarColor: Colors.grey,
          backgroundColor: Colors.white,
        ),
      );

      //PickedFile pickedFile = cropped as PickedFile;
      if (cropped == null) return null;
      setState(() {
        //_imageFile = File(pickedFile.path);
        _imageFile = cropped;
        getFileImage(index);

        if (_formKey.currentState!.validate() && (images.length > 1)) {
          isButtonDisabled = false;
        } else {
          isButtonDisabled = true;
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void getFileImage(int index) async {
    if (_imageFile != null) {
      setState(() {
        ImageUploadModel imageUpload = new ImageUploadModel();
        imageUpload.selected = false;
        imageUpload.imageFile = _imageFile;
        imageUpload.imageUrl = '';
        images.replaceRange(index, index + 1, [imageUpload]);
        images.add(ImageUploadModel());
      });
    }
  }

  Widget _saveButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      margin: EdgeInsets.only(bottom: 40, top: 5),
      height: 56,
      child: ElevatedButton(
        onPressed: () async {
          if (!isButtonDisabled) {
            _saveFeed();
          }
        },
        style: ButtonStyle(
          backgroundColor: isButtonDisabled
              ? MaterialStateProperty.all<Color>(ColorTheme.gray300)
              : MaterialStateProperty.all<Color>(ColorTheme.point400),
        ),
        child: Text(
          '올리기',
          style: FontTheme.h4_with(
              isButtonDisabled ? ColorTheme.gray600 : Colors.white),
        ),
      ),
    );
  }

  _saveFeed() async {
    var title = titleController.text;
    var content = contentController.text;
    List<String> imagePaths = [];
    var isSpoiler = spoilerValue;

    EasyLoading.show(maskType: EasyLoadingMaskType.black);

    await _saveImage();
    for (var image in images) {
      if (image.imageUrl == "") continue;
      if (image.imageUrl == null) continue;
      imagePaths.add(image.imageUrl!);
    }

    FeedRequest request = FeedRequest(
        challengeId: challengeId,
        title: title,
        content: content,
        imagePaths: imagePaths,
        isSpoiler: isSpoiler);

    print(request.toJson());

    final response = await NetworkManager().postFeed(request);
    EasyLoading.dismiss();

    if (response.didSucceed) {
      final feed = response.data;
      print("피드 생성 성공!");
      print(feed);
      Navigator.pop(context);
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return PopupView(
              title: response.error?.message,
              action: () {
                Navigator.pop(context);
              },
              actionText: "확인",
            );
          });
    }
  }

  _saveImage() async {
    if (_user == null) return;
    print(_user!.uid);

    for (var i = 0; i < images.length; i++) {
      if (images[i].imageFile == null) continue;
      print(images[i].imageFile.toString());
      images[i].imageUrl = await imageUpload(images[i]);

      print(images[i].imageUrl);
    }
  }

  Future<String?> imageUpload(ImageUploadModel image) async {
    String? downloadURL;
    var now = DateFormat("yyyyMMddHmS").format(DateTime.now());

    var ref = FirebaseStorage.instance
        .ref()
        .child("feed")
        .child(_user!.uid)
        .child(now);
    UploadTask task = ref.putFile(image.imageFile!);

    task.snapshotEvents.listen((TaskSnapshot snapshot) {
      //print('Task state: ${snapshot.state}');
      //print('Progress: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100} %');
    }, onError: (e) {
      print(task.snapshot);

      if (e.code == 'permission-denied') {
        print('User does not have permission to upload to this reference.');
      }
    });

    // We can still optionally use the Future alongside the stream.
    try {
      await task;
      downloadURL = await ref.getDownloadURL();
      print('Upload complete : ' + downloadURL);
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        print('User does not have permission to upload to this reference.');
      }
    }
    return downloadURL;
  }
}

class ImageUploadModel {
  bool selected;
  File? imageFile;
  String? imageUrl;

  ImageUploadModel({
    this.selected = false,
    this.imageFile,
    this.imageUrl,
  });
}
