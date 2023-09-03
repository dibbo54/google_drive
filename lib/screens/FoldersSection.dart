import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:googledrive/controllers/filesController.dart';
import 'package:googledrive/utils.dart';

import '../controllers/FilesScreenController.dart';
import 'display_files_screen.dart';

class FoldersSection extends StatelessWidget {
  const FoldersSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<FilesScreenController>(
        //stream: null,
        builder: (FilesScreenController foldersController) {
      if (foldersController != null && foldersController.folderList != null) {
        return GridView.builder(
          //gridDelegate: gridDelegate, itemBuilder: itemBuilder
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: foldersController.folderList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 20),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Get.to(
                  () => DisplayFilesScreen(
                    foldersController.folderList[index].name,
                    "folder",
                  ),
                  binding: FilesBinding(
                      "Folders",
                      foldersController.folderList[index].name,
                       foldersController.folderList[index].name),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade100,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(.00001),
                          offset: const Offset(10, 10),
                          blurRadius: 5)
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/folder.png',
                      width: 82,
                      height: 82,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      //"Photos",
                      foldersController.folderList[index].name,
                      style: textStyle(18, textColor, FontWeight.bold),
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: userCollection
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection('files')
                          .where('folder',
                              isEqualTo:
                                  foldersController.folderList[index].name)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        }
                        return Text(
                          "${snapshot.data!.docs.length} items",
                          style:
                              textStyle(14, Colors.grey[400]!, FontWeight.bold),
                        );
                      },
                    )
                  ],
                ),
              ),
            );
          },
        );
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }
}
