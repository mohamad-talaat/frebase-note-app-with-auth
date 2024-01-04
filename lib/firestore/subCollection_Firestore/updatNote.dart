import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttercourse/firestore/subCollection_Firestore/homeNote.dart';
import 'package:get/get.dart';

import '../../view/widget/widgets screen (all widgets).dart';

class UpdateNotesPage extends StatefulWidget {
  final oldnameNote;
  final String docNotesId;
  final String categoryId;
  const UpdateNotesPage(
      {Key? key,
      this.oldnameNote,
      required this.docNotesId,
      required this.categoryId})
      : super(key: key);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

TextEditingController nameNotesUpdate = TextEditingController();

bool isloading = false;

class _UpdatePageState extends State<UpdateNotesPage> {
  UpdateNotesMethod() async {
    CollectionReference notesCollection = FirebaseFirestore.instance
        .collection('category')
        .doc(widget.categoryId)
        .collection("note");

    await FirebaseFirestore.instance
        .collection('category')
        .doc(widget.categoryId)
        .collection("note")
        .doc(widget.docNotesId)
        .update({'note': nameNotesUpdate.text}).then((value) {
      print("Success");

      Get.off(homeNote(categoryId: widget.categoryId));
    }).catchError((e) {
      print("Error is ======== $e");
    });
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    nameNotesUpdate.text = widget.oldnameNote;
  }

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
                TextFormFieldScreen(
                  controller: nameNotesUpdate,
                  keyboardType: TextInputType.emailAddress,
                  label: "Name Category ",
                  prefix: Icons.edit,
                  validator: (value) {
                    return ValidatorScreen(value!, 5, 500, "nameController");
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    onPressed: () {
                      UpdateNotesMethod();
                      //   Get.off(Homepage());
                    },
                    child: Text("EDIT"))
              ],
            ),
    );
  }
}
