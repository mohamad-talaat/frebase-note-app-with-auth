import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttercourse/firestore/subCollection_Firestore/homeNote.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../../view/widget/widgets screen (all widgets).dart';

class AddNotesPage extends StatefulWidget {
  AddNotesPage({Key? key, required this.categoryId}) : super(key: key);

  final String categoryId;

  @override
  _AddState createState() => _AddState();
}

String? url;

class _AddState extends State<AddNotesPage> {
  TextEditingController notename = TextEditingController();
  File? file;

  addNoteMethod() async {
    try {
      isloading = true;
      CollectionReference notesCollection = FirebaseFirestore.instance
          .collection('category')
          .doc(widget.categoryId)
          .collection("note");

      await notesCollection.add({
        'note': notename.text,
        "id": FirebaseAuth.instance.currentUser!.uid,
        "url": url ?? "none",
      });

      print("Notes Added");
//      notename.clear();
      setState(() {}); // Clear the text field after adding user
      //  Get.off(homeNote(categoryId: widget.docNoteId));
      //Navigator.of(context).pushNamedAndRemoveUntil("newRouteName", (route) => false);
    } catch (error) {
      print("Failed to add user: $error");
    }
  }

  getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photoCamera =
        await picker.pickImage(source: ImageSource.camera);
    file = File(photoCamera!.path);

    var dynamicName = basename(photoCamera.path);
    final storageRef =
        FirebaseStorage.instance.ref("images").child(dynamicName);

    // تحميل الصورة إلى Firebase Storage
    await storageRef.putFile(file!);

    // الحصول على عنوان URL
    String downloadURL = await storageRef.getDownloadURL();
    setState(() {
      url = downloadURL;
    });
  }

  bool isloading = false;

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   nameController.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: TextFormFieldScreen(
                    controller: notename,
                    keyboardType: TextInputType.emailAddress,
                    label: "Name Note ",
                    prefix: Icons.edit,
                    validator: (value) {
                      return ValidatorScreen(value!, 5, 500, "nameController");
                    },
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        MaterialButton(
                          onPressed: () async {
                            await getImage();
                          },
                          child: Text("Upload Image"),
                        ),
                        // if (url != null)
                        //   Image.network(
                        //     url!,
                        //     width: 100,
                        //     height: 100,
                        //   ),
                      ],
                    )),
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                    onPressed: () {
                      addNoteMethod();
                      Get.off(
                          homeNote(categoryId: widget.categoryId.toString()));
                    },
                    child: Text("Add Notes"))
              ],
            ),
    );
  }
}
