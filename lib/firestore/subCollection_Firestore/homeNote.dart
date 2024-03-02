import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttercourse/firestore/cardNotes.dart';
import 'package:fluttercourse/firestore/subCollection_Firestore/addNote.dart';
import 'package:fluttercourse/firestore/subCollection_Firestore/updatNote.dart';
import 'package:fluttercourse/view/screen/reg&login_Screen%20(auth)/login.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class homeNote extends StatefulWidget {
  final String categoryId;
  const homeNote({
    super.key,
    required this.categoryId,
  });

  @override
  State<homeNote> createState() => _HomepageState();
}

class _HomepageState extends State<homeNote> {
  List<QueryDocumentSnapshot> data = [];
  CollectionReference category =
      FirebaseFirestore.instance.collection('category');

  //late final  String documentId;

  getNotesData() async {
    CollectionReference notesCollection = FirebaseFirestore.instance
        .collection('category')
        .doc(widget.categoryId)
        .collection("note");

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('category')
        .doc(widget.categoryId)
        .collection("note")
        // .orderBy("id", descending: false)
        // .where("note" , )
        // .where("note", isEqualTo: "hamo")
        .get();
    //.where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
    data.addAll(querySnapshot
        .docs); //querySnapshot.docs روحت عملت ليست وقولت ضيف فيها الداتا اللي جايه من ال
    setState(() {}); // عشان لما اعمل ريفرش الداتا تتنشط معاك
  }

  @override
  void initState() {
    // TODO: implement initState
    getNotesData();
    super.initState();
  }

  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Center(child: Text('View Notes')),
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
                        btnOkText: "Delete",
                        btnOkColor: Colors.red,
                        btnCancelOnPress: () {
                          // print("${widget.categoryId}");
                          // print("${data[index].id}");
                          Get.off(UpdateNotesPage(
                            oldnameNote: data[index]["note"],
                            categoryId: widget.categoryId,
                            docNotesId: data[index].id,
                          ));
                        },
                        btnCancelColor: Colors.green,
                        btnOkOnPress: () {
                          print("Delete");
                          category
                              .doc(widget.categoryId)
                              .collection("note")
                              .doc(data[index].id)
                              .delete();
                          if (data[index]["url"] != null &&
                              data[index]["url"] != "none") {
                            FirebaseStorage.instance
                                .refFromURL(data[index]["url"])
                                .delete();
                          }

                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return homeNote(categoryId: widget.categoryId);
                            },
                          ));
                        },
                      )..show();
                    },
                    child: Column(
                      children: [
                        //  var variableName=  if (data[index]["url"]!="none")Image.network(data[index]["url"],height: 80),
                        cardSmallNotes(
                          onDismiss: () async {
                            await category
                                .doc(widget.categoryId)
                                .collection("note")
                                .doc(data[index].id)
                                .delete();
                            setState(() {});
                          },
                          name: "${data[index]["note"]}",
                          imageUrl: "${data[index]["url"]}",
                          // url: data[index]["url"],
                          // onTap: () {
                          //   print(
                          //     data[index]['name'],
                          //   );
                          //   print(data[index].id);
                          // },
                        ),
                      ],
                    ));
              },
            ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(AddNotesPage(
              categoryId: widget.categoryId,
            ));
          },
          child: Icon(Icons.add)),
    );
  }
}
