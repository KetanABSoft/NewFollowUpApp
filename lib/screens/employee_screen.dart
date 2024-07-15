import 'package:flutter/material.dart';
import 'package:followup/controller/employee_controller.dart';
import 'package:followup/widgets/constant_widgets.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../routes/route.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {

  EmployeeController employeeController = Get.find();

  @override
  void initState() {
    callApi();
    super.initState();
  }

  callApi() async {
    await employeeController.getEmployeeAPI(isLoaderShow: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Employee Management",style: TextStyle(color: Colors.white),),backgroundColor: Colors.deepPurple,),
      body: Obx(()=>
        employeeController.employeeList.isNotEmpty?
         ListView.builder(
            itemCount: employeeController.employeeList.length,
            itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    title: Text(employeeController.employeeList[index].name??"-",style: TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(employeeController.employeeList[index].email??"-"),
                        Text(employeeController.employeeList[index].phoneNumber??"-"),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            Get.toNamed(Routes.ADD_UPDATE_EMPLOYEE_SCREEN,arguments: ['update',employeeController.employeeList[index].sId??""]);
                          },
                            child: Icon(Icons.edit,color: Colors.blue,)),
                        SizedBox(width: 2.w,),
                        GestureDetector(
                          onTap: () async {
                            showProgressIndicator();
                            bool result = await employeeController.deleteEmployeeAPI(empId: employeeController.employeeList[index].sId??"",isLoaderShow: false);
                            if(result){
                             await employeeController.getEmployeeAPI(isLoaderShow: false);
                             dismissProgressIndicator();
                           }
                          },
                            child: Icon(Icons.delete,color: Colors.red,)),
                      ],
                    ),
                  ),
                ),
              );
            }
        ):SizedBox.shrink(),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed:() {
            Get.toNamed(Routes.ADD_UPDATE_EMPLOYEE_SCREEN,arguments: ['add',""]);
          },
        child: Icon(Icons.add),
      ),
    );
  }
}
