import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/admin_controller/admin_add_employee_controller.dart';
import 'set_wages.dart'; // Import your SetWages screen here

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({Key? key}) : super(key: key);

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  late final AddEmployeeController addEmployeeController;
  bool obscurePassword = true;
  bool isAddingEmployee = true; // Default to true for Office Employee
  bool isAddingSellar = false; // Default to false for Sales Employee

  @override
  void initState() {
    super.initState();
    addEmployeeController = Get.put(AddEmployeeController());
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xff7c81dd),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              'Add Employee',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: addEmployeeController.employeeKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenSize.height * 0.05),
                TextFormField(
                  controller: addEmployeeController.usernameController,
                  decoration: InputDecoration(
                    labelText: 'name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenSize.height * 0.02),
                TextFormField(
                  controller: addEmployeeController.emailController,
                  decoration: InputDecoration(
                    labelText: 'Email Id',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenSize.height * 0.02),
                TextFormField(
                  controller: addEmployeeController.passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscurePassword ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                    ),
                  ),
                  obscureText: obscurePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenSize.height * 0.02),
                TextFormField(
                  controller: addEmployeeController.mobileNoController,
                  decoration: InputDecoration(
                    labelText: 'Mobile No',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter mobile number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenSize.height * 0.06),

                // Checkbox for adding Employee or Seller
                Row(
                  children: [
                    Checkbox(
                      value: isAddingEmployee,
                      onChanged: (value) {
                        setState(() {
                          isAddingEmployee = value ?? false;
                          isAddingSellar = !isAddingEmployee;
                        });
                      },
                    ),
                    Text('Office Employee'),
                    SizedBox(width: 20),
                    Checkbox(
                      value: isAddingSellar,
                      onChanged: (value) {
                        setState(() {
                          isAddingSellar = value ?? false;
                          isAddingEmployee = !isAddingSellar;
                        });
                      },
                    ),
                    Text('Sales Employee'),
                  ],
                ),

                SizedBox(height: screenSize.height * 0.02),
                Container(
                  height: screenSize.height * 0.06,
                  width: screenSize.width * 0.3,
                  decoration: BoxDecoration(
                    color: Color(0xff7c81dd),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: () {
                      if (addEmployeeController.employeeKey.currentState!.validate()) {
                        if (isAddingEmployee) {
                          addEmployeeController.addEmployee('Acme').then((success) {
                            if (success) {
                              showResponseDialog1('Employee added successfully');
                              navigateToNextScreen(); // Navigate on success
                            } else {
                              showResponseDialog('Failed to add employee');
                            }
                          });
                        } else if (isAddingSellar) {
                          addEmployeeController.addSeller('Acme').then((success) {
                            if (success) {
                              showResponseDialog1('Seller added successfully');
                               // Navigate on success
                            } else {
                              showResponseDialog('Failed to add seller');
                            }
                          });
                        }
                      }
                    },
                    child: Text(
                      "Next",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: screenSize.height * 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showResponseDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text("API Response"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  void showResponseDialog1(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text("API Response"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                navigateToNextScreen();
              },
            ),
          ],
        );
      },
    );
  }

  void navigateToNextScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SetWidgets()), // Replace SetWages with your desired screen
    );
  }
}
