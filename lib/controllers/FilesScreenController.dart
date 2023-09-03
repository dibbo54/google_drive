import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:googledrive/model/fileModel.dart';
import 'package:googledrive/model/folderModel.dart';
import 'package:googledrive/utils.dart';

class FilesScreenController extends GetxController {
  String uid = FirebaseAuth.instance.currentUser!.uid;

  RxList<FolderModel> folderList = <FolderModel>[].obs;
  RxList<FileModel> recentfilesList = <FileModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    recentfilesList.bindStream(
      userCollection
          .doc(uid)
          .collection('files')
          .orderBy('dateUploaded', descending: true)
          .snapshots()
          .map(
        (QuerySnapshot query) {
          List<FileModel> files = [];
          query.docs.forEach(
            (element) {
              // FileModel file = FileModel.fromSnapshot(element);
              // recentfilesList.add(file);Fil
              files.add(FileModel.fromSnapshot(element));
            },
          );
          return files;
        },
      ),
    );
    folderList.bindStream(
      userCollection
          .doc(uid)
          .collection('folders')
          .orderBy('time', descending: true)
          .snapshots()
          .map(
        (QuerySnapshot query) {
          List<FolderModel> folders = [];
          query.docs.forEach(
            (element) {
              FolderModel folder = FolderModel.fromSnapshot(element);
              folders.add(folder);
            },
          );
          return folders;
        },
      ),
    );
  }
}
