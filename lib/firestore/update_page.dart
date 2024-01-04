import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttercourse/homepage.dart';
import 'package:get/get.dart';

import '../view/widget/widgets screen (all widgets).dart';

class UpdatePage extends StatefulWidget {
  final oldname;
  final docId;
  const UpdatePage({Key? key, this.oldname, this.docId}) : super(key: key);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

TextEditingController nameCont = TextEditingController();
CollectionReference category =
    FirebaseFirestore.instance.collection('category');

bool isloading = false;

class _UpdatePageState extends State<UpdatePage> {
  updateCategory() async {
    await category
        .doc(widget.docId)
        .update({"name": nameCont.text}).then((value) {
      print("Success");
      Get.off(Homepage());
    }).catchError((e) {
      print("Error is ======== $e");
    });
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    nameCont.text = widget.oldname;
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
                  controller: nameCont,
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
                      updateCategory();
                      //   Get.off(Homepage());
                    },
                    child: Text("EDIT"))
              ],
            ),
    );
  }
}
