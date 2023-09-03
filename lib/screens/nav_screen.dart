import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:googledrive/controllers/navController.dart';
import 'package:googledrive/screens/FilesScreen.dart';

import '../widgets/Header.dart';
import 'StorageScreen.dart';

import 'package:get/get.dart';

class NavScreen extends StatelessWidget {
  const NavScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: InkWell(
      //   onTap: (){
      //     FirebaseAuth.instance.signOut();
      //   },
      // ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(25),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),

      body: Obx(
        () => Column(
          children: [
            Header(),
            Get.find<NavController>().tab.value == "Storage"
                ? StorageScreen()
                : FilesScreen(),
            //StorageScreen()
          ],
        ),
      ),
    );
  }
}
