import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import '../generated/assets.dart';
import '../routes/route.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Subscription Successful!",textAlign: TextAlign.center,style: TextStyle(color:Colors.green,fontWeight: FontWeight.bold,fontSize: 22.sp),),
          Lottie.asset(Assets.animationsSuccess,height: 25.h),
          Text("Thank you for subscribing to our app. You're now part of our community!",textAlign: TextAlign.center,style: TextStyle(color:Colors.green,fontWeight: FontWeight.bold,fontSize: 16.sp),),
          SizedBox(height: 5.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Get.offAllNamed(Routes.EMP_DASHBOARD_ROUTE);
                },
                child: Padding(
                  padding: EdgeInsets.all(4.w).add(EdgeInsets.symmetric(horizontal: 4.w)),
                  child: Text('Done',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16.sp),),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color.fromRGBO(143, 148, 251, 1)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), // Adjust as per your requirement
                      // You can also set other properties like border color, width, etc.
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      )
    );
  }
}
