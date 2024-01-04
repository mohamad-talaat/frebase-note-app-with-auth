import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/widget/widgets screen (all widgets).dart';

TextEditingController nameController = TextEditingController();
CollectionReference category =
    FirebaseFirestore.instance.collection('category');

bool isloading = false;
Future<void> addUser() async {
  try {
    isloading = true;
    await category.add({
      'name': nameController.text,
      "id": FirebaseAuth.instance.currentUser!.uid,
    });

    print("User Added");
    nameController.clear(); // Clear the text field after adding user
    Get.offAllNamed("HomePage");
    //Navigator.of(context).pushNamedAndRemoveUntil("newRouteName", (route) => false);
  } catch (error) {
    print("Failed to add user: $error");
  }
}

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<AddCategory> {
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
                TextFormFieldScreen(
                  controller: nameController,
                  keyboardType: TextInputType.emailAddress,
                  label: "Name Category ",
                  prefix: Icons.edit,
                  validator: (value) {
                    return ValidatorScreen(value!, 5, 500, "nameController");
                  },
                ),
                TextButton(
                    onPressed: () {
                      addUser();
                      //   Get.off(Homepage());
                    },
                    child: Text("Add"))
              ],
            ),
    );
  }
}
