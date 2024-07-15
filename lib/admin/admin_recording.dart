// import 'dart:io';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:record/record.dart';
//
// class RecordingScreen extends StatefulWidget {
//   const RecordingScreen({Key? key}) : super(key: key);
//
//   @override
//   _RecordingScreenState createState() => _RecordingScreenState();
// }
//
// class _RecordingScreenState extends State<RecordingScreen> {
//   late Record audioRecord;
//   late AudioPlayer audioPlayer;
//   bool isRecording = false;
//   String audioPath = "";
//
//   @override
//   void initState() {
//     super.initState();
//     audioPlayer = AudioPlayer();
//     audioRecord = Record();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     audioRecord.dispose();
//     audioPlayer.dispose();
//   }
//
//   bool playing = false;
//   bool recordingNow = true; // renamed from recoding_now
//
//   Future<void> startRecording() async {
//     try {
//       print("START RECORDING +++++++++++++++++++++++++++++++++++++++++++++++++");
//       if (await audioRecord.hasPermission()) {
//         await audioRecord.start();
//         setState(() {
//           isRecording = true;
//         });
//       }
//     } catch (e, stackTrace) {
//       print("START RECORDING ERROR +++++++++++++ ${e.toString()} ++++++++++++ ${stackTrace.toString()} ++++++++++++++++++");
//     }
//   }
//
//   Future<void> stopRecording() async {
//     try {
//       print("STOP RECORDING ++++++++++++++++++++++++++++++++++++++++++++++++++");
//       String? path = await audioRecord.stop();
//       setState(() {
//         recordingNow = false;
//         isRecording = false;
//         audioPath = path!;
//       });
//     } catch (e) {
//       print("STOP RECORDING ERROR +++++++++++++ ${e.toString()} +++++++++++++++++++++++++++");
//     }
//   }
//
//   Future<void> playRecording() async {
//     try {
//       playing = true;
//       setState(() {});
//
//       print("PLAYING AUDIO ++++++++++++++++++++++++++++++++++++++++++++++++++");
//       Source urlSource = UrlSource(audioPath);
//       await audioPlayer.play(urlSource);
//
//       audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
//         if (state == PlayerState.completed) {
//           setState(() {
//             playing = false;
//           });
//         }
//       });
//
//     } catch (e) {
//       print("PLAYING AUDIO ERROR +++++++++++++ ${e.toString()} ++++++++++++++++++");
//     }
//   }
//
//   Future<void> pauseRecording() async {
//     try {
//       playing = false;
//
//       print("PAUSING AUDIO ++++++++++++++++++++++++++++++++++++++++++++++++++");
//
//       await audioPlayer.pause();
//       setState(() {});
//
//     } catch (e) {
//       print("PAUSING AUDIO ERROR +++++++++++++ ${e.toString()} ++++++++++++++++++");
//     }
//   }
//
//   Future<void> uploadAndDeleteRecording() async {
//     try {
//       final url = Uri.parse('http://103.159.85.246:4000/api/task/create'); // Replace with your server's upload URL
//
//       final file = File(audioPath);
//       if (!file.existsSync()) {
//         print("UPLOADING FILE NOT EXIST +++++++++++++++++++++++++++++++++++++++++++++++++");
//         return;
//       }
//
//       print("UPLOADING FILE ++++++++++++++++ ${audioPath} ++++++++++++++++++++++++++++++++");
//       final request = http.MultipartRequest('POST', url)
//         ..files.add(
//           http.MultipartFile(
//             'audio',
//             file.readAsBytes().asStream(),
//             file.lengthSync(),
//             filename: 'audio.mp3', // You may need to adjust the file extension
//           ),
//         );
//
//       final response = await http.Response.fromStream(await request.send());
//
//       if (response.statusCode == 200) {
//         // Upload successful, you can delete the recording if needed
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Audio uploaded.'),
//           ),
//         );
//
//         setState(() {
//           audioPath = "";
//         });
//       } else {
//         // Handle the error or show an error message
//         print('Failed to upload audio. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error uploading audio: $e');
//     }
//   }
//
//   Future<void> deleteRecording() async {
//     if (audioPath.isNotEmpty) {
//       try {
//         recordingNow = true;
//         File file = File(audioPath);
//         if (file.existsSync()) {
//           file.deleteSync();
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Recording deleted'),
//             ),
//           );
//         }
//       } catch (e) {
//         print("FILE NOT DELETED +++++++++++++ ${e.toString()} +++++++++++++++++++++++++++");
//       }
//
//       setState(() {
//         audioPath = "";
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Voice Recorder'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             if (recordingNow)
//               IconButton(
//                 icon: isRecording
//                     ? const Icon(Icons.fiber_manual_record, color: Colors.red, size: 50)
//                     : const Icon(Icons.mic_none, color: Colors.red, size: 50),
//                 onPressed: isRecording ? stopRecording : startRecording,
//               ),
//             if (!recordingNow)
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   IconButton(
//                     icon: !playing
//                         ? const Icon(Icons.play_circle, color: Colors.green, size: 50)
//                         : const Icon(Icons.pause_circle, color: Colors.green, size: 50),
//                     onPressed: !playing ? playRecording : pauseRecording,
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.delete, color: Colors.red, size: 50),
//                     onPressed: deleteRecording,
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.trending_up, color: Colors.green, size: 50),
//                     onPressed: uploadAndDeleteRecording,
//                   ),
//                 ],
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:followup/admin/admin_add_task.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:record_mp3/record_mp3.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:intl/intl.dart' show DateFormat;
import 'package:followup/constant/conurl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

String? title;
String? description;
String? startdate;
String? deadlinedate;
String? starttime;
String? endtime;
String? image;
String? name;
var uuid = Uuid();
var uniqueId = uuid.v1();

class RecordingScreen extends StatefulWidget {

  final String? title;
  final String? description;
  final String? startdate;
  final String? deadlinedate;
  final String? starttime;
  final String? endtime;
  final String? image;
  final String? names;

  RecordingScreen({
    this.title,
    this.startdate,
    this.deadlinedate,
    this.starttime,
    this.endtime,
    this.image, this.description, this.names,
  });
  @override
  _RecordingScreenState createState() => _RecordingScreenState();
}

class _RecordingScreenState extends State<RecordingScreen> {
  Timer? _timer;
  int? randomNumber;
  int _secondsElapsed = 0;
  String statusText = "";
  bool isComplete = false;

  bool _playAudio = false;
  bool _isTimerRunning = false;
  ElevatedButton createElevatedButton({
    required IconData icon,
    required Color iconColor,
    required void Function() onPressFunc,
  }) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(6.0),
        backgroundColor: Colors.white,
        side: BorderSide(
          color: Colors.red,
          width: 4.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 9.0,
      ),
      onPressed: onPressFunc,
      icon: Icon(
        icon,
        color: iconColor,
        size: 38.0,
      ),
      label: Text(''),
    );
  }

  void _startTimer() {
    if (!_isTimerRunning) {
      _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
        setState(() {
          _secondsElapsed++;
        });
      });
      _isTimerRunning = true;
    }
  }

  void _stopTimer() {
    if (_isTimerRunning) {
      _timer?.cancel();
      _isTimerRunning = false;
    }
  }

  String _getFormattedTime() {
    int minutes = _secondsElapsed ~/ 60;
    int seconds = _secondsElapsed % 60;
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }



  @override
  void initState() {
    super.initState();
    title = widget.title;
    startdate = widget.startdate;
    deadlinedate = widget.deadlinedate;
    starttime = widget.starttime;
    endtime = widget.endtime;
    image = widget.image;
    getdata();
  }

  void getdata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('titleaudio', title.toString());
    preferences.setString('descriptionaudio', title.toString());
    preferences.setString('startdateaudio', startdate.toString());
    preferences.setString('deadlinedateaudio', deadlinedate.toString());
    preferences.setString('starttimeaudio', starttime.toString());
    preferences.setString('endtimeaudio', endtime.toString());
    preferences.setString('imageaudio', image.toString());
    preferences.setString('name', name.toString());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      // appBar: AppBar(title: Text('Audio Recording and Playing')),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFFFD700),
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
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
              'Record Audio',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                color: AppString.appgraycolor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: AppString.appgraycolor),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminAddTask(
                      audioPath: "",
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Container(
              child: Center(
                child: Text(
                  _getFormattedTime(),
                  style: TextStyle(fontSize: 70, color: Colors.red),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                createElevatedButton(
                  icon: Icons.mic,
                  iconColor: Colors.red,
                  onPressFunc: () async {
                    startRecord();
                  },
                ),
                SizedBox(
                  width: 30,
                ),
                createElevatedButton(
                    icon: Icons.stop,
                    iconColor: Colors.red,
                    onPressFunc: () {
                      stopRecord();
                    }),
              ],
            ),
            SizedBox(
              height: 20,
            ),



            ElevatedButton(
              style:
              ElevatedButton.styleFrom(elevation: 9.0, backgroundColor: Colors.red),
              child: Text('Upload', style: TextStyle(fontFamily: 'Poppins')),
              onPressed: () {
                stopRecord();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminAddTask(
                      audioPath: recordFilePath,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> checkPermission() async {
    if (!await Permission.microphone.isGranted) {
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  void startRecord() async {
    _startTimer();
    bool hasPermission = await checkPermission();
    if (hasPermission) {
      statusText = "Recording...";
      recordFilePath = await getFilePath();
      isComplete = false;
      RecordMp3.instance.start(recordFilePath, (type) {
        statusText = "Record error--->$type";
        setState(() {});
      });
    } else {
      statusText = "No microphone permission";
    }
    setState(() {});
  }

  void pauseRecord() {
    _stopTimer();
    if (RecordMp3.instance.status == RecordStatus.PAUSE) {
      bool s = RecordMp3.instance.resume();
      if (s) {
        statusText = "Recording...";
        setState(() {});
      }
    } else {
      bool s = RecordMp3.instance.pause();
      if (s) {
        statusText = "Recording pause...";
        setState(() {});
      }
    }
  }

  void stopRecord() {
    _stopTimer();
    bool s = RecordMp3.instance.stop();
    if (s) {
      statusText = "Record complete";
      isComplete = true;
      setState(() {});
    }
  }

  void resumeRecord() {
    bool s = RecordMp3.instance.resume();
    if (s) {
      statusText = "Recording...";
      setState(() {});
    }
  }

  String recordFilePath = '';

  void play() {
    print('recordFilePath' + recordFilePath);
    if (recordFilePath != null && File(recordFilePath).existsSync()) {
      AudioPlayer audioPlayer = AudioPlayer();
      //audioPlayer.play(recordFilePath, isLocal: true);
    }
  }

  int i = 0;
  Future<String> getFilePath() async {
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath = storageDirectory.path + "/record";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    var newid = uuid.v1();
    //print("chkname: $newid");
    return sdPath + "/${newid}.mp3";
  }
}
