import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:googledrive/utils.dart';

import '../model/fileModel.dart';

class FilesController extends GetxController {
  final String type;
  final String foldername;
  final String fileType;

  FilesController(this.type, this.foldername, this.fileType);

  String uid = FirebaseAuth.instance.currentUser!.uid;
  RxList<FileModel> files = <FileModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (type == "files") {
      files.bindStream(
        userCollection
            .doc(uid)
            .collection('files')
            .where('fileType', isEqualTo: fileType)
            .snapshots()
            .map(
          (QuerySnapshot query) {
            List<FileModel> tempFiles = [];
            List<QueryDocumentSnapshot<Object?>> docslist = query.docs;
            docslist.forEach(
              (doc) {
                tempFiles.add(FileModel.fromSnapshot(doc));
              },
            );
            return tempFiles;
          },
        ),
      );
    } else {
      files.bindStream(
        userCollection
            .doc(uid)
            .collection('files')
            .where('folder', isEqualTo: foldername)
            .snapshots()
            .map(
          (QuerySnapshot query) {
            List<FileModel> tempFiles = [];
            query.docs.forEach(
              (element) {
                tempFiles.add(FileModel.fromSnapshot(element));
              },
            );
            return tempFiles;
          },
        ),
      );
    }
  }
}

class FilesBinding implements Bindings {
  final String type;
  final String foldername;
  final String fileType;

  FilesBinding(this.type, this.foldername, this.fileType);
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<FilesController>(
      () => FilesController(type, foldername, fileType),
    );
  }
}
