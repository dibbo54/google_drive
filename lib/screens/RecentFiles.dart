import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googledrive/utils.dart';

import '../controllers/FilesScreenController.dart';

class RecentFiles extends StatelessWidget {
  const RecentFiles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Recent Files",
            style: textStyle(20, textColor, FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        GetX<FilesScreenController>(
            //stream: null,
            builder: (FilesScreenController controller) {
          return Container(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.recentfilesList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 13),
                  child: Container(
                    height: 65,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        controller.recentfilesList[index].fileType == 'image'
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(18),
                                child: Image(
                                  image: NetworkImage(
                                      controller.recentfilesList[index].url),
                                  width: 65,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Container(
                                width: 65,
                                height: 60,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey, width: .15),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Center(
                                  child: Image(
                                    width: 42,
                                    height: 42,
                                    image: AssetImage(
                                        'images/${controller.recentfilesList[index].fileExtension}.png'),
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          controller.recentfilesList[index].name,
                          style: textStyle(13, textColor, FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        })
      ],
    );
  }
}
