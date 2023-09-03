import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googledrive/controllers/FilesScreenController.dart';
import 'package:googledrive/utils.dart';

import '../firebase.dart';
import 'FoldersSection.dart';
import 'RecentFiles.dart';
import 'nav_screen.dart';

class FilesScreen extends StatelessWidget {
  TextEditingController folderController = TextEditingController();
  FilesScreenController filesScreenController =
      Get.put(FilesScreenController());
  openFolDia(context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actionsPadding: EdgeInsets.only(right: 10, bottom: 10),
          title: Text(
            "New folder",
            style: textStyle(17, Colors.black, FontWeight.w600),
          ),
          content: TextFormField(
            controller: folderController,
            autofocus: true,
            style: textStyle(17, Colors.black, FontWeight.w600),
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[250],
                hintText: "Untitled Folder",
                hintStyle: textStyle(16, Colors.grey, FontWeight.w500)),
          ),
          actions: [
            InkWell(
              onTap: () => Get.back(),
              child: Text(
                "Cancel",
                style: textStyle(16, textColor, FontWeight.bold),
              ),
            ),
            InkWell(
              onTap: () {
                userCollection
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('folders')
                    .add({
                  "name": folderController.text,
                  "time": DateTime.now()
                });
                Get.offAll(NavScreen());
              },
              child: Text(
                "Create",
                style: textStyle(16, textColor, FontWeight.bold),
              ),
            )
          ],
        );
      },
    );
  }

  //const FilesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RecentFiles(),
                  FoldersSection(),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(10))),
                      builder: (context) {
                        return Container(
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    openFolDia(context);
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        EvaIcons.folderAdd,
                                        color: Colors.grey,
                                        size: 32,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Folder",
                                        style: textStyle(
                                            20, Colors.black, FontWeight.w600),
                                      )
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: (){
                                    FirebaseService().uploadFile('');
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        "Upload",
                                        style: textStyle(
                                            20, Colors.black, FontWeight.w600),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        EvaIcons.upload,
                                        color: Colors.grey,
                                        size: 32,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
