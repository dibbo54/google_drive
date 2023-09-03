import 'package:cloud_firestore/cloud_firestore.dart';

class FileModel {
  late String id;
  late String url;
  late String name;
  late Timestamp dateUploaded;
  late String fileType;
  late String fileExtension;
  late String foldername;
  late int size;

  FileModel(this.id, this.url, this.name, this.dateUploaded, this.fileType,
      this.fileExtension, this.foldername, this.size);

  FileModel.fromSnapshot(QueryDocumentSnapshot<Object?> doc) {
    //var snapshot = doc.data() as Map<String, dynamic>;

    id = doc.id;
    url = doc['fileUrl'];
    name = doc['fileName'];
    dateUploaded = doc['dateUploaded'];
    fileType = doc['fileType'];
    fileExtension = doc['fileExtension'];
    foldername = doc['folder'];
    size = doc['size'];

    //
    // "fileName": fileName,
    // "fileUrl": fileUrl,
    // "fileType": filteredFiletype,
    // "fileExtension": fileExtension,
    // "folder": foldername,
    // "size":
    // (compressedfile.readAsBytesSync().lengthInBytes / 1024).round(),
    // "dateUploaded": DateTime.now()
    // //name=doc['name'];
  }

// Map<String, dynamic> toJson() => {
//       "description": description,
//       "uid": uid,
//       "likes": likes,
//       "username": username,
//       "postId": postId,
//       "datePublished": datePublished,
//       'postUrl': postUrl,
//       'profImage': profImage
//     };
}
