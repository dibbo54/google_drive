import 'package:flutter/material.dart';
import 'package:googledrive/controllers/authController.dart';
import 'package:googledrive/utils.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  //AuthController authController = Get.find(AuthController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomLeft,
              colors: [Colors.deepPurpleAccent, Colors.purpleAccent])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).viewInsets.top + 52),
              child: const Image(
                image: AssetImage('images/filem.jpg'),
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const Spacer(),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 30, right: 30, bottom: 35),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(45),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(color: Colors.white, spreadRadius: 5)
                  ]),
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Simplify your",
                      style: textStyle(
                          25, const Color(0xff635C98), FontWeight.w700),
                    ),
                    Text(
                      "filing System",
                      style: textStyle(
                          25, const Color(0xff635C98), FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "keep your files",
                      style: textStyle(20, textColor, FontWeight.w600),
                    ),
                    Text(
                      "organized more easily",
                      style: textStyle(20, textColor, FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: (){
                        Get.find<AuthController>().login();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.7,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.deepOrangeAccent.withOpacity(.8)),
                        child: Center(
                          child: Text(
                            "Let's go",
                            style: textStyle(23, Colors.white, FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
