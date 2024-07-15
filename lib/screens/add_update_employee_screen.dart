import 'package:flutter/material.dart';
import 'package:followup/controller/employee_controller.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../widgets/Appcolors.dart';
import '../widgets/textIputField.dart';



class AddUpdateEmployeeScreen extends StatefulWidget {
  AddUpdateEmployeeScreen({super.key});

  @override
  State<AddUpdateEmployeeScreen> createState() => _AddUpdateEmployeeScreenState();
}

class _AddUpdateEmployeeScreenState extends State<AddUpdateEmployeeScreen> {
final EmployeeController employeeController = Get.find();

@override
  void dispose() {
    employeeController.clearTextFields();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5.h,
              ),
              Text(
                "Welcome to Employee Panel",
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold),
              ),
              CommonTextField("Enter your full name", "Name", false, employeeController.nameController),
              CommonTextField("Mobile Number", "enter your mobile number", false, employeeController.emailController),
              CommonTextField("Password", "Enter new Password", true, employeeController.passwordController),
              CommonTextField("Company Name", "Enter new Company name", false, employeeController.adminCompanyNameController),
              CommonTextField("Phone Number", "Enter your Phone Number", false, employeeController.phoneNumberController),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4.h),
                child: MaterialButton(
                  onPressed: () async {
                    Get.arguments == "add"?
                    await employeeController.addEmployeeAPI(
                        name: employeeController.nameController.text.trim(),
                        email: employeeController.emailController.text.trim(),
                        password: employeeController.passwordController.text.trim(),
                        adminCompanyName: employeeController.adminCompanyNameController.text.trim(),
                        phoneNumber: employeeController.phoneNumberController.text.trim()
                    ): await employeeController.updateEmployeeAPI(
                        empId:Get.arguments[0],
                        name: employeeController.nameController.text.trim(),
                        email: employeeController.emailController.text.trim(),
                        password: employeeController.passwordController.text.trim(),
                        adminCompanyName: employeeController.adminCompanyNameController.text.trim(),
                        phoneNumber: employeeController.phoneNumberController.text.trim(),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.primaryColor,
                    ),
                    width: 100.w,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        "Add Employee",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontSize: 12.sp),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}