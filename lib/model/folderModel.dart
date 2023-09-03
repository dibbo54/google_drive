import 'package:cloud_firestore/cloud_firestore.dart';

class FolderModel {
  late String id;
  late String name;
  late Timestamp dateCreated;
  late int items;

  FolderModel(this.id, this.name, this.dateCreated, this.items);

  FolderModel.fromSnapshot(QueryDocumentSnapshot<Object?> doc) {
    //var snapshot = doc.data() as Map<String, dynamic>;

    id = doc.id;
    name = doc['name'];
    dateCreated = doc['time'];
    //name=doc['name'];
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
