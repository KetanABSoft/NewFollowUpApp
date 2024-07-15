import 'package:flutter/cupertino.dart';
import 'package:followup/models/register_model.dart';
import 'package:followup/models/registration_model.dart';
import 'package:followup/models/subscription_model.dart';
import 'package:followup/models/subscription_year_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../api/api_manager.dart';
import '../constant/string_constant.dart';
import '../models/login_model.dart';
import '../repositories/auth_repository.dart';
import '../routes/route.dart';
import '../widgets/constant_widgets.dart';

class LoginController extends GetxController {
  AuthRepository authRepository = AuthRepository(APIManager());

  final TextEditingController username = TextEditingController();
  final TextEditingController subscriberName = TextEditingController();
  final TextEditingController password = TextEditingController();

  // Login  api
  Rx<LoginModel> loginModelResponse = LoginModel().obs;

  RxString loginResponseMessage = "".obs;


  Future<bool> loginAPI({bool isLoaderShow = true}) async {
    try {
      LoginModel loginModel = await authRepository.loginApiCall(
          isLoaderShow: isLoaderShow,
          params: {
        'email': username.text.trim(),
        'password': password.text.trim(),
      });
      if (loginModel.token != null && loginModel.token!.isNotEmpty) {
        isTokenValid.value = true;
        GetStorage().write(loginDataKey, loginModel.toJson());
        loginModelResponse.value = loginModel;
        if (loginModel.message != null && loginModel.message!.isNotEmpty) {
          loginResponseMessage.value = loginModel.message!.toString();
        }
        return true;
      } else {
        isTokenValid.value = false;
        errorSnackBar(message: loginModel.message.toString());
        return false;
      }
    } catch (e) {
      dismissProgressIndicator();
      return false;
    }
  }
  Future<bool> registerAPI({bool isLoaderShow = true}) async {
    try {
      RegisterModel registerModel = await authRepository.getRegisterApiCall(
          isLoaderShow: isLoaderShow,
          params: {
            "name": subscriberName.text.trim()
          });
      if (registerModel.data != null && registerModel.data!.status == "registered") {
        successSnackBar(message: registerModel.message);
        return true;
      } else {
        isTokenValid.value = false;
        errorSnackBar(message: registerModel.toString());
        return false;
      }
    } catch (e) {
      dismissProgressIndicator();
      return false;
    }
  }
  Future<bool> checkRegistrationAPI({bool isLoaderShow = true}) async {
    try {
      RegistrationModel registrationModel = await authRepository.getRegistrationApiCall(isLoaderShow: isLoaderShow);
      if (registrationModel.name != null && registrationModel.name!.isNotEmpty) {
        if(registrationModel.registrationEndDate != null && registrationModel.registrationEndDate != ""){
          if(DateTime.parse(registrationModel.registrationEndDate!).isAfter(DateTime.now())){
             GetStorage().write(name, registrationModel.name);
             await checkSubscriptionAPI();
            return true;
          } else{
            GetStorage().write(name, registrationModel.name);
            return true;
          }
        } else{
          return false;
        }
      }
      return false;
    } catch (e) {
      dismissProgressIndicator();
      return false;
    }
  }
  Future<bool> checkSubscriptionAPI({bool isLoaderShow = true}) async {
    try {
      SubscriptionModel subscriptionModel = await authRepository.getCheckSubscriptionApiCall(isLoaderShow: isLoaderShow,);
      if (subscriptionModel.status != null && subscriptionModel.status == "subscribed") {
        if(DateTime.parse(subscriptionModel.subscriptionEndDate!).isAfter(DateTime.now())){
          GetStorage().write(name, subscriptionModel.name);
          // Get.offAllNamed(Routes.SUBSCRIPTION_SCREEN);
          return false;
        } else{
          GetStorage().write(name, subscriptionModel.name);
          return true;
        }
      } else {
        return false;
      }
    } catch (e) {
      dismissProgressIndicator();
      return false;
    }
  }
  Future<bool> subscriptionAPI({bool isLoaderShow = true,}) async {
    try {
      SubscriptionYearlyModel subscriptionYearlyModel = await authRepository.subscribeApiCall(isLoaderShow: isLoaderShow,
        params: {
          "name": GetStorage().read(name)
          });
      if (subscriptionYearlyModel.data != null && subscriptionYearlyModel.data!.status == "subscribed") {
        successSnackBar(message: subscriptionYearlyModel.message);
        return true;
      } else {
        errorSnackBar(message: "Please try again something went wrong!");
        return false;
      }
    } catch (e) {
      dismissProgressIndicator();
      return false;
    }
  }

}