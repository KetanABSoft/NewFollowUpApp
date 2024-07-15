import 'package:flutter/cupertino.dart';
import 'package:followup/models/employee/add_employee_model.dart';
import 'package:followup/models/employee/all_employee_model.dart';
import 'package:followup/models/employee/update_employee_model.dart';
import 'package:followup/repositories/employee_repository.dart';
import 'package:get/get.dart';
import '../api/api_manager.dart';
import '../models/employee/delete_employee.dart';
import '../widgets/constant_widgets.dart';

class EmployeeController extends GetxController {
  EmployeeRepository employeeRepository = EmployeeRepository(APIManager());

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController adminCompanyNameController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  void clearTextFields(){
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    adminCompanyNameController.clear();
    phoneNumberController.clear();
  }

  RxList<AllEmployeeModel> employeeList = <AllEmployeeModel>[].obs;

  Future<bool> getEmployeeAPI({bool isLoaderShow = true}) async {
    try {
      List<AllEmployeeModel> employeeListModel = await employeeRepository.getAllEmployeeApiCall(
        isLoaderShow: isLoaderShow,
      );
      if (employeeListModel.isNotEmpty) {
        employeeList.value = employeeListModel;
        return true;
      } else {
        return false;
      }
    } catch (e) {
      dismissProgressIndicator();
      return false;
    }
  }

  Future<bool> deleteEmployeeAPI({bool isLoaderShow = true,
    required String empId,
  }) async {
    try {
      DeleteEmployeeModel deleteEmployeeModel = await employeeRepository.deleteEmployeeApiCall(
          isLoaderShow: isLoaderShow,
          params:[], empId: empId);
      if (deleteEmployeeModel.message != null && deleteEmployeeModel.message!.isNotEmpty) {
        successSnackBar(message: deleteEmployeeModel.message);
        return true;
      } else {
        errorSnackBar(message: deleteEmployeeModel.message);
        return false;
      }
    } catch (e) {
      dismissProgressIndicator();
      return false;
    }
  }

  Future<bool> updateEmployeeAPI({bool isLoaderShow = true,
    required String empId,
    required String name,
    required String email,
    required String password,
    required String adminCompanyName,
    required String phoneNumber,
  }) async {
    try {
      UpdateEmployeeModel updateEmployeeModel = await employeeRepository.updateEmployeeApiCall(
          isLoaderShow: isLoaderShow,
          params: {
              "name": name,
              "email": email,
              "password": password,
              "adminCompanyName": adminCompanyName,
              "phoneNumber": phoneNumber
            }
          , empId: empId);
      if (updateEmployeeModel.message != null && updateEmployeeModel.message!.isNotEmpty) {
        successSnackBar(message: updateEmployeeModel.message);
        clearTextFields();
        return true;
      } else {
        errorSnackBar(message: updateEmployeeModel.message);
        return false;
      }
    } catch (e) {
      dismissProgressIndicator();
      return false;
    }
  }

  Future<bool> addEmployeeAPI({bool isLoaderShow = true,
    required String name,
    required String email,
    required String password,
    required String adminCompanyName,
    required String phoneNumber,
  }) async {
    try {
      AddEmployeeModel addEmployeeModel = await employeeRepository.addEmployeeApiCall(
          isLoaderShow: isLoaderShow,
          params: {
            "name": name,
            "email": email,
            "password": password,
            "adminCompanyName": adminCompanyName,
            "phoneNumber": phoneNumber
          });
      if (addEmployeeModel.message != null && addEmployeeModel.message!.isNotEmpty) {
        successSnackBar(message: addEmployeeModel.message);
        clearTextFields();
        return true;
      } else {
        errorSnackBar(message: addEmployeeModel.message);
        return false;
      }
    } catch (e) {
      dismissProgressIndicator();
      return false;
    }
  }

}