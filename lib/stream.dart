import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class Stream extends StatefulWidget {
  @override
  State<Stream> createState() => _StreamState();
}

class _StreamState extends State<Stream> {
  final _usersStream =
      FirebaseFirestore.instance.collection('stream').snapshots();

  File? file;
  String? url;
  Future _getImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
// Pick an image.
    final XFile? photoCamera =
        await picker.pickImage(source: ImageSource.camera);
    file = File(photoCamera!.path);

    var dynamicName = basename(photoCamera!.path);

    final storageRef =
        FirebaseStorage.instance.ref("images").child(dynamicName);

    await storageRef.putFile(file!);
    var url = storageRef.getDownloadURL();
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Text("stream"),
        ),
        body: Column(
          children: [
            // Container(
            //   child: StreamBuilder(
            //     stream: _usersStream,
            //     builder: (BuildContext context, snapshot) {
            //       if (snapshot.hasError) {
            //         return Text('Something went wrong');
            //       }
            //
            //       if (snapshot.connectionState == ConnectionState.waiting) {
            //         return Text("Loading");
            //       }
            //
            //       return ListView.builder(
            //           itemCount: snapshot.data!.docs.length,
            //           itemBuilder: (context, index) {
            //             return Column(
            //               children: [
            //                 Text("${snapshot.data!.docs[index]['name']}"),
            //                 Text("${snapshot.data!.docs[index]['age']}"),
            //               ],
            //             );
            //
            //             //   ListTile(
            //             //   title: Text("${snapshot.data!.docs[index]['name']}"),
            //             //   subtitle: Text("${snapshot.data!.docs[index]['age']}"),
            //             // );
            //           });
            //     },
            //   ),
            // ),
            MaterialButton(
              onPressed: () async {
                await _getImageFromCamera();
              },
              child: Text("Choose Image"),
            ),
            if (url != null)
              Image.network(
                url!,
                width: 200,
                height: 200,
              )
          ],
        ));
  }
}
