import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Define your Data class to represent task details
class View {
  final String id;
  final String title;
  final String description;
  final List<String> assignTo;
  final DateTime startDate;
  final DateTime deadlineDate;
  final DateTime reminderDate;
  final String startTime;
  final String endTime;
  final String reminderTime;
  final String phoneNumber;
  final String status;
  final AssignedBy assignedBy;
  final int v;

  View({
    required this.id,
    required this.title,
    required this.description,
    required this.assignTo,
    required this.startDate,
    required this.deadlineDate,
    required this.reminderDate,
    required this.startTime,
    required this.endTime,
    required this.reminderTime,
    required this.phoneNumber,
    required this.status,
    required this.assignedBy,
    required this.v,
  });

  factory View.fromJson(Map<String, dynamic> json) {
    return View(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      assignTo: List<String>.from(json['assignTo'].map((x) => x)),
      startDate: DateTime.parse(json['startDate']),
      deadlineDate: DateTime.parse(json['deadlineDate']),
      reminderDate: DateTime.parse(json['reminderDate']),
      startTime: json['startTime'],
      endTime: json['endTime'],
      reminderTime: json['reminderTime'],
      phoneNumber: json['phoneNumber'],
      status: json['status'],
      assignedBy: AssignedBy.fromJson(json['assignedBy']),
      v: json['__v'],
    );
  }
}

class AssignedBy {
  final String id;
  final String name;

  AssignedBy({
    required this.id,
    required this.name,
  });

  factory AssignedBy.fromJson(Map<String, dynamic> json) {
    return AssignedBy(
      id: json['_id'],
      name: json['name'],
    );
  }
}

class AdminViewTaskScreen extends StatefulWidget {
  final String admin_type;

  const AdminViewTaskScreen({Key? key, required this.admin_type}) : super(key: key);

  @override
  State<AdminViewTaskScreen> createState() => _AdminViewTaskScreenState();
}

class _AdminViewTaskScreenState extends State<AdminViewTaskScreen> {
  late Future<View> _taskFuture;

  @override
  void initState() {
    super.initState();
    _taskFuture = fetchTask();
  }

  Future<View> fetchTask() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    String? taskId = preferences.getString('taskId'); // Fetch stored task ID

    if (taskId == null) {
      throw Exception('Task ID not found in SharedPreferences');
    }

    final url = Uri.parse("http://103.159.85.246:4000/api/task/$taskId");

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': '$token',
          'Content-Type': 'application/json; charset=utf-8',
        },
      );

      if (response.statusCode == 200) {
        var taskData = jsonDecode(response.body);
        return View.fromJson(taskData);
      } else {
        throw Exception('Failed to fetch task');
      }
    } catch (e) {
      throw Exception('Failed to fetch task: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Task'),
      ),
      body: FutureBuilder<View>(
        future: _taskFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data found'));
          } else {
            View task = snapshot.data!;
            return  Padding(
                padding: EdgeInsets.only(top: 15),
                child: Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      border: Border.all(color: Color(0xFFFFD700), width: 2),
                    ),
                    child: Column(
                        children: [
                          Container(
                            height: 50,
                            color: Color(0xFFFFD700),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child:  Text(
                                    'Task Title: ${task.title}',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child:  Text('Description: ${task.description}'),
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
                                child:   Text('Assigned To: ${task.assignTo.join(', ')}'),
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
                                  } else if (value == 'edit') {
                                    // Handle edit action
                                  } else if (value == 'delete') {
                                    // Handle delete action
                                  } else if (value == 'remark') {
                                    // Handle remark action
                                  } else if (value == 'complete') {
                                    // Handle complete action

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
                                      child:Text('Start Date: ${DateFormat('yyyy-MM-dd').
                                      format(task.startDate)}'),

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
                                      child: Text('Deadline Date: ${DateFormat('yyyy-MM-dd').
                                      format(task.deadlineDate)}'),

                                    )
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
                                      child: Text('reminderDate : ${DateFormat('yyyy-MM-dd').
                                      format(task.reminderDate)}'),

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
                                      child: Text('Status: ${task.status}'),
                                    ),

                                  ],
                                ),

                              ),

                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 10,top: 10),
                                child:   Text('assignedBy : ${task.assignedBy.name.toString()}'),
                              ),
                            ],
                          ),
                        ]
                    )
                )
            );
          }
        },
      ),
    );
  }
}


