import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googledrive/model/fileModel.dart';
import 'package:googledrive/utils.dart';

import '../firebase.dart';
import '../widgets/AudioPlayerWidget.dart';
import '../widgets/PdfViewer.dart';
import '../widgets/VideoPlayerwidget.dart';

class ViewFileScreen extends StatelessWidget {
  FileModel file;

  ViewFileScreen(this.file, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        child: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            file.name,
            style: textStyle(18, Colors.white, FontWeight.w600),
          ),
          actions: [
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(8),
                    ),
                  ),
                  builder: (context) {
                    return Column(
                      //mainAxisAlignment: MainAxisAlignment,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              file.name,
                              style:
                                  textStyle(16, Colors.black, FontWeight.w500),
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                          height: 3,
                        ),
                        ListTile(
                          onTap:(){
                            FirebaseService().downloadFile(
                                file);
                           // Get.back();
                          },
                          leading: Icon(
                            Icons.file_download,
                            color: Colors.grey,
                          ),
                          contentPadding:
                              EdgeInsets.only(bottom: 0, left: 16, top: 12),
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          dense: true,
                          title: Text(
                            "Download",
                            style: textStyle(16, Colors.black, FontWeight.w500),
                          ),
                        ),
                        ListTile(
                          onTap:(){
                            FirebaseService().deleteFile(
                                file);
                            //Get.back();
                          },
                          leading: Icon(
                            Icons.delete,
                            color: Colors.grey,
                          ),
                          contentPadding:
                              EdgeInsets.only(bottom: 12, left: 16, top: 8),
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          dense: true,
                          title: Text(
                            "Remove",
                            style: textStyle(16, Colors.black, FontWeight.w500),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: Icon(Icons.more_vert),
            )
          ],
        ),
        preferredSize: Size.fromHeight(45),
      ),
      body: file.fileType == "image"
          ? showImage(file.url)
          : file.fileType == "application"
              ? showFile(file, context)
              : file.fileType == "video"
                  ? VideoPlayerwidget(file.url)
                  : file.fileType == "audio"
                      ? AudioPlayerWidget(file.url)
                      : showError()
                     // : Container(),
    );
  }
}

showError(){

}

showImage(String url) {
  return Center(
    child: Image(
      image: NetworkImage(url),
    ),
  );
}

showFile(FileModel file, context) {
  if (file.fileExtension == 'pdf') {
    return PdfViewer(file);
  } else {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Unfortunately this file cannot be opened",
            style: textStyle(18, Colors.white, FontWeight.w600),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2,
            height: 36,
            child: TextButton(
              onPressed: () {},
              style:
                  TextButton.styleFrom(backgroundColor: Colors.lightBlueAccent),
              child: Center(
                child: Text(
                  "Download",
                  style: textStyle(17, Colors.white, FontWeight.w600),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
