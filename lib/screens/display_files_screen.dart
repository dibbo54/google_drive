import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googledrive/controllers/filesController.dart';
//import 'package:googledrive/controllers/filesController.dart';
import 'package:googledrive/firebase.dart';
import 'package:googledrive/screens/view_file_screen.dart';
import 'package:googledrive/utils.dart';

class DisplayFilesScreen extends StatelessWidget {
  final String title;
  final String type;

  DisplayFilesScreen(this.title, this.type);

  FilesController filesController = Get.find<FilesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: textColor,
            ),
          ),
          title: Text(
            title,
            style: textStyle(18, textColor, FontWeight.bold),
          ),
        ),
        preferredSize: Size.fromHeight(48),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          type == "folder"
              ? FirebaseService().uploadFile(title)
              : FirebaseService().uploadFile('');
        },
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.redAccent[200],
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
      body: Obx(
        () => GridView.builder(
          itemCount: filesController.files.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 1.25),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Get.to(
                  () => ViewFileScreen(filesController.files[index]),
                );
              },
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 10, top: 15),
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Column(
                    children: [
                      filesController.files[index].fileType == "image"
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: Image(
                                image: NetworkImage(
                                    filesController.files[index].url),
                                width: MediaQuery.of(context).size.width / 2.5,
                                height: 75,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              height: 75,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: .2),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Center(
                                child: Image(
                                  width: 55,
                                  height: 55,
                                  image: AssetImage(
                                      'images/${filesController.files[index].fileExtension}.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                      Padding(
                        padding: EdgeInsets.only(left: 4, top: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Text(
                                filesController.files[index].name,
                                style:
                                    textStyle(14, textColor, FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.more_vert,
                                color: Colors.black,
                                size: 20,
                              ),
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
                                              filesController.files[index].name,
                                              style: textStyle(16, Colors.black,
                                                  FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        Divider(
                                          color: Colors.grey,
                                          height: 3,
                                        ),
                                        ListTile(
                                          onTap: () {
                                            FirebaseService().downloadFile(
                                                filesController.files[index]);
                                            Get.back();
                                          },
                                          leading: Icon(
                                            Icons.file_download,
                                            color: Colors.grey,
                                          ),
                                          contentPadding: EdgeInsets.only(
                                              bottom: 0, left: 16, top: 12),
                                          visualDensity: VisualDensity(
                                              horizontal: 0, vertical: -4),
                                          dense: true,
                                          title: Text(
                                            "Download",
                                            style: textStyle(16, Colors.black,
                                                FontWeight.w500),
                                          ),
                                        ),
                                        ListTile(
                                          onTap:(){
                                            FirebaseService().deleteFile(
                                                filesController.files[index]);
                                            Get.back();
                                          },
                                          leading: Icon(
                                            Icons.delete,
                                            color: Colors.grey,
                                          ),
                                          contentPadding: EdgeInsets.only(
                                              bottom: 12, left: 16, top: 8),
                                          visualDensity: VisualDensity(
                                              horizontal: 0, vertical: -4),
                                          dense: true,
                                          title: Text(
                                            "Remove",
                                            style: textStyle(16, Colors.black,
                                                FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
