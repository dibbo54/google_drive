import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googledrive/controllers/filesController.dart';
import 'package:googledrive/screens/display_files_screen.dart';

class UploadOptions extends StatelessWidget {
  //const UploadOptions({Key? key}) : super(key: key);
  Widget colouredContainer(
      Color bgcolor, Icon icon, String option, String title) {
    return InkWell(
      onTap: () => Get.to(() => DisplayFilesScreen(title, 'files'),
          binding: FilesBinding('files', '', option)),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: bgcolor),
        child: Center(
          child: icon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        colouredContainer(
          Colors.lightBlue.withOpacity(.2),
          Icon(
            Icons.image,
            color: Colors.cyan,
            size: 30,
          ),
          "image",
          "Images",
        ),
        colouredContainer(
          Colors.pink.withOpacity(.3),
          Icon(
            Icons.play_arrow_rounded,
            color: Colors.pink.withOpacity(.5),
            size: 42,
          ),
          "video",
          "Videos",
        ),
        colouredContainer(
          Colors.blue.withOpacity(.4),
          Icon(
            //Icons.image,
            EvaIcons.fileText,
            color: Colors.indigoAccent.withOpacity(.5),
            size: 30,
          ),
          "application",
          "Documents",
        ),
        colouredContainer(
          Colors.lightBlue.withOpacity(.2),
          Icon(
            EvaIcons.music,
            color: Colors.pink.withOpacity(.3),
            size: 30,
          ),
          "audio",
          "Audios",
        )
      ],
    );
  }
}
