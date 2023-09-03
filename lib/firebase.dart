import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:googledrive/model/fileModel.dart';
import 'package:googledrive/utils.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';
import 'package:video_compress/video_compress.dart';

class FirebaseService {
  Future<File> compressFile(File file, String fileType) async {
    Uuid uuid = Uuid();

    if (fileType == "image") {
      Directory directory = await getTemporaryDirectory();
      String targetpath = directory.path + "/${uuid.v4().substring(0, 8)}.jpg";
      File? result = await FlutterImageCompress.compressAndGetFile(
          file.path, targetpath,
          quality: 75);
      return result!;
    } else if (fileType == "video") {
      MediaInfo? info = await VideoCompress.compressVideo(file.path,
          quality: VideoQuality.MediumQuality,
          deleteOrigin: false,
          includeAudio: true);
      print(info!.file);
      return File(info.path!);
    } else {
      return file;
    }
  }

  uploadFile(String foldername) async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();

      for (File file in files) {
        String? filetype = lookupMimeType(file.path);
        String end = '/';
        int startIndex = 0;
        int endIndex = filetype!.indexOf(end);
        String filteredFiletype = filetype.substring(startIndex, endIndex);
        //print(filteredFiletype);
        String fileName = file.path.split('/').last;
        String fileExtension = fileName.substring(fileName.indexOf('.') + 1);
        print(fileExtension);

        File? compressedfile = await compressFile(file, filteredFiletype);

        int length = await userCollection
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('files')
            .get()
            .then((value) => value.docs.length);
        UploadTask uploadTask = FirebaseStorage.instance
            .ref()
            .child('files')
            .child('File ${length}')
            .putFile(compressedfile);
        TaskSnapshot snapshot = await uploadTask.whenComplete(() => {});

        String fileUrl = await snapshot.ref.getDownloadURL();
        //TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
        //String fileUrl = await snapshot.ref.getDownloadURL();

        userCollection
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('files')
            .add(
          {
            "fileName": fileName,
            "fileUrl": fileUrl,
            "fileType": filteredFiletype,
            "fileExtension": fileExtension,
            "folder": foldername,
            "size":
                (compressedfile.readAsBytesSync().lengthInBytes / 1024).round(),
            "dateUploaded": DateTime.now()
          },
        );
      }

      if (foldername == '') {
        Get.back();
      }
    } else {
      print("cancaled");
    }
  }

  deleteFile(FileModel file) async {
    await userCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('files')
        .doc(file.id)
        .delete();
  }

  downloadFile(FileModel file) async {
    try {
      final downloadpath = await getdownloadpath();
      final path = "$downloadpath/${file.name.replaceAll(" ", "")}";
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      await Dio().download(file.url, path);
      print("success");
    } catch (e) {
      print("error");
    }
  }

  Future<String?> getdownloadpath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      }
    } catch (err, stack) {
      print('Cannot get download path');
    }

    print(directory?.path);
    return directory?.path;
  }
}
