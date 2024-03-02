// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttercourse/firestore/addPage.dart';
import 'package:fluttercourse/firestore/cardNotes.dart';
import 'package:fluttercourse/view/screen/reg&login_Screen%20(auth)/login.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'firestore/subCollection_Firestore/homeNote.dart';
import 'firestore/update_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<QueryDocumentSnapshot> data = [];
  CollectionReference category =
      FirebaseFirestore.instance.collection('category');

  //late final  String documentId;

  getData() async {
    QuerySnapshot getdata = await category
        .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get(); // انا كدا جبت الداتا
    data.addAll(getdata
        .docs); //querySnapshot.docs روحت عملت ليست وقولت ضيف فيها الداتا اللي جايه من ال
    setState(() {}); // عشان لما اعمل ريفرش الداتا تتنشط معاك
  }
  // getData() async {
  //   // جلب البيانات من Firestore
  //   QuerySnapshot querySnapshot =
  //       await FirebaseFirestore.instance.collection('category').get();
  //   // عرض البيانات في قائمة
  //   querySnapshot.docs.forEach((doc) {
  //     print('Document ID: ${doc.id}');
  //     data = querySnapshot.docs;
  //   });
  //   setState(() {});
  // }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Center(child: Text('View Page')),
        actions: [
          IconButton(
              onPressed: () async {
                GoogleSignIn google = GoogleSignIn();
                google.disconnect();
                // FacebookAuth.instance.logOut();
                await FirebaseAuth.instance.signOut();
                Get.to(Login());
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              itemCount: data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 0.0,
                mainAxisSpacing: 0.0,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                    onLongPress: () {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.warning,
                        animType: AnimType.rightSlide,
                        title: 'Error',
                        desc: 'Are you sure to delete',
                        btnCancelText: "Update",
                        btnCancelColor: Colors.green,
                        btnOkColor: Colors.red,
                        btnOkText: "Delete",
                        btnCancelOnPress: () {
                          Get.off(UpdatePage(
                            oldname: data[index]["name"],
                            docId: data[index].id,
                          ));
                        },
                        btnOkOnPress: () {
                          print("Delete");
                          category.doc(data[index].id).delete();
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return Homepage();
                            },
                          ));
                        },
                      )..show();
                    },
                    child: cardNotes(
                      onDismiss: () async {
                        await category.doc(data[index].id).delete();
                        setState(() {});
                      },
                      name: "${data[index]["name"]}",
                      onTap: () {
                        print(data[index].id);
                        //
                        Get.to(homeNote(
                          categoryId: data[index].id,
                        ));
                      },
                    ));
              },
            )

      // FutureBuilder(
      //   future: getData(),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasError) {
      //       return Center(child: Text("No data available"));
      //     }
      //     // else if (snapshot.connectionState == ConnectionState.waiting) {
      //     //   return Center(child: CircularProgressIndicator());}
      //
      //     else {
      //     GridView.builder(
      //     itemCount: data.length,
      //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //     crossAxisCount: 2,
      //     crossAxisSpacing: 0.0,
      //     mainAxisSpacing: 0.0,
      //     ),
      //     itemBuilder: (context, index) {
      //     return InkWell(
      //     onLongPress: () {
      //     AwesomeDialog(
      //     context: context,
      //     dialogType: DialogType.warning,
      //     animType: AnimType.rightSlide,
      //     title: 'Error',
      //     desc: 'Are you sure to delete',
      //     btnCancelOnPress: () {
      //     print("cancel");
      //     },
      //     btnOkOnPress: () {
      //     print("ok");
      //     category.doc(data[index].id).delete();
      //     Navigator.pushReplacement(context, MaterialPageRoute(
      //     builder: (context) {
      //     return Homepage();
      //     },
      //     ));
      //     },
      //     )..show ();
      //     },
      //     child: cardNotes(
      //     name: "${data[index]["name"]}",
      //
      //     // onTap: () {
      //     //   print(
      //     //     data[index],
      //     //   );
      //     //   Get.to(Updatepage(
      //     //     name: category
      //     //         .doc(data[index].id)
      //     //         .update({"name": "${nameController}"}),
      //     //   ));
      //     // },
      //     ));
      //     },
      //     );
      //   }
      //   },
      // ),
      ,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(AddCategory());
          },
          child: Icon(Icons.add)),
    );
  }
}
