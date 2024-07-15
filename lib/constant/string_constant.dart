import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../models/login_model.dart';
import '../routes/route.dart';
import '../widgets/constant_widgets.dart';

class AppString {
  // static const String constanturl ="http://192.168.2.111/Followup/getlist.php?Type=";
  // static const String imageurl ="http://192.168.2.111/Followup/upload/";
  // static const String audiourl ="http://192.168.2.111/Followup/audio/";
  // static const String profileurl ="http://192.168.2.111/Followup/assets/images/employee_photo/";

  // static const String constanturl =
  //     "http://192.168.2.109/Followup/getlist.php?Type=";
  static const String imageurl = "http://192.168.2.109/Followup/upload/";
  static const String audiourl = "http://192.168.2.109/Followup/audio/";
  static const String profileurl =
      "http://192.168.2.109/Followup/assets/images/employee_photo/";

  static const String constanturl =
      "https://followup.attulyabhaarat.com/getlist.php?Type=";
  // static const String imageurl = "https://followup.attulyabhaarat.com/upload/";
  // static const String audiourl = "https://followup.attulyabhaarat.com/audio/";
  // static const String profileurl =
  //     "https://followup.attulyabhaarat.com/assets/images/employee_photo/";

//static const appgraycolor = Colors.grey;
  static const appgraycolor = Color.fromARGB(255, 121, 118, 118);

}

RxBool isInternetAvailable = false.obs;
const apiTimeOutMsg = 'Request timeout, please try again!';
const noInternetMsg = 'Please check your internet connection';
const baseUrl = 'http://103.159.85.246:4000/';
RxBool isTokenValid = false.obs;
const loginDataKey = 'loginDataKey';
const name = 'name';
const tokenInfo = 'tokenInfo';



// Get stored login details
LoginModel getStoredLoginDetails() {
  LoginModel loginModel = LoginModel();
  var data = GetStorage().read(loginDataKey);
  if (data != null) {
    loginModel = LoginModel.fromJson(GetStorage().read(loginDataKey));
  }
  return loginModel;
}

// Get stored user auth token
String getAuthToken() {
  LoginModel loginModel = getStoredLoginDetails();
  if (loginModel.token != null && loginModel.token!.isNotEmpty) {
    // bool isTokenExpired = JwtDecoder.isExpired(loginModel.token!);
    // print(isTokenExpired.toString());
    // if (isTokenExpired == true) {
    //   isTokenValid.value = false;
    //   Timer(const Duration(seconds: 1), () {
    //     Get.offNamed(Routes.LOGIN_SCREEN_ROUTE);
    //     errorSnackBar(message: 'Your session has expired!');
    //   });
    //   return '';
    // } else {
      isTokenValid.value = true;
      return loginModel.token!;
    // }
  } else {
    isTokenValid.value = false;
    return '';
  }
}