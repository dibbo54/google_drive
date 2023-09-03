import 'package:flutter/material.dart';
import 'package:googledrive/controllers/navController.dart';
import 'package:googledrive/utils.dart';
import 'package:get/get.dart';

class Header extends StatelessWidget {
  //const Header({Key? key}) : super(key: key);

  //Get.put(NavController);

  //NavController navController=Get.put(NavController);
  NavController navController = Get.put(NavController());

  Widget tabCell(BuildContext context, String text, bool selected) {
    return selected
        ? Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.45 - 5,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.deepOrangeAccent,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        offset: const Offset(10, 10),
                        blurRadius: 10),
                    BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        offset: const Offset(-10, 10),
                        blurRadius: 10),
                  ]),
              child: Center(
                child: Text(
                  text,
                  style: textStyle(23, Colors.white, FontWeight.bold),
                ),
              ),
            ),
          )
        : Container(
            width: MediaQuery.of(context).size.width * 0.45 - 10,
            height: 60,
            child: Center(
                child: Text(
              text,
              style: textStyle(23, textColor, FontWeight.bold),
            )),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(
            "F-drive",
            style: textStyle(28, textColor, FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 20, right: 20),
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    offset: const Offset(10, 10),
                    blurRadius: 10),
                BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    offset: const Offset(-10, 10),
                    blurRadius: 10),
              ],
            ),
            child: Obx(
              () => Row(
                children: [
                  InkWell(
                    onTap: () => navController.changeTab("Storage"),
                    child: tabCell(context, "Storage",
                        navController.tab.value == "Storage"),
                  ),
                  InkWell(
                    onTap: () => navController.changeTab("Files"),
                    child: tabCell(
                        context, "Files", navController.tab.value == "Files"),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
