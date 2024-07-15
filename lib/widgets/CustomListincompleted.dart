import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:followup/constant/conurl.dart';
// import 'package:followup/emp_edit_task.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../employee/emp_edit_task.dart';
import '../employee/remark_screen.dart';
import '../employee/emp_task_completed_screen.dart';
import '../employee/emp_task_pending_screen.dart';
import '../employee/emp_view_task_screen.dart';

String? admintype;
String? mainid;

void launchWhatsApp(String phoneNumber, String message) async {
  String whatsappUrl =
      "whatsapp://send?phone=$phoneNumber" "&text=${Uri.encodeFull(message)}";
  try {
    await launch(whatsappUrl);
  } catch (e) {
    //handle error properly
  }
}

void deletedata(String id) async {
  print(id);
  //var urlString = 'http://testfollowup.absoftwaresolution.in/getlist.php?Type=deletetask';
  var urlString = AppString.constanturl + 'deletetask';
  Uri uri = Uri.parse(urlString);
  var response = await http.post(uri, body: {"id": id});
  var jsondata = jsonDecode(response.body);
  print(jsondata);
  if (jsondata['success'] == "success") {
    Fluttertoast.showToast(
      backgroundColor: Color.fromARGB(255, 0, 255, 55),
      textColor: Colors.white,
      msg: jsondata['message'],
      toastLength: Toast.LENGTH_SHORT,
    );
  }
}

void completetask(String id) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  admintype = preferences.getString('admintype');
  mainid = preferences.getString('id');
  print(admintype);
  print('mainid');
  //var urlString = 'http://testfollowup.absoftwaresolution.in/getlist.php?Type=completetask';
  var urlString = AppString.constanturl + 'completetask';
  Uri uri = Uri.parse(urlString);
  var response = await http
      .post(uri, body: {"id": id, "mainid": mainid, "admintype": admintype});
  var jsondata = jsonDecode(response.body);
  print(jsondata);
  if (jsondata['success'] == "success") {
    Fluttertoast.showToast(
      backgroundColor: Color.fromARGB(255, 0, 255, 55),
      textColor: Colors.white,
      msg: jsondata['message'],
      toastLength: Toast.LENGTH_SHORT,
    );
  }
}

class CustomListincompleted extends StatelessWidget {
  final String? id;
  final String? title;
  final String? date;
  final String? deadline;
  final String? starttime;
  final String? endtime;
  final String? assign;
  final String? mobile;
  final String? assignedby;
  final String? assignid;
  final String? admintype;
  final String? mainid;
  final String? status;
  final Function? trailingButtonOnTap;
  final double opacity;

  const CustomListincompleted({
    Key? key,
    required this.id,
    required this.title,
    required this.date,
    required this.deadline,
    required this.starttime,
    required this.endtime,
    required this.assign,
    required this.mobile,
    required this.assignedby,
    required this.assignid,
    required this.admintype,
    required this.mainid,
    required this.status,
    required this.trailingButtonOnTap,
    required this.opacity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //String? id = "";
    ScrollController controller = ScrollController();
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Viewtask(id: '$id')),
          );
        },
        child: Container(
          margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            //color: status == 'complete' ? Colors.lightGreen : status =='pending'? Colors.white : Color(0xFFff8a8a),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
                // Offset in the x and y directions
              ),
            ],
          ),
          child: Opacity(
            opacity: opacity,
            // child: Padding(
            //   padding: EdgeInsets.all(16.0),
            child: Column(children: [
              Container(
                decoration: BoxDecoration(
                  color: status == 'complete'
                      ? Color(0xFFC9CC3F)
                      : status == 'pending'
                          ? Colors.amber
                          : status == 'Overdue'
                              ?
                              // Color(0xFF00CED1)
                              Color.fromARGB(
                                  255, // Alpha component (fully opaque)
                                  194, // Red component
                                  24, // Green component
                                  7, // Blue component
                                )
                              // : Color.fromARGB(
                              //     255, // Alpha component (fully opaque)
                              //     194, // Red component
                              //     24,  // Green component
                              //     7,   // Blue component
                              //   ),
                              : Color.fromARGB(255, 77, 77, 174),
                  borderRadius: BorderRadius.only(
                    topLeft:
                        Radius.circular(10.0), // Adjust the radii as needed
                    topRight: Radius.circular(10.0),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      30.0, 10.0, 30.0, 10.0), // Padding for the first Row
                  child: Container(
                    color: status == 'complete'
                        ? Color(0xFFC9CC3F)
                        : status == 'pending'
                            ? Colors.amber
                            : status == 'Overdue'
                                ?
                                //Color(0xFF00CED1)
                                Color.fromARGB(
                                    255, // Alpha component (fully opaque)
                                    194, // Red component
                                    24, // Green component
                                    7, // Blue component
                                  )
                                //
                                : Color.fromARGB(255, 77, 77, 174),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        status == 'complete'
                            ? Text(
                                'Complete',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : status == 'pending'
                                ? Text(
                                    'Pending',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : status == 'Overdue'
                                    ? Text(
                                        'Overdue',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 14.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    : Text(
                                        'Pending',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 14.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                        Text(
                          '$assign',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        '$title',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    admintype == 'employee'
                        ? Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              PopupMenuButton<String>(
                                itemBuilder: (BuildContext context) => [
                                  const PopupMenuItem<String>(
                                    value: 'view',
                                    child: Text('View',
                                        style:
                                            TextStyle(fontFamily: 'Poppins')),
                                  ),
                                  const PopupMenuItem<String>(
                                    value: 'remark',
                                    child: Text('Remark',
                                        style:
                                            TextStyle(fontFamily: 'Poppins')),
                                  ),
                                  if (assignid == mainid)
                                    const PopupMenuItem<String>(
                                      value: 'edit',
                                      child: Text('Update',
                                          style:
                                              TextStyle(fontFamily: 'Poppins')),
                                    ),
                                  if (assignid == mainid)
                                    const PopupMenuItem<String>(
                                      value: 'delete',
                                      child: Text('Delete',
                                          style:
                                              TextStyle(fontFamily: 'Poppins')),
                                    ),
                                  if (status == 'incomplete')
                                    const PopupMenuItem<String>(
                                      value: 'mark',
                                      child: Text('Mark as Complete',
                                          style:
                                              TextStyle(fontFamily: 'Poppins')),
                                    ),
                                  if (status == 'incomplete')
                                    const PopupMenuItem<String>(
                                      value: 'share',
                                      child: Text('Share',
                                          style:
                                              TextStyle(fontFamily: 'Poppins')),
                                    ),
                                ],
                                onSelected: (String value) {
                                  if (value == 'view') {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Viewtask(id: '$id')),
                                    );
                                  } else if (value == 'remark') {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Remark(id: '$id')),
                                    );
                                  } else if (value == 'edit') {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          // builder: (context) => Edit(id: '$id', task:'completed', audiopath: '')),
                                          builder: (context) => EmpEditTaskScreen(
                                              id: '$id',
                                              task: 'completed',
                                              audiopath: '',
                                              backto: 'incompletedlist')),
                                    );
                                  } else if (value == 'mark') {
                                    completetask('$id');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EmpTaskCompletedScreen(),
                                      ),
                                    );
                                  } else if (value == 'delete') {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        content: const Text(
                                            'Are You Sure to Delete?',
                                            style: TextStyle(
                                                fontFamily: 'Poppins')),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                context, 'Cancel'),
                                            child: const Text('Cancel',
                                                style: TextStyle(
                                                    fontFamily: 'Poppins')),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              deletedata('$id');
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      // Taskincompletednew(
                                                      //     admin_type: admintype
                                                      //         .toString()),
                                                  EmpTaskPending()
                                                ),
                                              );
                                            },
                                            child: const Text('OK',
                                                style: TextStyle(
                                                    fontFamily: 'Poppins')),
                                          ),
                                        ],
                                      ),
                                    );
                                  }else if (value == 'share') {
                                    String phoneNumber = '91$mobile';
                                    String message = 'Title: $title\n' +
                                        'Start Time: $date $starttime\n' +
                                        'End Time: $deadline $endtime\n' +
                                        'Assigned by: $assignedby';
                                    launchWhatsApp(phoneNumber, message);
                                  }
                                },
                                icon: Icon(Icons.more_vert),
                              ),

                              // Positioned(
                              //   top: 0,
                              //   child: Icon(Icons.more_vert),
                              // ),
                            ],
                          )
                        : PopupMenuButton<String>(
                            itemBuilder: (BuildContext context) => [
                              const PopupMenuItem<String>(
                                value: 'view',
                                child: Text('View',
                                    style: TextStyle(fontFamily: 'Poppins')),
                              ),
                              const PopupMenuItem<String>(
                                value: 'remark',
                                child: Text('Remark',
                                    style: TextStyle(fontFamily: 'Poppins')),
                              ),
                              const PopupMenuItem<String>(
                                value: 'edit',
                                child: Text('Update',
                                    style: TextStyle(fontFamily: 'Poppins')),
                              ),
                              const PopupMenuItem<String>(
                                value: 'delete',
                                child: Text('Delete',
                                    style: TextStyle(fontFamily: 'Poppins')),
                              ),
                              status == 'incomplete'
                                  ? const PopupMenuItem<String>(
                                      value: 'mark',
                                      child: Text('Mark as Complete',
                                          style:
                                              TextStyle(fontFamily: 'Poppins')),
                                    )
                                  : const PopupMenuItem<String>(
                                      value: '',
                                      child: Text(''),
                                    ),
                              status == 'incomplete'
                                  ? const PopupMenuItem<String>(
                                      value: 'share',
                                      child: Text('Share',
                                          style:
                                              TextStyle(fontFamily: 'Poppins')),
                                    )
                                  : const PopupMenuItem<String>(
                                      value: '',
                                      child: Text(''),
                                    )
                            ],
                            onSelected: (String value) {
                              if (value == 'view') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Viewtask(id: '$id')),
                                );
                              } else if (value == 'edit') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      //builder: (context) => Edit(id: '$id',task:'completed', audiopath: '')),
                                      builder: (context) => EmpEditTaskScreen(
                                          id: '$id',
                                          task: 'completed',
                                          audiopath: '',
                                          backto: 'incompletedlist')),
                                );
                              } else if (value == 'delete') {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    //title: const Text('AlertDialog Title'),
                                    content: const Text(
                                        'Are You Sure to Delete?',
                                        style:
                                            TextStyle(fontFamily: 'Poppins')),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Cancel'),
                                        child: const Text('Cancel',
                                            style: TextStyle(
                                                fontFamily: 'Poppins')),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          deletedata('$id');
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EmpTaskCompletedScreen(),
                                            ),
                                          );
                                        },
                                        child: const Text('OK',
                                            style: TextStyle(
                                                fontFamily: 'Poppins')),
                                      ),
                                    ],
                                  ),
                                );
                              } else if (value == 'remark') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Remark(id: '$id')),
                                );
                              } else if (value == 'mark') {
                                completetask('$id');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EmpTaskCompletedScreen(),
                                  ),
                                );
                              } else if (value == 'share') {
                                String phoneNumber = '91$mobile';
                                String message =
                                    'Hello, I want to share this task with you: $title';
                                launchWhatsApp(phoneNumber, message);
                              }
                            },
                            icon: Icon(Icons.more_vert),
                          ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 24, // Adjust the size of the icon as needed
                      color: Colors.black,
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      '$date',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12.0,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 35.0),
                    Icon(Icons.access_time),
                    SizedBox(width: 10.0),
                    Text(
                      '$deadline',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 35.0),
                      Text(
                        '$starttime',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.0,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: 75.0,
                      ),
                      Text(
                        '$endtime',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ))
            ]),
          ),
        ));
  }
}
