import 'package:get/get.dart';

class NavController extends GetxController{
  RxString tab="Storage".obs;

  changeTab(String givenTab){
    tab.value=givenTab;
  }
}