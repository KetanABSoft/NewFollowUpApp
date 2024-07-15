import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'admin_view_task.dart';

class AdminTodaysTask extends StatefulWidget {
  const AdminTodaysTask({Key? key}) : super(key: key);

  @override
  _AdminTodaysTaskState createState() => _AdminTodaysTaskState();
}

class _AdminTodaysTaskState extends State<AdminTodaysTask> {
  List<dynamic>? todaytaskdata; // Updated to use a list
  File? _selectedImage;
  Uint8List? _image;
  File? selectedIMage;
  @override
  void initState() {
    super.initState();
    fetchTodaysTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        elevation: 0,
        title: Text(
          'Today\'s Tasks',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: todaytaskdata == null
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: todaytaskdata!.length,
          itemBuilder: (context, index) {
            var startDate = DateTime.parse(
                todaytaskdata![index]["startDate"]);
            var formattedStartDate =
            DateFormat('yyyy-MM-dd').format(startDate);
            var endDate = DateTime.parse(
                todaytaskdata![index]["deadlineDate"]);
            var formattedEndDate =
            DateFormat('yyyy-MM-dd').format(endDate);
            return  Padding(
              padding: EdgeInsets.only(top: 15),
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  border: Border.all(color: Colors.pink, width: 2),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      color: Colors.pink.shade400,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              todaytaskdata![index]["status"],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Text(
                              "Assign By",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(

                            todaytaskdata![index]["title"],

                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        PopupMenuButton<String>(
                          itemBuilder: (BuildContext context) => [
                            const PopupMenuItem<String>(
                              value: 'view',
                              child: Text('View'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'remark',
                              child: Text('Remark'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'edit',
                              child: Text('Update'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'complete',
                              child: Text('Mark as Completed'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'delete',
                              child: Text('Delete'),
                            ),
                          ],
                          onSelected: (String value) {
                            if (value == 'view') {
                              // Handle view action
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminViewTaskScreen(admin_type: '',)));
                            } else if (value == 'edit') {
                              // Handle edit action
                            } else if (value == 'delete') {
                              // Handle delete action
                            } else if (value == 'remark') {
                              // Handle remark action
                            } else if (value == 'complete') {
                              // Handle complete action
                              _showImagePickerOptions();
                            }
                          },
                          icon: Icon(Icons.more_vert),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Divider(color: Colors.grey, thickness: 2),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Icon(Icons.calendar_today_outlined, size: 18),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  formattedStartDate,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Icon(Icons.watch_later_outlined, size: 18),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  // "${pendingData[index].startTime}",
                                  todaytaskdata![index]["startTime"],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Icon(Icons.calendar_today_outlined, size: 18),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  formattedEndDate,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Icon(Icons.watch_later_outlined, size: 18),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(

                                  todaytaskdata![index]["endTime"],

                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> fetchTodaysTasks() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');

    final url = Uri.parse("http://103.159.85.246:4000/api/task/tasks/today");

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': '$token',
          'Content-Type': 'application/json; charset=utf-8',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          todaytaskdata = jsonDecode(response.body)["todayAddedTasks"];
        });
      } else {
        throw Exception('Failed to fetch tasks');
      }
    } catch (e) {
      throw Exception('Failed to fetch tasks: $e');
    }
  }
  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              InkWell(
                onTap: () {
                  _pickImageFromCamera();
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Icon(Icons.camera_alt, size: 70),
                    SizedBox(width: 10),
                    Text("Camera"),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Handle other options if needed
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
            ],
          ),
        );
      },
    );
  }
  Future _pickImageFromCamera() async {
    final returnImage =
    await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedIMage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Navigator.of(context).pop();
  }

// Other methods like image picking can remain the same if they are not directly related to displaying tasks
}



