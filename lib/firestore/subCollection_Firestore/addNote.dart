import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttercourse/firestore/subCollection_Firestore/homeNote.dart';
import 'package:get/get.dart';

import '../../view/widget/widgets screen (all widgets).dart';

class AddNotesPage extends StatefulWidget {
  const AddNotesPage({Key? key, required this.categoryId}) : super(key: key);

  final String categoryId;
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<AddNotesPage> {
  TextEditingController notename = TextEditingController();

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
      });

      print("Notes Added");
      notename.clear(); // Clear the text field after adding user
      //  Get.off(homeNote(categoryId: widget.docNoteId));
      //Navigator.of(context).pushNamedAndRemoveUntil("newRouteName", (route) => false);
    } catch (error) {
      print("Failed to add user: $error");
    }
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
