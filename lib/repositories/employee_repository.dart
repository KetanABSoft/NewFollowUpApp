import 'package:followup/models/employee/add_employee_model.dart';
import 'package:followup/models/employee/all_employee_model.dart';
import 'package:followup/models/register_model.dart';
import 'package:followup/models/registration_model.dart';
import 'package:followup/models/subscription_model.dart';
import 'package:followup/models/subscription_year_model.dart';
import '../api/api_manager.dart';
import '../constant/string_constant.dart';
import '../models/employee/delete_employee.dart';
import '../models/employee/update_employee_model.dart';
import '../models/login_model.dart';

class EmployeeRepository {
  final APIManager apiManager;
  EmployeeRepository(this.apiManager);

  Future<UpdateEmployeeModel> updateEmployeeApiCall({required var params, bool isLoaderShow = true,required String empId}) async {
    var jsonData = await apiManager.putAPICall(
      url: '${baseUrl}api/subemployee/update/$empId',
      params: params,
      isLoaderShow: isLoaderShow,
    );
    var response = UpdateEmployeeModel.fromJson(jsonData);
    return response;
  }

  Future<AddEmployeeModel> addEmployeeApiCall({required var params, bool isLoaderShow = true}) async {
    var jsonData = await apiManager.postAPICall(
      url: '${baseUrl}api/employee/registersub',
      params: params,
      isLoaderShow: isLoaderShow,
    );
    var response = AddEmployeeModel.fromJson(jsonData);
    return response;
  }

  Future<List<AllEmployeeModel>> getAllEmployeeApiCall({bool isLoaderShow = true}) async {
    var jsonData = await apiManager.getAPICall(
      url: '${baseUrl}api/employee/subemployees/list',
      isLoaderShow: isLoaderShow,
    );
    var response = jsonData as List;
    List<AllEmployeeModel> objects = response.map((e) => AllEmployeeModel.fromJson(e)).toList();
    print(objects.toString());
    return objects;
  }

  Future<DeleteEmployeeModel> deleteEmployeeApiCall({required var params, bool isLoaderShow = true,required String empId}) async {
    var jsonData = await apiManager.deleteAPICall(
      url: '${baseUrl}api/subemployee/delete/$empId',
      params: params,
      isLoaderShow: isLoaderShow,
    );
    var response = DeleteEmployeeModel.fromJson(jsonData);
    return response;
  }

}
