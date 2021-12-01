import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:readingbook/constants/colors.dart';
import 'package:readingbook/constants/loading.popup.dart';
import 'package:readingbook/constants/string.dart';
import 'package:readingbook/constants/toast.dart';
import 'package:readingbook/models/book.model.dart';
import 'package:readingbook/models/user.model.dart';
import 'package:readingbook/pages/auth/auth.repo.dart';
import 'photo.zoom.dart';

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  String title;
  String publication;
  String author;
  UserModel userModel;
  List<String> presetCategories = ['Engg', 'Medical', 'BCA', 'BCom', 'GK', 'Fiction', 'Others'];
  List<int> selectedCategoriesIndex = [];
  List<String> photoUrl = [];
  final TextStyle titleStyle = TextStyle(fontSize: 12);
  final TextStyle inputStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();
    getUser();
  }

  getUser() async {
    userModel = await AuthRepo.getUser();
    if (userModel == null) {
      ToastPreset.err(str: 'some error while getting user', context: context);
    }
  }

  showError(str) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(str),
        duration: new Duration(milliseconds: 400),
      ),
    );
  }

  Widget saveButton() {
    return GestureDetector(
      onTap: () async {
        FocusScope.of(context).unfocus();
        if (title == null || title.isEmpty) {
          showError('Enter Valid Title');
          return;
        }
        if (publication == null || publication.isEmpty) {
          showError('Enter Publication');
          return;
        }
        List<String> selectedCategories = [];
        if (selectedCategoriesIndex.isEmpty) {
          showError('Select atleast one category');
          return;
        } else {
          for (int i = 0; i < presetCategories.length; i++) {
            if (selectedCategoriesIndex.contains(i)) {
              selectedCategories.add(presetCategories[i]);
            }
          }
        }
        if (photoUrl.isEmpty) {
          showError('Select atleast one photo');
          return;
        }
        BookModel model = BookModel(
          author: author ?? "",
          categories: selectedCategories,
          createdAt: DateTime.now(),
          ownerId: userModel.id,
          ownerName: userModel.name,
          ownerPhone: userModel.phone,
          photoUrl: photoUrl,
          publication: publication,
          sold: false,
          title: title,
          views: 0,
        );
        LoadingPopupGenerator.def(text: 'Saving Details', context: context);
        final CollectionReference dataCollection =
            FirebaseFirestore.instance.collection(StringConstants.bookCollection);
        DocumentReference bookRef = dataCollection.doc();
        await bookRef.set(model.toJson());
        List postsTemp = userModel.posts;
        postsTemp.add(bookRef.id);
        final CollectionReference userCollection =
            FirebaseFirestore.instance.collection(StringConstants.userCollection);
        await userCollection.doc(userModel.id).update({
          'posts': postsTemp.cast<String>(),
        });
        Navigator.pop(context);
        Navigator.pop(context);
        ToastPreset.successful(str: 'Added Successfully', context: context);
      },
      child: Container(
        alignment: Alignment.centerRight,
        child: Text(
          'Save',
          style: TextStyle(
            fontSize: 16,
            color: ColorConstant.purple,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget textInput({
    title,
    initialValue,
    Function change,
    hintText,
    IconData icon,
    bool noInput = false,
  }) {
    return Column(
      children: [
        SizedBox(height: 10),
        Row(
          children: [
            Icon(
              icon,
              color: Colors.grey,
              size: 23,
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      title,
                    ),
                  ),
                  SizedBox(height: 3),
                  textForm(initialValue, hintText, change),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 6),
        noInput
            ? SizedBox()
            : Divider(
                color: Colors.red.withOpacity(0.5),
              ),
      ],
    );
  }

  TextFormField textForm(initialValue, hintText, Function change) {
    return TextFormField(
      maxLength: 200,
      style: inputStyle,
      keyboardType: TextInputType.text,
      initialValue: initialValue,
      decoration: InputDecoration(
        hintStyle: inputStyle..copyWith(fontWeight: FontWeight.normal),
        isDense: true,
        border: InputBorder.none,
        contentPadding: EdgeInsets.only(bottom: 0),
        counterText: "",
        hintText: hintText,
      ),
      onChanged: change,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('Add Post'),
          backgroundColor: ColorConstant.purple,
        ),
        body: Container(
          constraints: BoxConstraints.expand(),
          padding: EdgeInsets.symmetric(horizontal: 13),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 20),
                textInput(
                  title: 'Title',
                  hintText: 'Enter the title',
                  change: (val) {
                    setState(() => title = val);
                  },
                  initialValue: null,
                  icon: Icons.phone,
                ),
                textInput(
                  title: 'Publication',
                  hintText: 'Enter publication name',
                  change: (val) {
                    setState(() => publication = val);
                  },
                  initialValue: null,
                  icon: Icons.location_city,
                ),
                textInput(
                  title: 'Author',
                  hintText: 'Enter author\'s name',
                  change: (val) {
                    setState(() => author = val);
                  },
                  initialValue: null,
                  icon: Icons.work,
                ),
                SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: <Widget>[
                    for (int i = 0; i < presetCategories.length; i++)
                      GestureDetector(
                        onTap: () {
                          if (!selectedCategoriesIndex.contains(i)) {
                            setState(() {
                              selectedCategoriesIndex.add(i);
                            });
                          } else {
                            setState(() {
                              selectedCategoriesIndex.remove(i);
                            });
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: selectedCategoriesIndex.contains(i) ? ColorConstant.purple : Colors.grey,
                          ),
                          child: Text(
                            presetCategories[i],
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 15),
                GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: List.generate(
                    photoUrl.length + 1,
                    (index) {
                      if (index == 0) {
                        return Padding(
                          padding: EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: () async {
                              FocusScope.of(context).unfocus();
                              XFile imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                              Uint8List data = await imageFile.readAsBytes();
                              setState(() {
                                if (photoUrl.isEmpty) {
                                  photoUrl.add(base64Encode(data));
                                } else {
                                  photoUrl[0] = base64Encode(data);
                                }
                              });
                              print(photoUrl);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.3),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Icon(Icons.add_a_photo_rounded, color: Colors.black),
                            ),
                          ),
                        );
                      }
                      return Padding(
                        padding: EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return PhotoZoomView(
                                    Image(
                                      image: MemoryImage(base64Decode(photoUrl[index - 1])),
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: MemoryImage(base64Decode(photoUrl[index - 1])),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 30),
                saveButton()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
